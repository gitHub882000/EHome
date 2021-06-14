const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendNotificationToTemperature =
functions.firestore.document("Tam_feed/84TBH23hP7M0ltBAXHCo")
    .onUpdate((change) => {
      const after = change.after.data();
      const valueAfter = after.data.split("-")[0];
      const valueBefore = parseFloat(change.before.data().data.split("-")[0]);
      let title;
      if (parseFloat(valueAfter) < 16 && valueBefore > 18) {
        title = "Low";
      } else if (parseFloat(valueAfter) > 32 && valueBefore < 30) {
        title = "High";
      } else {
        return;
      }
      const payload = {
        notification: {
          title: title + " temperature",
          body: "Current room's temperature: " + valueAfter + "°C.",
          sound: "default",
        },
      };

      return admin.messaging().sendToTopic(after.name, payload);
    });

exports.sendNotificationToLight =
functions.firestore.document("Tam_feed/bc1EFVcnrsWfJieBsVin")
    .onUpdate((change) => {
      const after = change.after.data();
      const payload = {
        notification: {
          title: "Flipped",
          body: "Someone just turned on the light.",
          sound: "default",
        },
      };

      if (after.data == "1") {
        return admin.messaging().sendToTopic(after.name, payload);
      }
      return;
    });

exports.initNotificationSettings =
functions.firestore.document("users/{userId}")
    .onCreate((snap, context) => {
      const userId = context.params.userId;
      const notification =
      admin.firestore().collection("users")
          .doc(userId).collection("notification");
      const message = {
        notification: {
          title: "Registered FCM successfully",
          body: "You can now configure your notification subscription.",
        },
        token: snap.data().token,
      };

      return notification.add({
        room: "Living Room",
        light: false,
        temperature: false,
      }).then(() => {
        return admin.messaging().send(message);
      });
    });
