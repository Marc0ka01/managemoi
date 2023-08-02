<script>
import { sendMessage } from '../../services/AuthService'
import Swal from 'sweetalert2'
export default {
    data() {
        return {
            date: null,
            message: '',
            user_id: this.$route.params.user_id,
            loading: false,
            lien: '',
        }
    },
    created() {
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0'); // Ajoute un zéro en tête si le mois est inférieur à 10
        const day = String(today.getDate()).padStart(2, '0'); // Ajoute un zéro en tête si le jour est inférieur à 10
        const hours = String(today.getHours()).padStart(2, '0'); // Ajoute un zéro en tête si l'heure est inférieure à 10
        const minutes = String(today.getMinutes()).padStart(2, '0'); // Ajoute un zéro en tête si les minutes sont inférieures à 10
        const seconds = String(today.getSeconds()).padStart(2, '0'); // Ajoute un zéro en tête si les secondes sont inférieures à 10

        this.date = new Date(year, month - 1, day, hours, minutes, seconds); // Ajoute un zéro en tête si le jour est inférieur à 10
    },
    methods: {
        showAlert(message, icon, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: icon,
            }).then(() => {
                if (reloadPage) {
                    window.location.reload(); // Reload the page
                }
            });
        },
        async sendM() {
            this.loading = true
            const formdata = new FormData()
            formdata.append('message', this.message)
            formdata.append('user_id', this.user_id)
            formdata.append('date_send', this.date)
            formdata.append('lien', this.lien)

            const response = await sendMessage(formdata)

            if (response.status === 200) {
                this.loading = false
                this.showAlert(response.message, 'success', true)
            } else {
                this.loading = false
                this.showAlert(response.message, 'error', true)
            }
        }
    }
}
</script>

<template>
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Envoyez un message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="sendM">
                        <div class="mb-3">
                            <label for="passwordInput" class="form-label">Message</label>
                            <textarea name="message" id="message" cols="10" rows="5" v-model="message"
                                class="form-control" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="lien" class="form-label">lien</label>
                            <input type="text" name="lien" id="lien" v-model="lien"
                                class="form-control">
                        </div>
                        <button type="submit" class="btn btn-primary me-3" :disabled="loading">
                            <span v-if="!loading">Envoyer</span>
                            <div v-if="loading" class="spinner-border" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>