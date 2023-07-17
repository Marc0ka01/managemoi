import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import errorHandler from './errorHandler'
import {api} from './api'
import $ from 'jquery';
window.$ = window.jQuery = $;
import VueApexCharts from "vue3-apexcharts";


// bootstrap files
import './assets/vendor/bootstrap/css/bootstrap.min.css'
import './assets/vendor/bootstrap-icons/bootstrap-icons.css'
import './assets/vendor/bootstrap/js/bootstrap.bundle.min.js'
// boxicons
import './assets/vendor/boxicons/css/boxicons.min.css'
// quill
import './assets/vendor/quill/quill.snow.css'
import './assets/vendor/quill/quill.bubble.css'
import './assets/vendor/remixicon/remixicon.css'
import './assets/vendor/quill/quill.min.js'
// simple datatables
import './assets/vendor/simple-datatables/style.css'
import './assets/vendor/simple-datatables/simple-datatables.js'
// tinymce
import './assets/vendor/tinymce/tinymce.min.js'
// apexcharts
import './assets/vendor/apexcharts/apexcharts.min.js'
// chart
// echarts
import './assets/vendor/echarts/echarts.min.js'

import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics"


// Configurer un intercepteur pour les erreurs
api.interceptors.response.use(
    response => response,
    error => {
        errorHandler(error, router);
        return Promise.reject(error);
    }
);


const firebaseConfig = {
    apiKey: "AIzaSyAaVaVVco7cnROkwl1BYZxTZRb7DmxiNVw",
    authDomain: "managemoi-7640c.firebaseapp.com",
    projectId: "managemoi-7640c",
    storageBucket: "managemoi-7640c.appspot.com",
    messagingSenderId: "366701199205",
    appId: "1:366701199205:web:6b10f3518c8d0e55d8eb8c",
    measurementId: "G-BJCV9FKLB2"
};

// Initialize Firebase
const apps = initializeApp(firebaseConfig);
const analytics = getAnalytics(apps);

const app = createApp(App)
app.use(VueSweetalert2)
app.use(router)
app.use(VueApexCharts);
app.mount('#app')
