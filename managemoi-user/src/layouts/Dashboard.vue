<script>
import { getStore, unReadMessageCount } from '../services/AuthService'

export default {
    data() {
        return {
            data: getStore(),
            count: 0,
        }
    },
    mounted() {
        this.unread()
    },
    methods: {
        async unread() {
            const response = await unReadMessageCount()
            this.count = response.unread_message_count
        }
    }

}
</script>

<template>
    <main id="main" class="main">

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
                        <div class="col-xxl-6 col-md-6">
                            <div class="card info-card danger-card">

                                <div class="card-body">
                                    <h5 class="card-title">Comment ça marche</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class='bx bx-link-alt'></i>
                                        </div>
                                        <div class="ps-3">
                                            <p> <a href="https://youtu.be/b_l7U1qDovY">Comment faire une mission</a> <br> <a
                                                    href="https://youtube.com/shorts/SaivbR5gNFs/">Comment recupérer son argent</a></p>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-xxl-6 col-md-6" @click="this.$router.push('/message')">
                            <div class="card info-card customers-card">

                                <div class="card-body">
                                    <h5 class="card-title">Message non lu</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class='bx bx-low-vision'></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ count }}</h6>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-xxl-6 col-md-6">
                            <div class="card info-card sales-card">

                                <div class="card-body">
                                    <h5 class="card-title">Missions effectuées</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bx bx-task"></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ data.missions_effectuees }}</h6>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-xxl-6 col-md-6">
                            <div class="card info-card revenue-card">

                                <div class="card-body">
                                    <h5 class="card-title">Solde</h5>

                                    <div class="d-flex align-items-center">
                                        <div
                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                            <i class="bi bi-currency-dollar"></i>
                                        </div>
                                        <div class="ps-3">
                                            <h6>{{ data.solde }} FCFA</h6>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </main>
</template>

<style scoped></style>