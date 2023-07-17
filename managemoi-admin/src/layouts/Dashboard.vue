<script>
import { api } from '../api';
import { allUser } from "../services/AuthService";
import { API_LINK } from "../constant";
import moment from 'moment';


export default {
    data() {
        return {
            userCount: 0,
            chartOptions: {
                chart: {
                    type: 'line',
                },
                xaxis: {
                    categories: [], // Les mois seront mis à jour dynamiquement
                },
            },
            series: [{
                name: 'nombre utilisateur inscrit',
                data: []
            }]
        }
    },
    mounted() {
        this.fetchAllUser()
        this.fetchUserCount()
    },
    methods: {
        async fetchAllUser() {
            const response = await allUser();

            const formattedData = response.users.map(item => {
                const month = moment(item.created_at).format('MMMM');
                const userId = item.id;

                return {
                    month: month,
                    userId: userId
                };
            });

            const months = formattedData.map(item => item.month);
            const userIds = formattedData.map(item => item.userId);

            // Mettre à jour les données du graphique
            this.chartOptions.xaxis.categories = months;
            this.series = [{
                data: userIds
            }];
        },
        async fetchUserCount() {
            try {
                const response = await api.get(`/users/count`);
                this.userCount = response.data.count;
            } catch (error) {
                console.error(error.message);
            }
        }
    }


}
</script>

<template>
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Tableau de bord</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item active">Tableau de bord</li>
                </ol>
            </nav>
        </div>

        <section class="section dashboard">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card info-card sales-card">
                                <div class="card-body">
                                    <h5 class="card-title">Nombre total d'utilisateur</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bx bx-user"></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ userCount }}</h6>
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
                            <h5 class="card-title">Statistique des utilisateurs inscrits</h5>
                            <apexchart type="line" height="350" :options="chartOptions" :series="series">
                            </apexchart>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</template>

<style scoped></style>