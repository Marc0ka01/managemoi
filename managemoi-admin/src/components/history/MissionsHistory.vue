<script>
import { missionHistory } from '../../services/MissionService'

export default {
    data() {
        return {
            mission: [],
            messageM: '',
            searchM: '',
            currentPage: 1,
            perPage: 10,
        }
    },
    mounted() {
        this.fetchMission()
    },
    computed: {
        filteredMission() {
            if (!this.mission || this.mission.length <= 0) {
                return []
            }

            return this.mission.filter(data => {
                const search = this.searchM.toLowerCase()
                const titre = data.titre_mission.toLowerCase().includes(search)
                const desc = data.desc_mission.toLowerCase().includes(search)
                const lien = data.lien_mission.toLowerCase().includes(search)
                const date = data.date_debut.toLowerCase().includes(search)

                return titre || desc || lien || date
            })
        },
        totalPages() {
            return Math.ceil(this.filteredMission.length / this.perPage)
        },
        paginated() {
            const startIndex = (this.currentPage - 1) * this.perPage
            const endIndex = startIndex + this.perPage
            return this.filteredMission.slice(startIndex, endIndex)
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
        async fetchMission() {
            const userId = this.$route.params.user_id
            const response = await missionHistory(userId)
            this.mission = response.missions.data
            if (this.mission.length <= 0) {
                this.messageM = "Cet utilisateur n'a pas encore éffectué de mission"
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
    <h5 class="card-title">Historique des missions</h5>
    <div class="d-flex justify-content-end align-items-center">
        <div class="col-md-4">
            <label for="search" class="form-label">Recherche</label>
            <input type="text" name="search" id="search" v-model="searchM" class="form-control">
        </div>
    </div>
    <table class="table datatable">
        <thead>
            <tr>
                <th>Date</th>
                <th>Titre de la mission</th>
                <th>Libellé</th>
                <th>Lien</th>
                <th>Montant</th>
            </tr>
        </thead>
        <tbody v-if="messageM === ''">
            <tr v-for="mission in paginated">
                <th scope="row">{{ mission.date_debut }}</th>
                <td>{{ mission.titre_mission }}</td>
                <td>{{ mission.desc_mission }}</td>
                <td>{{ mission.lien_mission }}</td>
                <td>{{ mission.montant }}</td>
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