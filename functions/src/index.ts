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



exports.createProfile = functions
    .region('europe-west3')
    .auth.user()
    .onCreate((user) => {

        const profiles = admin.firestore().collection('profiles');

        return profiles.doc(user.uid).set({
            id: user.uid,
            tasks: [],
            groups: [],
        });
    });

exports.deleteProfile = functions
    .region('europe-west3')
    .auth.user()
    .onDelete((user) => {
        const profiles = admin.firestore().collection('profiles');

        return profiles.doc(user.uid).delete();
    });