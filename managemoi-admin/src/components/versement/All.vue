<script>
import { showDemande } from '../../services/VersementService'

export default {
    data() {
        return {
            data: [],
            filteredData: [],
            message: "",
            searchAll: "",
            currentPage: 1,
            perPage: 0,
            totalVersement: 0,
        }
    },
    computed: {
        filteredAll() {
            if (!this.data || this.data.length === 0) {
                return []; // Retourne un tableau vide si this.data est vide
            }
            return this.data.filter((data) => {
                const searchTerm = this.searchAll.toLowerCase();
                const nameMatch = data.user.name.toLowerCase().includes(searchTerm);
                const contactMatch = data.user.contact.toLowerCase().includes(searchTerm);
                const montantMatch = data.montant.toString().includes(searchTerm);
                const modeMatch = data.mode_paiement.toLowerCase().includes(searchTerm);
                const statutMatch = data.statut.toLowerCase().includes(searchTerm);
                return (nameMatch || contactMatch || montantMatch || modeMatch || statutMatch);
            });
        },
        totalPages() {
            return Math.ceil(this.totalVersement / this.perPage)
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredAll.slice(startIndex, endIndex)
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
                this.filteredData = this.filteredAll
            },
            immediate: true, // Pour déclencher le watch dès le montage initial
        },
        searchAll() {
            // Mettre à jour filteredData lorsque searchUser change
            this.currentPage = 1 // Réinitialiser la page actuelle à la première page lors de la recherche
            this.allDemande('', this.currentPage) // Appeler la méthode index() pour récupérer les utilisateurs correspondant à la recherche
        },
    },
    mounted() {
        this.allDemande(this.currentPage)
    },
    methods: {
        async allDemande(statut, currentPage) {
            statut = "";
            const response = await showDemande(statut, currentPage, this.searchAll);
            if (response.status === 200) {
                this.data = [...response.versements.data]
                this.totalVersement = response.versements.total
                this.perPage = response.versements.per_page
            } else {
                this.message = response.message
            }
        },
        goToPage(page) {
            if (page !== this.currentPage) {
                this.currentPage = page; // Mettre à jour la page actuelle
                this.allDemande('', this.currentPage); // Appeler la méthode pour récupérer les données de la nouvelle page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
                this.allDemande('', this.currentPage)
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
                this.allDemande('', this.currentPage)
            }
        },
    }
}
</script>

<template>
    <h5 class="card-title">Listes des versements achevés</h5>
    <div class="d-flex justify-content-end align-items-center">
        <div class="col-md-4">
            <label for="search" class="form-label">Recherche</label>
            <input type="text" name="search" id="search" v-model="searchAll" class="form-control">
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
                <th>Approbation</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="data in filteredData">
                <td>{{ data.created_at }}</td>
                <td>{{ data.user.name }}</td>
                <td>{{ data.user.contact }}</td>
                <td>{{ data.montant }}</td>
                <td>{{ data.mode_paiement }}</td>
                <td>
                    <button type="button" class="btn btn-success" v-show="data.statut === 'effectue'">{{ data.statut
                    }}</button>
                    <button type="button" class="btn btn-danger" v-show="data.statut === 'echoue'">{{ data.statut
                    }}</button>
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