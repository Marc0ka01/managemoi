<script>
import VersementModal from '../components/modal/VersementModal.vue'
import { getStore } from '../services/AuthService'
import { versement } from '../services/VersementService'

export default {
    components: {
        VersementModal,
    },
    data() {
        return {
            user: getStore(),
            data: [],
            date: '',
            message: '',
            currentPage: 1,
            totalVersements: 0,
            perPage: 0,
            filteredData:[]
        }
    },
    computed: {
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.data.slice(startIndex, endIndex)
        },
        totalPages() {
            return Math.ceil(this.totalVersements / this.perPage) // Calculer le nombre total de pages
        },
        displayedPages() {
            const range = 2 // Nombre de pages à afficher de chaque côté de la page actuelle
            const start = Math.max(1, this.currentPage - range) // Page de départ
            const end = Math.min(this.totalPages, this.currentPage + range) // Page de fin
            return Array.from({ length: end - start + 1 }, (_, i) => start + i) // Générer un tableau avec les pages à afficher
        },
    },
    watch: {
        data: {
            handler() {
                // Mettre à jour filteredData lorsque data change
                this.filteredData = this.data
            },
            immediate: true, // Pour déclencher le watch dès le montage initial
        },
    },
    mounted() {
        this.getVersements(this.currentPage)
    },
    methods: {
        async getVersements(currentPage) {
            const response = await versement(currentPage)
            this.data = [...response.versements.data]
            this.totalVersements = response.versements.total
            this.perPage = response.versements.per_page
            if (this.data.length <= 0) {
                this.message = response.message
            }
        },
        formatDate(timestamp) {
            const date = new Date(timestamp);

            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();

            return `${day}-${month}-${year}`;
        },
        goToPage(page) {
            if (page !== this.currentPage) {
                this.currentPage = page // Mettre à jour la page actuelle
                this.getVersements(this.currentPage) // Appeler la méthode pour récupérer les utilisateurs de la nouvelle page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.getVersements(this.currentPage)
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.getVersements(this.currentPage)
            }
        },

    }
}
</script>

<template>
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Tableau de bord</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item active">Versement</li>
                </ol>
            </nav>
        </div>

        <div class="d-flex justify-content-end align-items-center mb-4">
            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#versement">
                <i class='bx bx-money-withdraw pe-2'></i>
                <span>Nouvelle demande</span>
            </button>
        </div>

        <section class="section dashboard">
            <div class="row">

                <div class="col-lg-12">
                    <div class="row">

                        <div class="col-xxl-4 col-md-6">
                            <div class="card info-card sales-card">

                                <div class="card-body">
                                    <h5 class="card-title">Missions éffectuées</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bx bx-task"></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ user.missions_effectuees }}</h6>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-xxl-4 col-md-6">
                            <div class="card info-card revenue-card">

                                <div class="card-body">
                                    <h5 class="card-title">Solde</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bi bi-currency-dollar"></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ user.solde }} FCFA</h6>

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
                            <h5 class="card-title">Historique de retrait</h5>

                            <!-- Default Table -->
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Date</th>
                                        <th scope="col">Montant</th>
                                        <th scope="col">Statut</th>
                                        <th scope="col">Mode</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="versement in filteredData">
                                        <th scope="row" class="small-text">{{ formatDate(versement.created_at) }}</th>
                                        <td class="small-text">{{ versement.montant }}</td>
                                        <td class="text-warning fs-2" v-if="versement.statut === 'en_cours'">
                                            <i class='bx bxs-hourglass-top'></i>
                                        </td>
                                        <td class="text-success fs-2" v-if="versement.statut === 'effectue'">
                                            <i class='bx bx-check'></i>
                                        </td>
                                        <td class="text-danger fs-2" v-if="versement.statut === 'echoue'">
                                            <i class='bx bx-x'></i>
                                        </td>
                                        <td class="small-text">{{ versement.mode_paiement }}</td>
                                    </tr>
                                </tbody>
                            </table>
                            <p class="text-muted text-center" v-if="message !== ''">{{ message }}</p>
                            <nav aria-label="Page navigation example" v-if="totalPages > 1" style="cursor: pointer;">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <a class="page-link" @click="prevPage">Précédent</a>
                                    </li>
                                    <li class="page-item" v-for="page in displayedPages" :key="page"
                                        :class="{ 'active': currentPage === page }">
                                        <a class="page-link" @click="goToPage(page)">{{ page }}</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" @click="nextPage">Suivant</a>
                                    </li>
                                </ul>
                            </nav>

                        </div>
                    </div>
                </div>


            </div>
        </section>

    </main>

    <VersementModal />
</template>

<style scoped></style>