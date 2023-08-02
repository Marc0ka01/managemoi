<script>
import { API_LINK } from '../constant';
import { getUsersByMission } from '../services/MissionService';


export default {
    data() {
        return {
            data: [],
            searchSoumissions: '',
            message: '',
            filteredData:[],
            enlargedImage: '',
            modalImage: '',
            showModals: false,
            currentPage: 1,
            perPage: 0,
            totalSoumission:0,
        }
    },
    computed: {
        filteredSoumission() {
            if (!this.data || this.data.length <= 0) {
                return []
            }

            return this.data.filter(data => {
                const search = this.searchSoumissions.toLowerCase()
                const name = data.user.name.toLowerCase().includes(search)
                const contact = data.user.contact.toLowerCase().includes(search)
                const email = data.user.email.toLowerCase().includes(search)

                return (name || contact || email)
            })
        },
        totalPages() {
            return Math.ceil(this.totalSoumission / this.perPage)
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredSoumission.slice(startIndex, endIndex)
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
                this.filteredData = this.filteredSoumission
            },
            immediate: true, // Pour déclencher le watch dès le montage initial
        },
        searchSoumissions() {
            // Mettre à jour filteredData lorsque searchUser change
            this.currentPage = 1 // Réinitialiser la page actuelle à la première page lors de la recherche
            this.getUser(this.currentPage) // Appeler la méthode index() pour récupérer les utilisateurs correspondant à la recherche
        },
    },
    mounted() {
        this.getUser(this.currentPage);
    },
    methods: {
        showModal(imageSrc) {
            this.modalImage = `${API_LINK}/screenshots/${imageSrc}`;
            this.showModals = true;

            const myModal = new bootstrap.Modal(document.getElementById('soumissionModal'));
            myModal.show();
        },
        async getUser(currentPage) {
            const mission_id = this.$route.params.mission_id
            const response = await getUsersByMission(mission_id, currentPage, this.searchSoumissions)
            this.data = [...response.users.data]
            this.perPage = response.users.per_page
            this.totalSoumission = response.users.total

            if (this.data.length === 0) {
                this.message = "Aucune soumission pour l'instant"
            }
        },
        getScreenUrl(screen) {
            if (screen) {
                return `${API_LINK}/screenshots/${screen}`;
            }
        },
        goToPage(page) {
            if (page >= 1 && page <= this.totalPages) {
                this.currentPage = page
                this.getUser(this.currentPage);
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.getUser(this.currentPage);
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.getUser(this.currentPage);
            }
        },
    }
}
</script>

<template>
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Missions</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/missions"
                            class="text-decoration-none">Missions</router-link></li>
                    <li class="breadcrumb-item active">Soumissions</li>
                </ol>
            </nav>
        </div>

        <section class="section">

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title text-center">Liste des soumissions</h5>
                            <div class="d-flex justify-content-end align-items-center">
                                <div class="col-md-4">
                                    <label for="search" class="form-label">Recherche</label>
                                    <input type="text" name="search" id="search" v-model="searchSoumissions"
                                        class="form-control">
                                </div>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>id</th>
                                        <th>Date</th>
                                        <th>Nom</th>
                                        <th>Contact</th>
                                        <th>Email</th>
                                        <th>Capture 1</th>
                                        <th>Capture 2</th>
                                        <th>Capture 3</th>
                                    </tr>
                                </thead>

                                <tbody v-if="message === ''">
                                    <tr v-for="(data, index) in filteredData" :key="index">
                                        <td>{{ index + 1 }}</td>
                                        <td>{{ data.created_at }}</td>
                                        <td>{{ data.user.name }}</td>
                                        <td>{{ data.user.contact }}</td>
                                        <td>{{ data.user.email }}</td>
                                        <td class="cursor-pointer"><img :src="getScreenUrl(data.screen_one)" @click="showModal(data.screen_one)"
                                                alt="" width="50" class="img-thumbnail soumission-item"></td>
                                        <td class="cursor-pointer"><img :src="getScreenUrl(data.screen_two)" @click="showModal(data.screen_two)"
                                                alt="" width="50" class="img-thumbnail soumission-item"></td>
                                        <td class="cursor-pointer"><img :src="getScreenUrl(data.screen_three)"
                                                @click="showModal(data.screen_three)" alt="" width="50"
                                                class="img-thumbnail soumission-item"></td>
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
                            <p class="text-muted text-center" v-if="message !== ''">{{ message }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Modal -->
    <div class="modal fade" :class="{ 'show': showModals }" id="soumissionModal" tabindex="-1"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <img :src="modalImage" alt="" width="300" class="modal-img">
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.cursor-pointer{
    cursor: pointer;
}
</style>