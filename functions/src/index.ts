import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// ##############################################
// ############### LOGIN / SIGNUP ###############
// ##############################################
exports.createProfile = functions
    .region('europe-west3')
    .auth.user()
    .onCreate((user) => {

        const profiles = admin.firestore().collection('profile');

        //create new profile
        return profiles.doc(user.uid).set({
            id: user.uid,
            tasks: [],
            groups: [],
            groupIds: [],
        });
    });

exports.deleteProfile = functions
    .region('europe-west3')
    .auth.user()
    .onDelete((user) => {
        const profiles = admin.firestore().collection('profile');

        return profiles.doc(user.uid).delete();
    });



// ##############################################
// ############# PERSONAL TASKS #############
// ##############################################
exports.createPersonalTask = functions
    .region('europe-west3')
    .firestore.document('profile/{userId}/tasks/{taskId}')
    .onCreate((snap, context) => {
        const userId = context.params.userId;
        const taskId = context.params.taskId;

        const newValue = snap.data();

        if (!newValue.userId) {
            newValue.userId = userId;
        }
        if (!newValue.taskId) {
            newValue.taskId = taskId;
        }


        return Promise.all([
            //fulfill the request by creating new task in profile/tasks.
            snap.ref.set(newValue, { merge: true }),
            //add task to the index array in the profile profile itself.
            admin.firestore().doc(`profile/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayUnion(newValue)
            })
        ]);

    });

exports.updatePersonalTask = functions
    .region('europe-west3')
    .firestore.document('profile/{userId}/tasks/{taskId}')
    .onUpdate((change, context) => {
        const userId = context.params.userId;
        // const taskId = context.params.taskId;

        const newValue = change.after.data();
        const previousValue = change.before.data();

        return Promise.all([
            //delete old task from index array
            admin.firestore().doc(`profile/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayRemove(previousValue)
            }),
            //add the new task to the index array AND update in task subcollection
            admin.firestore().doc(`profile/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayUnion(newValue)
            }),
            //update it in subcollection
            change.after.ref.set(newValue, { merge: true })
        ]);
    });

exports.deletePersonalTask = functions
    .region('europe-west3')
    .firestore.document('profile/{userId}/tasks/{taskId}')
    .onDelete((snap, context) => {
        const userId = context.params.userId;
        // const taskId = context.params.taskId;

        const deletedValue = snap.data();

        return Promise.all([
            //first delete old task from index array
            admin.firestore().doc(`profile/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayRemove(deletedValue)
            }),
            //then delete it from subcollection
            snap.ref.delete()
        ]);
    });

// ##############################################
// ################# GROUPS #################
// ##############################################
exports.createGroup = functions
    .region('europe-west3')
    .firestore.document('group/{groupId}')
    .onCreate((snap, context) => {
        const groupId = context.params.groupId;

        const newValue = snap.data();

        if (!newValue.groupId) {
            newValue.groupId = groupId;
        }
        if (!newValue.tasks) {
            newValue.tasks = [];
        }

        return Promise.all([
            //add group to its collection
            snap.ref.set(newValue, { merge: true }),
            //and add group to the group index
            admin.firestore().doc(`global/groupIndex`).update({
                groups: admin.firestore.FieldValue.arrayUnion(newValue)
            })
        ]);
    });

exports.updateGroup = functions
    .region('europe-west3')
    .firestore.document('group/{groupId}')
    .onUpdate((change, context) => {
        const returnPromises = [] as Array<Promise<any>>;
        const groupId = context.params.groupId;

        const newValue = change.after.data();
        const previousValue = change.before.data();

        const members = newValue.members as Array<String>;

        members.forEach(memberId => {
            returnPromises.push(
                admin.firestore().doc(`profile/${memberId}`).get().then(
                    (profileSnap) => {
                        let searchGroup;
                        const searchDoc = profileSnap.data()?.groups as Array<any>;
                        searchDoc.forEach(group => {
                            if(group.groupId === groupId) {
                                searchGroup = group;
                            }
                        });

                        const groupForPlayer = newValue;
                        delete groupForPlayer.members;

                        return Promise.all([
                            //delete old group (the found one) from index array
                            admin.firestore().doc(`profile/${memberId}`).update({
                                groups: admin.firestore.FieldValue.arrayRemove(searchGroup)
                            }),
                            //add the updated group to the index array
                            admin.firestore().doc(`profile/${memberId}`).update({
                                groups: admin.firestore.FieldValue.arrayUnion(groupForPlayer)
                            }),
                        ]);
                    }
                )
            );
        });

        returnPromises.concat([
            //delete old task from index array
            admin.firestore().doc(`global/groupIndex`).update({
                groups: admin.firestore.FieldValue.arrayRemove(previousValue)
            }),
            //add the new task to the index array AND update in task subcollection
            admin.firestore().doc(`global/groupIndex`).update({
                groups: admin.firestore.FieldValue.arrayUnion(newValue)
            }),
            //update it in subcollection
            change.after.ref.set(newValue, { merge: true })
        ]);

        return Promise.all(returnPromises);
    });

