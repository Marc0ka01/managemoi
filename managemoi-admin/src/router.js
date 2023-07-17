import {createRouter, createWebHistory} from 'vue-router'
import store from './store'
import Connexion from './views/Connexion.vue'
import Home from './views/Home.vue'


const routes = [
    {path:'/connexion', component:Connexion, name:'connexion'},
    {path:'/', component:Home, name:'home', meta:{requiresAuth:true}, children:[
        {path:'', component: () => import('./layouts/Dashboard.vue'), name:'dashboard'},
        {path:'/missions', component: () => import('./layouts/Mission.vue'), name:'missions'},
        {path:'/missions/soumissions/:mission_id', component: () => import('./layouts/Soumission.vue'), name:'soumissions'},
        {path:'/missions/edit/:missionId', component: () => import('./layouts/MissionEdit.vue'), name:'mission_show'},
        {path:'/versement', component: () => import('./layouts/Versement.vue'), name:'versement'},
        {path:'/utilisateurs', component: () => import('./layouts/Utilisateur.vue'), name:'utilisateurs'},
        {path:'/utilisateurs/:user_id/historique', component: () => import('./layouts/UserHistory.vue'), name:'historique_utilisateur'},
        {path:'/admin', component: () => import('./layouts/UserAdmin.vue'), name:'admin_user'},
    ]}
]

const router = createRouter({
    history:createWebHistory(import.meta.env.BASE_URL),
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
    // Votre logique d'authentification ici
    const isAuthenticate = store.state.user.token && store.state.user.token !== null;
    return isAuthenticate;
}

export default router