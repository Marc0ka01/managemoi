<script>
import { showUser, banUsers, activeUsers, isSuperActif } from '../services/AuthService'
import ModalSolde from '../components/modal/ModalSolde.vue'
import Swal from 'sweetalert2'

import TransacHistory from '../components/history/TransacHistory.vue'
import VersementsHistory from '../components/history/VersementsHistory.vue'
import MissionsHistory from '../components/history/MissionsHistory.vue'

import PasswordModal from '../components/modal/passwordModal.vue'

import ModalMessage from '../components/modal/ModalMessage.vue'
export default {
    components: {
    ModalSolde,
    TransacHistory,
    VersementsHistory,
    MissionsHistory,
    PasswordModal,
    ModalMessage
},
    data() {
        return {
            data: [],
            is_banned: null,
            isVersementsActive: true,
            isMissionsActive: false,
            isTransacActive: false,
        }
    },
    mounted() {
        this.getUser()
    },
    methods: {
        formatDate(timestamp) {
            const date = new Date(timestamp);

            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();

            return `${day}-${month}-${year}`;
        },
        showAlert(message, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: "success",
            }).then(() => {
                if (reloadPage) {
                    location.reload()
                }
            });
        },
        activateVersements() {
            this.isVersementsActive = true
            this.isMissionsActive = false
            this.isTransacActive = false
        },
        activateMissions() {
            this.isVersementsActive = false
            this.isMissionsActive = true
            this.isTransacActive = false
        },
        activateTransacs() {
            this.isVersementsActive = false;
            this.isMissionsActive = false;
            this.isTransacActive = true
        },
        async getUser() {
            const user_id = this.$route.params.user_id
            const response = await showUser(user_id)
            this.data = response.user
            this.is_banned = response.is_banned
        },
        async banUser(userId) {
            const swalResponse = await Swal.fire({
                title: 'Confirmation',
                text: 'Êtes-vous sûr de vouloir bannir cet utilisateur ?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Oui, bannir',
                cancelButtonText: 'Non, annuler',
            });

            if (swalResponse.isConfirmed) {
                const response = await banUsers(userId);
                this.showAlert(response.message, true);
            }
        },
        async activeUser(userId) {
            const swalResponse = await Swal.fire({
                title: 'Confirmation',
                text: 'Êtes-vous sûr de vouloir activer cet utilisateur ?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Oui, activer',
                cancelButtonText: 'Non, annuler',
            });

            if (swalResponse.isConfirmed) {
                const response = await activeUsers(userId);
                if (response.status === 200) {
                    this.showAlert(response.message, true);
                } else {
                    this.showAlert(response.message);
                }
            }
        },

        async isSuperActif(id, statut) {
            const formdata = new FormData()
            formdata.append('id', id)
            formdata.append('statut', statut)

            const swalResponse = await Swal.fire({
                title: 'Confirmation',
                text: `Êtes-vous sûr de vouloir rendre cet utilisateur ${statut}`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: `Oui, ${statut}`,
                cancelButtonText: 'Non, annuler',
            });

            if (swalResponse.isConfirmed) {
                const response = await isSuperActif(formdata)
                if (response.status === 200) {
                    this.showAlert(response.message, true)
                }
            }
        }


    },

}
</script>


<template>
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Historique utilisateur</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Accueil</a></li>
                    <li class="breadcrumb-item"><a href="/utilisateurs" class="text-decoration-none">Utilisateur</a></li>
                    <li class="breadcrumb-item active">Historique utilisateur</li>
                </ol>
            </nav>
        </div>

        <section class="section dashboard">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">

                        <div class="col-xxl-6 col-md-9">
                            <div class="card info-card sales-card">

                                <div class="card-body">
                                    <h5 class="card-title">Informations utilisateur</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bx bx-user"></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ data.name }}</h6>
                                            <p class="text-muted">solde : {{ data.solde }}</p>
                                            <div class="d-flex align-items-center justify-content-between">
                                                <p class="text-muted pe-3">Date d'inscription : {{
                                                    formatDate(data.created_at) }}
                                                </p>
                                                <p class="text-muted">Dernière connexion : {{ formatDate(data.updated_at) }}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-xxl-6 col-md-3">
                            <div class="card info-card revenue-card">
                                <div class="card-body">
                                    <h5 class="card-title">Action</h5>

                                    <div>
                                        <div class="d-flex justify-content-around align-items-center">
                                            <div class="text-center">
                                                <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                                                    data-bs-target="#messageModal">
                                                    <i class='bx bx-envelope'></i>
                                                </button>
                                                <p class="fs-6">Envoyer un message</p>
                                            </div>
                                            <div class="text-center">
                                                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                                    data-bs-target="#soldeModal">
                                                    <i class='bx bx-credit-card-alt'></i>
                                                </button>
                                                <p class="fs-6">Modifier le solde</p>
                                            </div>
                                            <div class="text-center">
                                                <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                                    data-bs-target="#passwordModal">
                                                    <i class='bx bx-key'></i>
                                                </button>
                                                <p class="fs-6">Modifier le mot de passe</p>
                                            </div>
                                            <div class="text-center">
                                                <button type="button" v-show="!is_banned" @click="banUser(data.id)"
                                                    class="btn btn-danger">
                                                    <i class='bx bx-lock'></i>
                                                </button>
                                                <button type="button" v-show="is_banned" @click="activeUser(data.id)"
                                                    class="btn btn-success">
                                                    <i class='bx bx-lock'></i>
                                                </button>
                                                <p class="fs-6">Activer ou bannir</p>
                                            </div>
                                            <div class="text-center">
                                                <button v-show="data.statut === 'super actif'" type="button"
                                                    class="btn btn-outline-info" @click="isSuperActif(data.id, 'actif')">
                                                    <i class='bx bx-user-x'></i>
                                                </button>
                                                <button v-show="data.statut === 'actif'" type="button" class="btn btn-info"
                                                    @click="isSuperActif(data.id, 'super actif')">
                                                    <i class='bx bx-user-check'></i>
                                                </button>
                                                <p class="fs-6">Changer de statut</p>
                                            </div>
                                        </div>

                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-12">

                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-around align-items">
                                <button type="button" class="btn btn-outline-primary"
                                    :class="{ 'btn-primary text-white': isVersementsActive }"
                                    @click="activateVersements">Historique
                                    versements</button>
                                <button type="button" class="btn btn-outline-warning"
                                    :class="{ 'btn-warning text-white': isTransacActive }"
                                    @click="activateTransacs">Historique
                                    des transactions</button>
                                <button type="button" class="btn btn-outline-secondary"
                                    :class="{ 'btn-secondary text-white': isMissionsActive }"
                                    @click="activateMissions">Historique
                                    missions</button>
                            </div>
                            <div v-show="isVersementsActive">
                                <VersementsHistory />
                            </div>
                            <div v-show="isTransacActive">
                                <TransacHistory />
                            </div>
                            <div v-show="isMissionsActive">
                                <MissionsHistory />
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </section>

    </main>


    <ModalSolde />
    <PasswordModal />
    <ModalMessage />
</template>