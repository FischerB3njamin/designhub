const admin = require('firebase-admin');

const sendNotification = (token, title, body, data) => {
  if (!token) {
    console.log("No FCM token provided.");
    return null;
  }

  const message = {
    token,
    notification: { title, body },
    data,
  };

  return admin.messaging().send(message);
};

module.exports = { sendNotification };
