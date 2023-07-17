<script>
import { versementHistory } from '../../services/VersementService'

export default {
    data() {
        return {
            versement: [],
            messageV: '',
            searchV: '',
            currentPage: 1,
            perPage: 10,
        }
    },
    mounted() {
        this.fetchVersement()
    },
    computed: {
        filteredVersement() {
            if (!this.versement || this.versement.length <= 0) {
                return []
            }

            return this.versement.filter(data => {
                const search = this.searchV.toLowerCase()
                const date = data.created_at.toLowerCase().includes(search)
                const contact = data.user.contact.toLowerCase().includes(search)
                const montant = data.montant.toString().includes(search)
                const mode = data.mode_paiement.toLowerCase().includes(search)

                return date || contact || montant || mode
            })
        },
        totalPages() {
            return Math.ceil(this.filteredVersement.length / this.perPage)
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredVersement.slice(startIndex, endIndex)
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
    methods: {
        async fetchVersement() {
            const userId = this.$route.params.user_id
            const response = await versementHistory(userId)
            this.versement = response.versements.data
            if (this.versement.length <= 0) {
                this.messageV = "Cet utilisateur n'a pas encore éffctué de demande de versment"
            }
        },
        goToPage(page) {
            if (page >= 1 && page <= this.totalPages) {
                this.currentPage = page
            }
        },
        nextPage() {
            if (this.currentPage < this.totalPages) {
                this.currentPage++
            }
        },
        prevPage() {
            if (this.currentPage > 1) {
                this.currentPage--
            }
        },
    }
}
</script>

<template>
    <h5 class="card-title">Historique des versements</h5>
    <div class="d-flex justify-content-end align-items-center">
        <div class="col-md-4">
            <label for="search" class="form-label">Recherche</label>
            <input type="text" name="search" id="search" v-model="searchV" class="form-control">
        </div>
    </div>
    <table class="table datatable">
        <thead>
            <tr>
                <th>Date</th>
                <th>Contact</th>
                <th>Montant</th>
                <th>Mode</th>
                <th>statut</th>
            </tr>
        </thead>
        <tbody v-if="messageV === ''">
            <tr v-for="versement in paginated">
                <th scope="row">{{ versement.created_at }}</th>
                <td>{{ versement.user.contact }}</td>
                <td>{{ versement.montant }}</td>
                <td>{{ versement.mode_paiement }}</td>
                <td>{{ versement.statut }}</td>
            </tr>
        </tbody>
    </table>
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