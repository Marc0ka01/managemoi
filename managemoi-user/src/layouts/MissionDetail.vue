<script>
import {show} from '../services/MissionService'
export default {
    data(){
        return{
            data:[]
        }
    },
    created(){
        this.showMission()
    },
    methods:{
        async showMission(){
            const response = await show(this.$route.params.mission_id)
            this.data = response.mission
        }
    }
}
</script>

<template>
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Détails mission</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/missions"
                            class="text-decoration-none">Missions</router-link></li>
                    <li class="breadcrumb-item active">Details mission</li>
                </ol>
            </nav>
        </div>

        <section class="section profile">
            <div class="col-xl-12">

                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">

                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab"
                                    data-bs-target="#profile-overview">Informations
                                    complètes</button>
                            </li>
                        </ul>
                        <div class="tab-content pt-2">

                            <div class="tab-pane fade show active profile-overview" id="profile-overview">

                                <h5 class="card-title">Détails de la mission</h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">N°</div>
                                    <div class="col-lg-9 col-md-8">{{ data.id }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Titre de la mission</div>
                                    <div class="col-lg-9 col-md-8">{{ data.titre_mission }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Libelle</div>
                                    <div class="col-lg-9 col-md-8">{{ data.desc_mission }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Lien</div>
                                    <div class="col-lg-9 col-md-8"><a :href="data.lien_mission">{{ data.lien_mission }}</a>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Montant</div>
                                    <div class="col-lg-9 col-md-8">{{ data.montant }} FCFA</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Date début</div>
                                    <div class="col-lg-9 col-md-8">{{ data.date_debut }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Date fin</div>
                                    <div class="col-lg-9 col-md-8">{{ data.date_fin }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Quota</div>
                                    <div class="col-lg-9 col-md-8">{{ data.quota }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Soumission</div>
                                    <div class="col-lg-9 col-md-8">{{ data.nbr_soumissions }}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label"></div>
                                    <div class="col-lg-9 col-md-8"><router-link :to="'/missions/'+data.id+'/soumission'"
                                            class="btn btn-primary">Soumettre</router-link></div>
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