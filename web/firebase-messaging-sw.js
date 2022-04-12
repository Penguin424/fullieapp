importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyB3wMCmmv1UsgflmGMeiuvP5C810kNXjwg",
    authDomain: "fullie-40469.firebaseapp.com",
    projectId: "fullie-40469",
    storageBucket: "fullie-40469.appspot.com",
    messagingSenderId: "757978438389",
    appId: "1:757978438389:web:31e4e9552fab61333b03bc",
    measurementId: "G-6R8SM2537M"
  };

  // Initialize Firebase
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();
