<script>
import { useRoute } from 'vue-router'

export default {
    data() {
        return {

        }
    },
    setup() {
        const route = useRoute();

        const isActive = (name) => {
            return route.name === name;
        };

        return {
            isActive
        };
    }
}
</script>

<template>
    <aside id="sidebar" class="sidebar">

        <ul class="sidebar-nav" id="sidebar-nav">

            <li class="nav-item">
                <router-link class="nav-link" :class="{ 'nav-link collapsed': !isActive('dashboard') }" to="/">
                    <i class="bi bi-grid"></i>
                    <span>Tableau de bord</span>
                </router-link>
            </li>

            <li class="nav-item">
                <router-link class="nav-link" :class="{ 'nav-link collapsed': !isActive('missions') }" to="/missions">
                    <i class="bx bx-task"></i>
                    <span>Missions</span>
                </router-link>
            </li>

            <li class="nav-item">
                <router-link class="nav-link" :class="{ 'nav-link collapsed': !isActive('versement') }" to="/versement">
                    <i class='bx bx-money-withdraw'></i>
                    <span>Versement</span>
                </router-link>
            </li>

            <li class="nav-item">
                <router-link class="nav-link" :class="{ 'nav-link collapsed': !isActive('utilisateurs') }" to="/utilisateurs">
                    <i class='bx bx-user'></i>
                    <span>Utiliisateur</span>
                </router-link>
            </li>

        </ul>

    </aside>
</template>

<style scoped></style>