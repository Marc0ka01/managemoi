<script>
import { updateMission, show } from '../services/MissionService'
import Swal from 'sweetalert2'

export default {
    data() {
        return {
            type_mission:['actif', 'super actif'],
            message: '',
            statut: false,
            mission: [],
            loading: false,
            data: {
                titre: '',
                desc: '',
                lien: '',
                montant: null,
                quota: null,
                date_debut: '',
                date_fin: '',
                statut: '',
            }
        }
    },
    mounted() {
        this.getMission()
    },
    methods: {
        showAlert(message, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: "success",
            }).then(() => {
                if (reloadPage) {
                    this.$router.push('/missions')
                }
            });
        },
        async getMission() {
            const missionId = this.$route.params.missionId
            const response = await show(missionId)
            this.mission = response.mission

            this.data.titre = this.mission.titre_mission
            this.data.desc = this.mission.desc_mission
            this.data.lien = this.mission.lien_mission
            this.data.montant = this.mission.montant
            this.data.quota = this.mission.quota
            this.data.date_debut = this.mission.date_debut
            this.data.date_fin = this.mission.date_fin
            this.data.statut = this.mission.type

        },
        async update() {
            this.loading = true
            const formdata = new FormData()
            formdata.append('titre_mission', this.data.titre)
            formdata.append('desc_mission', this.data.desc)
            formdata.append('lien_mission', this.data.lien)
            formdata.append('montant', this.data.montant)
            formdata.append('quota', this.data.quota)
            formdata.append('date_debut', this.data.date_debut)
            formdata.append('date_fin', this.data.date_fin)
            formdata.append('type', this.data.statut)
            const missionId = this.$route.params.missionId
            try {
                const response = await updateMission(formdata, missionId)

                if (response.status === 200) {
                    this.loading = false
                    this.showAlert(response.message, true)
                } else {
                    this.loading = false
                    this.showAlert(response.message)
                }
            } catch (error) {
                this.loading = false
                this.showAlert(response.message)
            }
        }
    }
}
</script>

<template>
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Missions</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/missions"
                            class="text-decoration-none">Missions</router-link></li>
                    <li class="breadcrumb-item active">Edition</li>
                </ol>
            </nav>
        </div>



        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="card-title">Modifier la mission</h1>
                            <form @submit.prevent="update">
                                <p class="text-danger text-center" v-if="statut">{{ message }}</p>
                                <div class="modal-body">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="nom" class="form-label">Titre de la mission</label>
                                            <input type="text" name="nom" id="nom" v-model="data.titre" class="form-control"
                                                required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="desc" class="form-label">Description de la mission</label>
                                            <textarea name="desc" id="desc" cols="30" rows="5" v-model="data.desc"
                                                class="form-control" required></textarea>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="montant" class="form-label">Montant</label>
                                        <input type="number" name="montant" id="montant" v-model="data.montant"
                                            class="form-control" required>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="lien" class="form-label">Lien de la mission</label>
                                            <input type="text" name="lien" id="lien" v-model="data.lien"
                                                class="form-control" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="quota" class="form-label">Quota</label>
                                            <input type="number" name="quota" id="quota" v-model="data.quota"
                                                class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="date_debut" class="form-label">Date debut</label>
                                            <input type="date" name="date_debut" id="date_debut" v-model="data.date_debut"
                                                class="form-control" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="date_fin" class="form-label">Date fin</label>
                                            <input type="date" name="date_fin" id="date_fin" v-model="data.date_fin"
                                                class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-12">
                                            <select class="form-select" v-model="data.statut"  aria-label="Default select example">
                                                <option v-for="t in type_mission" :value="t" :selected="t === data.statut" >{{ t }}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary" :disabled="loading">
                                        <span v-if="!loading">Enregistrer</span>
                                        <div v-if="loading" class="spinner-border" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</template>