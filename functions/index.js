'use-strict'

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);


exports.createAgent = functions.https.onCall((data, context) => {
  return  admin.auth().createUser({
        uid: data['Agentuid'],
        email: data["email"],
        password: data['password']
    })
        
        .catch(function (error) {
            console.log('Error creating new user:', error);
        });
});

exports.deleteAgent = functions.https.onCall((data, context) => {
   return  admin.auth().deleteUser({
        uid: data['Agentuid'],
    });

});