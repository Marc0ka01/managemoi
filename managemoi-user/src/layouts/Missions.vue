<script>
import { index } from '../services/MissionService'

export default {
    data() {
        return {
            data: [],
            message: '',
            currentPage: 1,
            totalMissions: 0,
            perPage: 0,
            filteredData: [],
        }
    },
    computed: {
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.data.slice(startIndex, endIndex)
        },
        totalPages() {
            return Math.ceil(this.totalMissions / this.perPage) // Calculer le nombre total de pages
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
        this.getMissions(this.currentPage)
    },
    methods: {
        async getMissions(currentPage) {
            const response = await index(currentPage)
            this.data = [...response.missions.data]
            this.totalMissions = response.missions.total
            this.perPage = response.missions.per_page
            if (this.data.length <= 0) {
                this.message = response.message
            }
        },
        truncated(desc) {
            const maxLength = 40; // Longueur maximale de la description
            if (desc.length <= maxLength) {
                return desc; // Retourne la description complète si elle est assez courte ou si l'option d'affichage complet est activée
            } else {
                return desc.substring(0, maxLength) + ' ...'; // Tronque la description et ajoute "..." à la fin
            }
        },
        goToPage(page) {
            if (page !== this.currentPage) {
                this.currentPage = page // Mettre à jour la page actuelle
                this.getMissions(this.currentPage) // Appeler la méthode pour récupérer les utilisateurs de la nouvelle page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.getMissions(this.currentPage)
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.getMissions(this.currentPage)
            }
        },
    }
}
</script>

<template>
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Missions</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item active">Missions</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Listes des missions</h5>

                            <!-- missions -->

                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <p class="text-muted text-center" v-if="message !== ''">{{ message }}</p>
                    <div class="row">
                        <div class="col-md-4" v-for="row in filteredData">
                            <div class="card">
                                <img src="../assets/img/rs.jpg" style="object-fit: cover; height: 100px ;"
                                    class="card-img-top" alt="...">
                                <div class="card-body">
                                    <h6 class="card-title">{{ row.titre_mission }}</h6>
                                    <p class="card-text">{{ truncated(row.desc_mission) }}</p>
                                    <router-link :to="'/missions/' + row.id + '/details'" class="btn btn-primary w-100">
                                        <span>Faire la mission</span>
                                    </router-link>
                                </div>
                            </div>
                        </div>
                    </div>
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
        </section>
    </main>
</template>

<style></style>
