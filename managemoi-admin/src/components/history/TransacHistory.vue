<script>
import { showTransac } from '../../services/VersementService'

export default {
    data() {
        return {
            transac: [],
            messageT: '',
            searchT: '',
            currentPage: 1,
            perPage: 10,
        }
    },
    mounted() {
        this.getTransac()
    },
    computed: {
        filteredTransaction() {
            if (!this.transac || this.transac.length <= 0) {
                return []
            }
            return this.transac.filter(data => {
                const search = this.searchT.toLowerCase()
                const date = data.created_at.toLowerCase().includes(search)
                const action = data.action.toLowerCase().includes(search)

                return date || action
            })
        },
        totalPages() {
            return Math.ceil(this.filteredTransaction.length / this.perPage)
        },
        paginatedTransaction() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredTransaction.slice(startIndex, endIndex)
        },
    },
    methods: {
        async getTransac() {
            const user_id = this.$route.params.user_id
            const response = await showTransac(user_id)
            this.transac = response.data
            if (this.transac.length <= 0) {
                this.messageT = "Aucune transaction éffectuée sur ce compte"
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
    }
}
</script>

<template>
    <h5 class="card-title">Historique des transction</h5>
    <div class="d-flex justify-content-end align-items-center">
        <div class="col-md-4">
            <label for="search" class="form-label">Recherche</label>
            <input type="text" name="search" id="search" v-model="searchT" class="form-control">
        </div>
    </div>
    <table class="table datatable">
        <thead>
            <tr>
                <th>Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody v-if="messageT === ''">
            <tr v-for="transac in paginatedTransaction" :key="transac.id">
                <th scope="row">{{ transac.created_at }}</th>
                <td>{{ transac.action }}</td>
            </tr>
        </tbody>
    </table>
    <nav aria-label="Page navigation example" v-if="totalPages > 1" style="cursor: pointer;">
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link"  @click="prevPage">Previous</a>
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