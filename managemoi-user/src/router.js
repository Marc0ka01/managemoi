import { createRouter, createWebHistory } from 'vue-router'
import store from './store'
import Register from './views/Register.vue'
import Login from './views/Login.vue'
import Home from './views/Home.vue'
import Dashboard from './layouts/Dashboard.vue'
import Missions from './layouts/Missions.vue'
import MissionDetail from './layouts/MissionDetail.vue'
import Soumission from './layouts/Soumission.vue'
import Versement from './layouts/Versement.vue'
import Message from './layouts/Message.vue'


const routes = [
    { path: '/inscription', component: Register, name: 'inscription' },
    { path: '/connexion', component: Login, name: 'connexion' },
    {
        path: '/', component: Home, name: 'home', children: [
            { path: '', component: Dashboard, name: 'dashboard' },
            { path: '/missions', component: Missions, name: 'missions' },
            { path: '/missions/:mission_id/details', component: MissionDetail, name: 'details' },
            { path: '/missions/:mission_id/soumission', component: Soumission, name: 'soumission' },
            { path: '/versement', component: Versement, name: 'versement' },
            {path:'/message', component:Message, name:'message'}
        ], meta: { requiresAuth: true }
    }
]

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes
})

router.beforeEach((to, from, next) => {
    const requiresAuth = to.matched.some(record => record.meta.requiresAuth);

    if (requiresAuth && !isAuthenticated()) {
        next({ name: 'connexion' });
    } else {
        next();
    }
});

function isAuthenticated() {
    // logique d'authentification ici
    const token = localStorage.getItem('auth_token');
    return token !== null;
}




export default router