exports.deleteGroup = functions
    .region('europe-west3')
    .firestore.document('group/{groupId}')
    .onDelete((snap, context) => {
        const returnPromises = [] as Array<Promise<any>>;
        const groupId = context.params.groupId;

        const deletedValue = snap.data();

        const members = deletedValue.members as Array<String>;

        members.forEach(memberId => {
            returnPromises.push(
                admin.firestore().doc(`profile/${memberId}`).get().then(
                    (profileSnap) => {
                        let searchGroup;
                        const searchDoc = profileSnap.data()?.groups as Array<any>;
                        searchDoc.forEach(group => {
                            if(group.groupId === groupId) {
                                searchGroup = group;
                            }
                        });

                        const groupForPlayer = deletedValue;
                        delete groupForPlayer.members;

                        return Promise.all([
                            //delete old group (the found one) from index array
                            admin.firestore().doc(`profile/${memberId}`).update({
                                groups: admin.firestore.FieldValue.arrayRemove(searchGroup)
                            }),
                            //delete old group from groupIds
                            admin.firestore().doc(`profile/${memberId}`).update({
                                groupIds: admin.firestore.FieldValue.arrayRemove(groupId)
                            }),
                        ]);
                    }
                )
            );
        });

        returnPromises.concat([
            //delete task from index array
            admin.firestore().doc(`global/groupIndex`).update({
                groups: admin.firestore.FieldValue.arrayRemove(deletedValue)
            }),
            //delete it in subcollection
            snap.ref.delete()
        ]);

        return Promise.all(returnPromises);
    });

// ##############################################
// ############# TASKS IN GROUPS ############
// ##############################################
exports.addGroupTask = functions
    .region('europe-west3')
    .firestore.document('group/{groupId}/tasks/{taskId}')
    .onCreate((snap, context) => {
        // const returnPromises = [] as Array<Promise<any>>;
        const groupId = context.params.groupId;
        const taskId = context.params.taskId;

        const newValue = snap.data();

        if (!newValue.groupId) {
            newValue.groupId = groupId;
        }
        if (!newValue.taskId) {
            newValue.taskId = taskId;
        }

        return Promise.all([
            //fulfill the request by creating new task in group/tasks.
            snap.ref.set(newValue, { merge: true }),
            //add task to the index array in the group itself.
            admin.firestore().doc(`group/${groupId}`).update({
                tasks: admin.firestore.FieldValue.arrayUnion(newValue)
            })
        ]);
    });

exports.updateGroupTask = functions
    .region('europe-west3')
    .firestore.document('group/{groupId}/tasks/{taskId}')
    .onUpdate((change, context) => {
        const groupId = context.params.groupId;
        // const taskId = context.params.taskId;

        const newValue = change.after.data();
        const previousValue = change.before.data();

        //TODO: update in all member lists

        return Promise.all([
            //delete old task from index array
            admin.firestore().doc(`group/${groupId}`).update({
                tasks: admin.firestore.FieldValue.arrayRemove(previousValue)
            }),
            //add the new task to the index array AND update in task subcollection
            admin.firestore().doc(`group/${groupId}`).update({
                tasks: admin.firestore.FieldValue.arrayUnion(newValue)
            }),
            //update it in subcollection
            change.after.ref.set(newValue, { merge: true })
        ]);
    });

exports.deleteGroupTask = functions
    .region('europe-west3')
    .firestore.document('group/{groupId}/tasks/{taskId}')
    .onDelete((snap, context) => {
        const groupId = context.params.groupId;
        // const taskId = context.params.taskId;

        const deletedValue = snap.data();

        //TODO: delete in all member lists
        
        return Promise.all([
            //first delete old task from index array
            admin.firestore().doc(`group/${groupId}`).update({
                tasks: admin.firestore.FieldValue.arrayRemove(deletedValue)
            }),
            //then delete it from subcollection
            snap.ref.delete()
        ]);
    });

// ##############################################
// ############## MEMBERS IN GROUPS #############
// ##############################################
exports.joinOrLeaveGroup = functions
    .region('europe-west3')
    .firestore.document('profile/{userId}')
    .onUpdate((change, context) => {
        const returnPromises = [] as Array<Promise<any>>;
        const userId = context.params.userId;

        const newValue = change.after.data();
        const previousValue = change.before.data();

        //check if groupId was added to groups array
        let newGroupIds = newValue.groupIds as Array<String>;
        let prevGroupIds = previousValue.groupIds as Array<String>;

        newGroupIds = newGroupIds ? newGroupIds : [];
        prevGroupIds = prevGroupIds ? prevGroupIds : [];

        const addedGroups = newGroupIds.filter(x => !prevGroupIds.includes(x));
        const removedGroups = prevGroupIds.filter(x => !newGroupIds.includes(x));

        addedGroups.forEach(groupId => {
            returnPromises.push(
                //first get group by id
                admin.firestore().doc(`group/${groupId}`).get()
                    //then add group object to this profiles groups array
                    .then((groupSnap) => {
                        const indexGroup = groupSnap.data();
                        if (indexGroup) {
                            delete indexGroup.members;
                        }
                        
                        return Promise.all([
                        admin.firestore().doc(`profile/${userId}`).update({
                            groups: admin.firestore.FieldValue.arrayUnion(indexGroup)
                        }),
                        groupSnap.ref.update({
                            members: admin.firestore.FieldValue.arrayUnion(userId)
                        })]);
                })
            );
        });
        removedGroups.forEach(groupId => {
            returnPromises.push(
                //first get group by id
                admin.firestore().doc(`group/${groupId}`).get()
                    //then remove group object from this profiles groups array
                    .then((groupSnap) => {
                        let searchGroup;
                        const searchDoc = newValue.groups as Array<any>;
                        searchDoc.forEach(group => {
                            if(group.groupId === groupSnap?.data()?.groupId) {
                                searchGroup = group;
                            }
                        });

                        return Promise.all([
                        admin.firestore().doc(`profile/${userId}`).update({
                            groups: admin.firestore.FieldValue.arrayRemove(searchGroup)
                        }),
                        groupSnap.ref.update({
                            members: admin.firestore.FieldValue.arrayRemove(userId)
                        })
                    ]);})
            );
        });

        return Promise.all(returnPromises);
    });