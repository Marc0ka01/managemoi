<script>
import { allMessage, asRead } from '../services/AuthService'
import MessageModal from '../components/modal/MessageModal.vue'

export default {
    data() {
        return {
            data: [],
            message: "",
            id: 1,
            messageM: '',
            lien: '',
        };
    },
    mounted() {
        this.index();
    },
    methods: {
        formatDate(timestamp) {
            const date = new Date(timestamp);

            const day = String(date.getDate()).padStart(2, '0');
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const year = date.getFullYear();

            return `${day}-${month}-${year}`;
        },
        async index() {
            const response = await allMessage(); // Passer le terme de recherche à l'appel à l'API
            this.data = response.data; // Mettre à jour les données
            if (this.data.length <= 0) {
                this.message = "Aucun message pour vous !";
            }
        },
        async markedRead(index, message, lien) {
            this.messageM = message
            this.lien = lien
            const message_id = index

            const response = await asRead(message_id)
            if (response.status === 200) {
                console.log(response.message, index)
            }

        },
        truncated(desc) {
            const maxLength = 20; // Longueur maximale de la description
            if (desc.length <= maxLength) {
                return desc; // Retourne la description complète si elle est assez courte ou si l'option d'affichage complet est activée
            }
            else {
                return desc.substring(0, maxLength) + " ..."; // Tronque la description et ajoute "..." à la fin
            }
        },
    },
    components: { MessageModal }
}
</script>

<template>
    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Utilisateurs</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Accueil</a></li>
                    <li class="breadcrumb-item active">Utilisateur</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Vos messages</h5>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Message</th>
                                        <th scope="col">date d'envoi</th>
                                        <th scope="col">Lire</th>
                                    </tr>
                                </thead>
                                <tbody v-if="message === ''">
                                    <tr v-for="(row, index) in data" :key="index">
                                        <td>
                                            {{ truncated(row.message) }}
                                            <span class="badge rounded-pill bg-danger" v-if="!row.lu">!</span>
                                        </td>
                                        <td>{{ formatDate(row.date_send) }}</td>
                                        <td>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                                data-bs-target="#messageModal"
                                                @click="markedRead(index, row.message, row.lien)">
                                                <i class="bx bx-show"></i></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <p class="text-muted text-center" v-if="message !== ''">{{ message }}</p>
                        </div>
                    </div>

                </div>
            </div>
        </section>

    </main>

    <MessageModal :msg="messageM" :lien="lien" />
</template>

<style scoped></style>