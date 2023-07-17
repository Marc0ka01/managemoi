<script>
import { createMission } from '../../services/MissionService'
import Swal from 'sweetalert2'

export default {
    data() {
        return {
            message: '',
            statut: false,
            loading: false,
            data: {
                titre: '',
                desc: '',
                lien: '',
                montant: null,
                quota: null,
                date_debut: '',
                date_fin: '',
                type: '',
            }
        }
    },
    methods: {
        updateSt() {
            console.log(this.data.type)
        },
        showAlert(message, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: "success",
            }).then(() => {
                if (reloadPage) {
                    window.location.reload(); // Reload the page
                }
            });
        },
        async mission() {
            this.loading = true
            const formdata = new FormData()
            formdata.append('titre_mission', this.data.titre)
            formdata.append('desc_mission', this.data.desc)
            formdata.append('lien_mission', this.data.lien)
            formdata.append('montant', this.data.montant)
            formdata.append('quota', this.data.quota)
            formdata.append('date_debut', this.data.date_debut)
            formdata.append('date_fin', this.data.date_fin)
            formdata.append('type', this.data.type)

            try {
                const response = await createMission(formdata)

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
    <div class="modal fade" id="missionAdd" aria-hidden="true" aria-labelledby="exampleModalScrollableTitle" tabindex="-1"
        role="dialog" aria-modal="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Enregistrer une mission</h5>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form @submit.prevent="mission">
                    <p class="text-danger text-center" v-if="statut">{{ message }}</p>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="nom" class="form-label">Titre de la mission</label>
                                <input type="text" name="nom" id="nom" v-model="data.titre" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label for="desc" class="form-label">Description de la mission</label>
                                <textarea name="desc" id="desc" cols="30" rows="5" v-model="data.desc" class="form-control"
                                    required></textarea>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="montant" class="form-label">Montant</label>
                            <input type="number" name="montant" id="montant" v-model="data.montant" class="form-control"
                                required>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="lien" class="form-label">Lien de la mission</label>
                                <input type="text" name="lien" id="lien" v-model="data.lien" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label for="quota" class="form-label">Quota</label>
                                <input type="number" name="quota" id="quota" v-model="data.quota" class="form-control"
                                    required>
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
                                <label for="select" class="form-label">Pour les : </label>
                                <select class="form-select" v-model="data.type" aria-label="Default select example">
                                    <option value="actif"> actif</option>
                                    <option value="super actif">super actif</option>
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
</template>