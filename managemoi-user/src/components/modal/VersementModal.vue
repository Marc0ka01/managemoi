<script>
import { demandeVersement, versement } from '../../services/VersementService';
import { getStore } from '../../services/AuthService';
import Swal from 'sweetalert2'

export default {
    data() {
        return {
            data: getStore(),
            montant: null,
            message: '',
            mode_paiement: '',
            modes: [
                'Wave',
                'Orange Money'
            ],
            loading: false,

        }
    },
    methods: {
        showAlert(message) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: "success",
            }).then(() => {
                location.reload()
            });
        },
        async demande() {
            if (this.montant >= 2000) {
                if (this.montant <= this.data.solde) {

                    this.loading = true
                    const formdata = new FormData()
                    formdata.append('montant', this.montant)
                    formdata.append('mode_paiement', this.mode_paiement)
                    const response = await demandeVersement(formdata)

                    try {
                        if (response.status === 200) {
                        this.loading = false
                        this.showAlert(response.message)
                    } else {
                        this.loading = false
                        this.showAlert(response.message)
                    }
                    } catch (error) {
                        this.loading = false
                        this.showAlert("Une erreur s'est prouite !")
                    }

                }
            } else {
                this.message = "Le retrait minimum est de 2000 FCFA";
            }

            if (this.montant > this.data.solde) {
                this.message = "Le montant demandé est supérieur à votre solde";
            }
        },
        async versements() {
            await versement()
        }
    }
}
</script>

<template>
    <div class="modal fade" id="versement" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Retrait</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form @submit.prevent="demande">
                    <div class="modal-body">
                        <p class="text-danger" v-if="message !== ''">{{ message }}</p>
                        <div class="mb-3">
                            <label for="montant" class="col-form-label">Montant:</label>
                            <input type="number" class="form-control" id="montant" v-model="montant" required>
                        </div>
                        <div class="mb-3">
                            <label for="mode-paiment" class="col-form-label">Mode de paiement:</label>
                            <select class="form-select" id="mode-paiement" v-model="mode_paiement" placeholder="Selectionner un mode de la liste" required>
                                <option v-for="mode in modes" :value="mode">{{ mode }}</option>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" :disabled="loading">
                            <span v-if="!loading">Valider</span>
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

<style scoped></style>