<script>
import { allUser } from '../services/AuthService'

export default {
    data() {
        return {
            data: [],
            message: '',
            searchUser: '',
            currentPage: 1,
            perPage: 0,
            totalUsers: 0,
            filteredData:[],
        }
    },
    computed: {
        filteredUser() {
            if (!this.data || this.data.length <= 0) {
                return []
            }
            return this.data.filter(data => {
                // Filtrer les utilisateurs en fonction de la recherche
                const searchUsers = this.searchUser.toLowerCase()
                const name = data.name.toLowerCase().includes(searchUsers)
                const contact = data.contact.toLowerCase().includes(searchUsers)
                const email = data.email.toLowerCase().includes(searchUsers)
                const mission = data.missions_effectuees.toString().includes(searchUsers)
                const date_de_naissance = data.date_de_naissance.toLowerCase().includes(searchUsers)
                const ville = data.ville.toLowerCase().includes(searchUsers)
                const quartier = data.quartier.toLowerCase().includes(searchUsers)
                const solde = data.solde.toString().includes(searchUsers)

                return (
                    name ||
                    contact ||
                    email ||
                    mission ||
                    date_de_naissance ||
                    ville ||
                    quartier ||
                    solde
                )
            })
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredUser.slice(startIndex, endIndex)
        },
        totalPages() {
            return Math.ceil(this.totalUsers / this.perPage) // Calculer le nombre total de pages
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
                this.filteredData = this.filteredUser
            },
            immediate: true, // Pour déclencher le watch dès le montage initial
        },
        searchUser() {
            // Mettre à jour filteredData lorsque searchUser change
            this.currentPage = 1 // Réinitialiser la page actuelle à la première page lors de la recherche
            this.index(this.currentPage) // Appeler la méthode index() pour récupérer les utilisateurs correspondant à la recherche
        },
    },
    mounted() {
        this.index(this.currentPage)
    },
    methods: {
        async index(currentPage) {
            const response = await allUser(currentPage, this.searchUser) // Passer le terme de recherche à l'appel à l'API
            this.data = [...response.users.data] // Mettre à jour les données
            this.totalUsers = response.users.total

            this.perPage = response.users.per_page

            if (this.data.length <= 0) {
                this.message = "Aucun utilisateur inscrit pour l'instant"
            } else {
                this.message = '' // Réinitialiser le message si des utilisateurs sont trouvés
            }
        },

        goToPage(page) {
            if (page !== this.currentPage) {
                this.currentPage = page // Mettre à jour la page actuelle
                this.index(this.currentPage) // Appeler la méthode pour récupérer les utilisateurs de la nouvelle page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.index(this.currentPage)
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.index(this.currentPage)
            }
        },
    },
}
</script>

<template>
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Utilisateurs</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Accueil</a></li>
                    <li class="breadcrumb-item active">Utilisateur</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Listes des utilisateurs inscrits</h5>
                            <div class="d-flex justify-content-end align-items-center">
                                <div class="col-md-4">
                                    <label for="search" class="form-label">Recherche</label>
                                    <input type="text" name="search" id="search" v-model="searchUser" class="form-control">
                                </div>
                            </div>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">N°</th>
                                        <th scope="col">Nom</th>
                                        <th scope="col">Contact</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Mission</th>
                                        <th scope="col">Date de naissance</th>
                                        <th scope="col">Ville</th>
                                        <th scope="col">Quartier</th>
                                        <th scope="col">Solde</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody v-if="message === ''">
                                    <tr v-for="data in filteredData">
                                        <th scope="row">{{ data.id }}</th>
                                        <td>{{ data.name }}</td>
                                        <td>{{ data.contact }}</td>
                                        <td>{{ data.email }}</td>
                                        <td>{{ data.missions_effectuees }}</td>
                                        <td>{{ data.date_de_naissance }}</td>
                                        <td>{{ data.ville }}</td>
                                        <td>{{ data.quartier }}</td>
                                        <td>{{ data.solde }}</td>
                                        <td><button type="button" class="btn btn-primary"
                                                @click="this.$router.push(`/utilisateurs/${data.id}/historique`)"><i
                                                    class="bx bx-show"></i></button></td>
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
</template>

<style scoped></style>