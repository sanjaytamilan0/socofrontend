//importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
//importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');
//
//firebase.initializeApp({
//  apiKey: "your-api-key",
//  authDomain: "your-auth-domain",
//  projectId: "your-project-id",
//  storageBucket: "your-storage-bucket",
//  messagingSenderId: "your-messaging-sender-id",
//  appId: "your-app-id"
//});
//
//const messaging = firebase.messaging();
//
//messaging.onBackgroundMessage(function(payload) {
//  console.log('Received background message ', payload);
//  const notificationTitle = payload.notification.title;
//  const notificationOptions = {
//    body: payload.notification.body,
//  };
//
//  self.registration.showNotification(notificationTitle, notificationOptions);
//});
