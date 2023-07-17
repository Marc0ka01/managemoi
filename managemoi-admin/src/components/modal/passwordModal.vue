<script>
import {updatePassword} from '../../services/AuthService'
import Swal from 'sweetalert2'

export default {
    data() {
        return {
            data: {
               password: '',
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
        async updatesPassword() {
            const user_id = this.$route.params.user_id
            const formdata = new FormData()
            formdata.append('password', this.data.password)
            formdata.append('user_id', user_id)
            console.log(formdata)
            const response = await updatePassword(formdata)
            

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
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Modification du mot de passe</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="updatesPassword">
                        <div class="mb-3">
                            <label for="passwordInput" class="form-label">Nouveau mot de passe</label>
                            <input type="text" minlength="8" name="password" id="passwordInput" v-model="data.password" class="form-control">
                        </div>
                        <button type="submit" class="btn btn-primary me-3">
                            Modiifer
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>