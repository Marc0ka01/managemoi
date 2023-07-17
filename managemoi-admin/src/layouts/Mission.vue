<script>
import ModalMissionAdd from '../components/modal/ModalMissionAdd.vue'
import { index } from '../services/MissionService'

export default {
    components: {
        ModalMissionAdd,
    },
    data() {
        return {
            data: [],
            searchMission: '',
            statut: false,
            selectedMission: null,
            currentPage: 1,
            perPage: 0,
            totalMissions: 0,
            filteredData:[],
        }
    },
    computed: {
        filteredMission() {
            if (!this.data || this.data.length <= 0) {
                return []
            }

            return this.data.filter(data => {
                const search = this.searchMission.toLowerCase()
                const title = data.titre_mission.toLowerCase().includes(search)
                const desc = data.desc_mission.toLowerCase().includes(search)
                const lien = data.lien_mission.toLowerCase().includes(search)
                const montant = data.montant.toString().includes(search)
                const quota = data.quota.toString().includes(search)
                const soumissions = data.nbr_soumissions.toString().includes(search)

                return title || desc || lien || montant || quota || soumissions
            })
        },
        totalPages() {
            return Math.ceil(this.totalMissions / this.perPage)
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredMission.slice(startIndex, endIndex)
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
                this.filteredData = this.filteredMission
            },
            immediate: true, // Pour déclencher le watch dès le montage initial
        },
        searchMission() {
            // Mettre à jour filteredData lorsque searchUser change
            this.currentPage = 1 // Réinitialiser la page actuelle à la première page lors de la recherche
            this.getMission(this.currentPage) // Appeler la méthode index() pour récupérer les utilisateurs correspondant à la recherche
        },
    },
    mounted() {
        this.getMission(this.currentPage, this.searchMission)
    },
    methods: {
        async getMission(currentPage) {
            const response = await index(currentPage, this.searchMission)
            this.data = response.missions.data
            this.totalMissions = response.missions.total
            this.perPage = response.missions.per_page
            if (this.data.length === 0) {
                this.message = response.message
                this.statut = true
            } else {
                this.statut = false
            }
        },
        selectMission(missionId) {
            this.selectedMission = missionId;
        },
        goToPage(page) {
            if (page !== this.currentPage) {
                this.currentPage = page // Mettre à jour la page actuelle
                this.getMission(this.currentPage) // Appeler la méthode pour récupérer les utilisateurs de la nouvelle page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.getMission(this.currentPage)
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.getMission(this.currentPage)
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

        <div class="d-flex justify-content-end align-items-center mb-4">
            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#missionAdd">
                <i class='bx bx-plus pe-2'></i>
                <span>Nouvelle mission</span>
            </button>
        </div>

        <section class="section">

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-titk">Listes des missions</h5>
                            <div class="d-flex justify-content-end align-items-center">
                                <div class="col-md-4">
                                    <label for="search" class="form-label">Recherche</label>
                                    <input type="text" name="search" id="search" v-model="searchMission"
                                        class="form-control">
                                </div>
                            </div>
                            <table class="table display">
                                <thead>
                                    <tr>
                                        <th>N°</th>
                                        <th>Titre</th>
                                        <th>Libelle</th>
                                        <th>Date début</th>
                                        <th>Date fin</th>
                                        <th>Lien</th>
                                        <th>Montant</th>
                                        <th>Quota</th>
                                        <th>Soumission</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>

                                <tbody v-if="statut === false">

                                    <tr v-for="data in filteredData">
                                        <td>{{ data.id }}</td>
                                        <td>{{ data.titre_mission }}</td>
                                        <td>{{ data.desc_mission }}</td>
                                        <td>{{ data.date_debut }}</td>
                                        <td>{{ data.date_fin }}</td>
                                        <td><a :href="data.lien_mission">{{ data.lien_mission }}</a></td>
                                        <td>{{ data.montant }} FCFA</td>
                                        <td>{{ data.quota }}</td>
                                        <td>{{ data.nbr_soumissions }}</td>
                                        <td>
                                            <router-link :to="'/missions/soumissions/' + data.id"
                                                class="btn btn-secondary me-2">
                                                <i class="bx bx-list-ul"></i>
                                            </router-link>
                                            <router-link :to="'/missions/edit/' + data.id" class="btn btn-warning me-2">
                                                <i class="bx bx-edit"></i>
                                            </router-link>
                                        </td>
                                    </tr>
                                </tbody>

                            </table>
                            <nav aria-label="Page navigation example" v-if="totalPages > 1" style="cursor: pointer;">
                                <ul class="pagination">
                                    <li class="page-item">
                                        <a class="page-link" @click="prevPage">Previous</a>
                                    </li>
                                    <li class="page-item" v-for="page in displayedPages" :key="page"
                                        :class="{ 'active': currentPage === page }">
                                        <a class="page-link" @click="goToPage(page)">{{ page }}</a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" @click="nextPage">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <p class="text-muted text-center" v-if="statut">{{ message }}</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- mission add modal -->
    <ModalMissionAdd />
</template>

<style scoped></style>