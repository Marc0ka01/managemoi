<script>

import { api } from '../api';
import { getStore } from '../services/AuthService'
export default {
    data() {
        return {
            data: getStore(),
            role: localStorage.getItem('roles'),
        }
    },
    methods: {
        toggleSidebar() {
            document.body.classList.toggle('toggle-sidebar');
        },
        async logout() {
            //  API Laravel pour déconnecter l'utilisateur
            await api.post(`/admin/logout`, null)
                .then(response => {
                    // Effacer le jeton d'authentification dans le stockage local
                    localStorage.removeItem('auth_token');
                    localStorage.removeItem('roles');
                    localStorage.removeItem('user')
                    // Rediriger l'utilisateur vers la page de connexion ou une autre page
                    // selon votre logique d'application
                    this.$router.push('/connexion');
                })
                .catch(error => {
                    console.error(error);
                });
        },

    }
}
</script>

<template>
    <header id="header" class="header fixed-top d-flex align-items-center">

        <div class="d-flex align-items-center justify-content-between">
            <router-link to="/" class="logo d-flex align-items-center text-decoration-none">
                <img src="../assets/logo.jpeg" alt="logo">
                <span class="d-none d-lg-block">ManageMoi</span>
            </router-link>
            <i class="bi bi-list toggle-sidebar-btn" @click="toggleSidebar"></i>
        </div>

        <nav class="header-nav ms-auto">
            <ul class="d-flex align-items-center">

                <li class="nav-item dropdown pe-3">

                    <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                        <img src="../assets/img/user.png" alt="Profile" class="rounded-circle">
                        <span class="d-none d-md-block dropdown-toggle ps-2">{{ data.username }}</span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                        <li class="dropdown-header">
                            <h6>{{ data.username }}</h6>
                            <span class="text-capitalized">{{ role }}</span>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>
                            <router-link class="dropdown-item d-flex align-items-center" to="/admin">
                                <i class="bi bi-person"></i>
                                <span>Utilisateur</span>
                            </router-link>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>
                            <a class="dropdown-item d-flex align-items-center text-danger" href="#" @click="logout">
                                <i class="bi bi-box-arrow-right"></i>
                                <span>Déconnexion</span>
                            </a>
                        </li>

                    </ul>
                </li>

            </ul>
        </nav>

    </header>
</template>