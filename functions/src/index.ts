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

        const profiles = admin.firestore().collection('player');

        //create new profile with two subcollections
        return profiles.doc(user.uid).set({
            id: user.uid,
            tasks: [],
            groups: [],
        }).then(() => admin.firestore().doc(`player/${user.uid}/tasks/testTask`).set({
            name: "testTask"
        })).then(() => admin.firestore().doc(`player/${user.uid}/groups/testGroup`).set({
            name: "testGroup"
        }));
    });

exports.deleteProfile = functions
    .region('europe-west3')
    .auth.user()
    .onDelete((user) => {
        const profiles = admin.firestore().collection('player');

        return profiles.doc(user.uid).delete();
    });



// ##############################################
// ############# PERSONAL TASKS #############
// ##############################################
exports.addPersonalTask = functions
    .region('europe-west3')
    .firestore.document('player/{userId}/tasks/{taskId}')
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
            //fulfill the request by creating new task in player/tasks.
            snap.ref.set(newValue, { merge: true }),
            //add task to the index array in the player profile itself.
            admin.firestore().doc(`player/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayUnion(newValue)
            })
        ]);

    });

exports.updatePersonalTask = functions
    .region('europe-west3')
    .firestore.document('player/{userId}/tasks/{taskId}')
    .onUpdate((change, context) => {
        const userId = context.params.userId;
        // const taskId = context.params.taskId;

        const newValue = change.after.data();
        const previousValue = change.before.data();

        return Promise.all([
            //delete old task from index array
            admin.firestore().doc(`player/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayRemove(previousValue)
            }),
            //add the new task to the index array AND update in task subcollection
            admin.firestore().doc(`player/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayUnion(newValue)
            }),
            //update it in subcollection
            change.after.ref.set(newValue, { merge: true })
        ]);
    });

exports.deletePersonalTask = functions
    .region('europe-west3')
    .firestore.document('player/{userId}/tasks/{taskId}')
    .onDelete((snap, context) => {
        const userId = context.params.userId;
        // const taskId = context.params.taskId;

        const deletedValue = snap.data();

        //first delete old task from index array
        return Promise.all([
            admin.firestore().doc(`player/${userId}`).update({
                tasks: admin.firestore.FieldValue.arrayRemove(deletedValue)
            }),
            //then delete it from subcollection
            snap.ref.delete()
        ]);
    });

// ##############################################
// ################# GROUPS #################
// ##############################################
exports.addGroup = functions
    .region('europe-west3')
    .firestore.document('groups/{groupId}')
    .onCreate((snap, context) => {
        const groupId = context.params.groupId;

        const newValue = snap.data();

        if (!newValue.groupId) {
            newValue.groupId = groupId;
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
    .firestore.document('groups/{groupId}')
    .onUpdate((change, context) => {
        // const groupId = context.params.groupId;

        const newValue = change.after.data();
        const previousValue = change.before.data();

        //TODO update Group in all member profiles

        return Promise.all([
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
    });

exports.deleteGroup = functions
    .region('europe-west3')
    .firestore.document('groups/{groupId}')
    .onDelete((snap, context) => {
        // const groupId = context.params.groupId;

        const deletedValue = snap.data();

        //TODO delete Group in all member profiles

        return Promise.all([
            //delete task from index array
            admin.firestore().doc(`global/groupIndex`).update({
                groups: admin.firestore.FieldValue.arrayRemove(deletedValue)
            }),
            //delete it in subcollection
            snap.ref.delete()
        ]);
    });

// ##############################################
// ############# TASKS IN GROUPS ############
// ##############################################
// exports.addGroupTask = functions.region('europe-west3')
// exports.updateGroupTask = functions.region('europe-west3')
// exports.deleteGroupTask = functions.region('europe-west3')

// ##############################################
// ############## MEMBERS IN GROUPS #############
// ##############################################
// exports.joinGroup = functions.region('europe-west3')
// exports.leaveGroup = functions.region('europe-west3')