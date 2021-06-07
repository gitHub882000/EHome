const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendNotificationToTopic =
functions.firestore.document("Tam_feed/{feedId}").onUpdate((change) => {
  const after = change.after.data();
  const payload = {
    notification: {
      title: after.name + " is out side acceptable range",
      body: "Room's " + after.name + " is at " + after.value,
      sound: "default",
    },
  };

  switch (after.name) {
    case "SOUND":
      if (after.value == "ON") {
        return admin.messaging().sendToTopic(after.name, payload);
      }
      break;
    case "LIGHT":
      if (after.value == "OFF") {
        return admin.messaging().sendToTopic(after.name, payload);
      }
      break;
    case "TEMP-HUMID":
      const value = after.value.split('-');
      if(parseFloat(value[0]) < 16 || parseFloat(value[0]) > 32){
        return admin.messaging().sendToTopic(after.name, payload);
      }
      break;
  }
  return;
});

exports.sendNotificationAboutSwitch = 
functions.firestore.document("Tam_feed/bc1EFVcnrsWfJieBsVin").onUpdate((change) => {
  const after = change.after.data();
  const payload = {
    notification: {
      title: "Switch Toggled",
      body: "Someone just turned on the light",
      sound: "default",
    },
  };

  if(after.value == "1") return admin.messaging().sendToTopic(after.name, payload);
  return;
});
