importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDjuE4nzYaXwy2CbWj2niwQlXwXy0MxomE",
  authDomain: "yangon-driving-school.firebaseapp.com",
  projectId: "yangon-driving-school",
  storageBucket: "yangon-driving-school.appspot.com",
  messagingSenderId: "562606680354",
  appId: "1:562606680354:web:d01d8c2af1341425ea5d7b",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});