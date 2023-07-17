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
    },
    methods: {
        handleSidebarLinkClick() {
            // Rétracter la barre latérale en mode mobile
            // const sidebar = document.getElementById('sidebar');

            if (window.innerWidth < 768) {
                document.body.classList.remove('toggle-sidebar');
            }
        },
    }
}
</script>

<template>
    <aside id="sidebar" class="sidebar">

        <ul class="sidebar-nav" id="sidebar-nav">

            <li class="nav-item">
                <router-link class="nav-link" @click="handleSidebarLinkClick"
                    :class="{ 'nav-link collapsed': !isActive('dashboard') }" to="/">
                    <i class="bi bi-grid"></i>
                    <span>Tableau de bord</span>
                </router-link>
            </li>

            <li class="nav-item">
                <router-link class="nav-link" @click="handleSidebarLinkClick"
                    :class="{ 'nav-link collapsed': !isActive('missions') }" to="/missions">
                    <i class="bx bx-task"></i>
                    <span>Missions</span>
                </router-link>
            </li>

            <li class="nav-item">
                <router-link class="nav-link" @click="handleSidebarLinkClick"
                    :class="{ 'nav-link collapsed': !isActive('versement') }" to="/versement">
                    <i class='bx bx-money-withdraw'></i>
                    <span>Versement</span>
                </router-link>
            </li>

            <li class="nav-item">
                <router-link class="nav-link collapsed" @click="handleSidebarLinkClick"
                    :class="{ 'nav-link collapsed': !isActive('message') }" to="/message">
                    <i class='bx bx-chat'></i>
                    <span>Message</span>
                </router-link>
            </li>

            <li class="nav-item">
                <a class="nav-link collapsed" href="https://wa.me/message/WB4EEQQUEEFLJ1">
                    <i class='bx bx-message-dots'></i>
                    <span>Contactez le service clientèle</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link text-warning collapsed"
                    href="https://drive.google.com/file/d/1IuL6Qqi7gyb_Zvu2_5c4KEKgoA9d58Y8/view">
                    <i class='bx bx-error'></i>
                    <span>Avertissement</span>
                </a>
            </li>
        </ul>

    </aside>
</template>

<style scoped></style>