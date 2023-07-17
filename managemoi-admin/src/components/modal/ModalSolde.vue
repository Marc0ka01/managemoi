<script>
import { updateSoldeUser } from '../../services/VersementService'
import Swal from 'sweetalert2'

export default {
    data() {
        return {
            data: {
                montant: '',
                action: '',
            },
        }
    },

    methods: {
        showAlert(message, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: "success",
            }).then(() => {
                if (reloadPage) {
                    location.reload(); // Reload the page
                }
            });
        },
        setAction(action) {
            this.data.action = action;
        },
        async updateSolde() {
            const user_id = this.$route.params.user_id
            const formdata = new FormData()
            formdata.append('montant', this.data.montant)
            formdata.append('action', this.data.action)
            formdata.append('user_id', user_id)
            const response = await updateSoldeUser(formdata)

            if (response.status === 200) {
                this.showAlert(response.message, true)
            } else {
                this.showAlert(response.message)
            }
        }
    }
}
</script>

<template>
    <div class="modal fade" id="soldeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Modification du solde</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="updateSolde">
                        <div class="mb-3">
                            <label for="soldeInput" class="form-label">Modifier le solde</label>
                            <input type="number" name="solde" id="soldeInput" v-model="data.montant" class="form-control">
                        </div>
                        <button type="submit" class="btn btn-danger me-3" data-action="substract"
                            @click="setAction('substract')">
                            <i class='bx bx-minus'></i>
                        </button>
                        <button type="submit" class="btn btn-primary" data-action="add" @click="setAction('add')">
                            <i class='bx bx-plus'></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>