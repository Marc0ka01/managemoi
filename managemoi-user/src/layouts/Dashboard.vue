<script>
import { getStore } from '../services/AuthService'

export default {
    data() {
        return {
            data: getStore(),
        }
    },
    
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

                        <div class="col-xxl-4 col-md-6">
                            <div class="card info-card sales-card">

                                <div class="card-body">
                                    <h5 class="card-title">Missions éffectuées</h5>

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

                        <div class="col-xxl-4 col-md-6">
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