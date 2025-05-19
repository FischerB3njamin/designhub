const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const { buildItemText, decodeBase64 } = require("./utils/helper.js");
const { getUserProfile, getChatDocument } = require("./services/firestoreService.js");
const { sendNotification } = require("./services/notificationService");

// 🔔 News Notification
exports.sendNewsNotification = functions.firestore.document("news/{newsId}")
  .onCreate(async (snap, context) => {
    const { profilId, type, creatorId } = snap.data();
    if (!profilId || !creatorId) return null;

    const { token } = await getUserProfile(profilId);
    const { name: creatorName } = await getUserProfile(creatorId);

    const body = buildItemText(creatorName, type);
    const data = { type: "news", newsId: context.params.newsId };

    return sendNotification(token, "News", body, data);
  });

// 💬 Chat Notification
exports.sendChatNotification = functions.firestore
  .document("chats/{chatId}")
  .onWrite(async (change, context) => {
    const beforeData = change.before.exists ? change.before.data() : null;
    const afterData = change.after.exists ? change.after.data() : null;


    // Check if lastMessage or lastSenderId changed
    if (
      beforeData.lastMessage === afterData.lastMessage &&
      beforeData.lastSenderId === afterData.lastSenderId
    ) {
      return null;
    }

    const { lastSenderId, lastMessage } = afterData;
    const receiverId = chat.participants.find(id => id !== lastSenderId);
    const { token } = await getUserProfile(receiverId);
    const { name: senderName } = await getUserProfile(lastSenderId);

    const decodedMessage = decodeBase64(lastMessage || '');
    const body = decodedMessage || "You received a new message!";
    const data = { type: "chat", chatId };

    return sendNotification(token, senderName, body, data);

  });
