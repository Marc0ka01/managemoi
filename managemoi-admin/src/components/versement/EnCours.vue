<script>
import { updateVersementUser, showDemande } from '../../services/VersementService'
import Swal from 'sweetalert2'


export default {
    data() {
        return {
            data: [],
            message: '',
            searchEnCours: '',
            currentPage: 1,
            perPage: 0,
            totalEnCours: 0,
            filteredData: [],
            loading: false,
        }
    },
    mounted() {
        this.demandeEnCours(this.currentPage)
    },
    computed: {
        filteredEnCours() {
            if (!this.data || this.data.length === 0) {
                return []; // Retourne un tableau vide si this.data est vide
            }
            return this.data.filter((data) => {
                const searchTerm = this.searchEnCours.toLowerCase();
                const nameMatch = data.user.name.toLowerCase().includes(searchTerm);
                const contactMatch = data.user.contact.toLowerCase().includes(searchTerm);
                const montantMatch = data.montant.toString().includes(searchTerm);
                const modeMatch = data.mode_paiement.toLowerCase().includes(searchTerm);

                return nameMatch || contactMatch || montantMatch || modeMatch;
            });
        },
        totalPages() {
            return Math.ceil(this.totalEnCours / this.perPage)
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredEnCours.slice(startIndex, endIndex)
        },
        displayedPages() {
            const numPagesToShow = 5; // Nombre de numéros de page à afficher
            const half = Math.floor(numPagesToShow / 2);
            let start = Math.max(this.currentPage - half, 1);
            let end = start + numPagesToShow - 1;

            if (end > this.totalPages) {
                end = this.totalPages;
                start = Math.max(end - numPagesToShow + 1, 1);
            }

            return Array.from({ length: end - start + 1 }, (_, i) => start + i);
        },
    },
    watch: {
        data: {
            handler() {
                // Mettre à jour filteredData lorsque data change
                this.filteredData = this.filteredEnCours
            },
            immediate: true, // Pour déclencher le watch dès le montage initial
        },
        searchEnCours() {
            // Mettre à jour filteredData lorsque searchUser change
            this.currentPage = 1 // Réinitialiser la page actuelle à la première page lors de la recherche
            this.demandeEnCours(this.currentPage) // Appeler la méthode index() pour récupérer les utilisateurs correspondant à la recherche
        },
    },
    methods: {
        showAlert(message, icon, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: icon,
            }).then(() => {
                if (reloadPage) {
                    location.reload(); // Reload the page
                }
            });
        },
        async demandeEnCours(statut, currentPage) {
            statut = "en_cours";
            const response = await showDemande(statut, currentPage, this.searchEnCours);
            if (response.status === 200) {
                this.data = [...response.versements.data]
                this.totalEnCours = response.versements.total
                this.perPage = response.versements.per_page
            } else {
                this.message = response.message
            }
        },
        async updateVersement(statut, user_id, versement_id) {
            this.loading = true
            const formdata = new FormData()
            formdata.append('action', statut)
            formdata.append('user_id', user_id)
            formdata.append('versement_id', versement_id)
            const response = await updateVersementUser(formdata);
            if (response.status === 200) {
                this.loading = false
                this.showAlert(response.message, 'success', true)
            } else {
                this.loading = false
                this.showAlert(response.message, 'error', true)
            }
        },
        goToPage(page) {
            if (page !== this.currentPage) {
                this.currentPage = page // Mettre à jour la page actuelle
                this.demandeEnCours(this.currentPage) // Appeler la méthode pour récupérer les utilisateurs de la nouvelle page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.demandeEnCours(this.currentPage)
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.demandeEnCours(this.currentPage)
            }
        },
    }
}
</script>

<template>
    <h5 class="card-title">Listes des versements en attente</h5>

    <div class="d-flex justify-content-end align-items-center">
        <div class="col-md-4">
            <label for="search" class="form-label">Recherche</label>
            <input type="text" name="search" id="search" v-model="searchEnCours" class="form-control">
        </div>
    </div>
    <table ref="table" class="table">
        <thead>
            <tr>
                <th>Date</th>
                <th>Nom</th>
                <th>Contact</th>
                <th>Montant</th>
                <th>Mode</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="data in filteredData">
                <td>{{ data.created_at }}</td>
                <td>{{ data.user.name }}</td>
                <td>{{ data.user.contact }}</td>
                <td>{{ data.montant }}</td>
                <td>{{ data.mode_paiement }}</td>
                <td class="d-flex">
                    <button class="btn btn-success me-3" @click="updateVersement('effectue', data.user.id, data.id)" :disabled="loading">
                        <span v-if="!loading"><i class='bx bx-check'></i></span>
                        <div v-if="loading" class="spinner-border" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </button>
                    <button class="btn btn-danger me-3" @click="updateVersement('echoue', data.user.id, data.id)" :disabled="loading">
                        <span v-if="!loading"><i class='bx bx-x'></i></span>
                        <div v-if="loading" class="spinner-border" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </button>
                </td>
            </tr>
        </tbody>
    </table>
    <p class="text-muted text-center" v-if="message !== ''">{{ message }}</p>
    <nav aria-label="Page navigation example" v-if="totalPages > 1" style="cursor: pointer;">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" @click="prevPage">Previous</a>
            </li>
            <li class="page-item" v-for="page in displayedPages" :key="page" :class="{ 'active': currentPage === page }">
                <a class="page-link" @click="goToPage(page)">{{ page }}</a>
            </li>
            <li class="page-item">
                <a class="page-link" @click="nextPage">Next</a>
            </li>
        </ul>
    </nav>
</template>