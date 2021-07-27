const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendNotificationToTemperature =
functions.firestore.document("Tam_feed/84TBH23hP7M0ltBAXHCo")
    .onUpdate(async (change) => {
      const after = change.after.data();
      const valueAfter = parseFloat(after.data.split("-")[0]);
      const valueBefore = parseFloat(change.before.data().data.split("-")[0]);

      const token = [];
      const userRef = await admin.firestore().collection("users").get();
      for (const user of userRef.docs) {
        const notiRef = await admin.firestore().collection("users")
            .doc(user.id).collection("notification").get();
        for (const noti of notiRef.docs) {
          const minThreshold = noti.data().temperature["min"];
          const maxThreshold = noti.data().temperature["max"];
          const subscribed = noti.data().temperature["subscribed"];
          if (
            ((valueAfter < minThreshold && valueBefore > minThreshold + 1) ||
            (valueAfter > maxThreshold && valueBefore < maxThreshold - 1)) &&
            subscribed == true
          ) {
            token.push(user.data().token);
            break;
          }
        }
      }
      const payload = {
        notification: {
          title: "Temperature Warning!",
          body: "Current room's temperature: " + valueAfter.toString() + "°C.",
          sound: "default",
        },
      };

      console.log("token = ", token);
      if (token.length > 0) {
        return admin.messaging().sendToDevice(token, payload);
      } else return null;
    });

exports.sendNotificationToHumidity =
functions.firestore.document("Tam_feed/84TBH23hP7M0ltBAXHCo")
    .onUpdate(async (change) => {
      const after = change.after.data();
      const valueAfter = parseFloat(after.data.split("-")[1]);
      const valueBefore = parseFloat(change.before.data().data.split("-")[1]);

      const token = [];
      const userRef = await admin.firestore().collection("users").get();
      for (const user of userRef.docs) {
        const notiRef = await admin.firestore().collection("users")
            .doc(user.id).collection("notification").get();
        for (const noti of notiRef.docs) {
          const minThreshold = noti.data().humidity["min"];
          const maxThreshold = noti.data().humidity["max"];
          const subscribed = noti.data().humidity["subscribed"];
          if (
            ((valueAfter < minThreshold && valueBefore > minThreshold + 1) ||
            (valueAfter > maxThreshold && valueBefore < maxThreshold - 1)) &&
            subscribed == true
          ) {
            token.push(user.data().token);
            break;
          }
        }
      }
      const payload = {
        notification: {
          title: "Humidity Warning!",
          body: "Current room's humidity: " + valueAfter.toString() + "%",
          sound: "default",
        },
      };

      console.log("token = ", token);
      if (token.length > 0) {
        return admin.messaging().sendToDevice(token, payload);
      } else return null;
    });

exports.sendNotificationToLight =
functions.firestore.document("Tam_feed/bc1EFVcnrsWfJieBsVin")
    .onUpdate((change) => {
      const after = change.after.data();
      const payload = {
        notification: {
          title: "FLIPPED",
          body: "Someone just turned on device.",
          sound: "default",
        },
      };

      if (after.data == "1") {
        return admin.messaging().sendToTopic(after.name, payload);
      }
      return null;
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
        name: "Living Room",
        light: false,
        temperature: {
          subscribed: false,
          min: 16,
          max: 32,
        },
        humidity: {
          subscribed: false,
          min: 20,
          max: 80,
        },
      }).then(() => {
        return admin.messaging().send(message);
      });
    });
