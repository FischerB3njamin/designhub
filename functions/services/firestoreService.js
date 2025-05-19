const admin = require('firebase-admin');

const getUserProfile = async (id) => {
  const doc = await admin.firestore().collection('profiles').doc(id).get();
  const data = doc.data() || {};
  return { token: data.fcmToken, name: data.name || 'Someone' };
};

const getChatDocument = async (chatId) => {
  const doc = await admin.firestore().collection('chats').doc(chatId).get();
  return doc.exists ? doc.data() : null;
};

module.exports = { getUserProfile, getChatDocument };
