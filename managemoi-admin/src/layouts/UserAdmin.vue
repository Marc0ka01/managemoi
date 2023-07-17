<script>
import { registerAdmin, allAdmin, deleteUser } from '../services/AuthService'
import Swal from 'sweetalert2'

export default {
    components: {
        Swal
    },
    data() {
        return {
            admin: [],
            message: '',
            loading: false,
            data: {
                username: '',
                email: '',
                role: '',
                password: '',
            }
        }
    },
    mounted() {
        this.getAllAdmin()
    },
    methods: {
        showAlert(message, reloadPage = false) {
            Swal.fire({
                title: "Alert",
                text: message,
                icon: "success",
            }).then(() => {
                if (reloadPage) {
                    location.reload()
                }
            });
        },
        async getAllAdmin() {
            const response = await allAdmin()
            this.admin = response.admins

            if (this.admin.length <= 0) {
                this.message = "Aucun admin disponible"
            }

        },
        async addAdmin() {
            this.loading = true
            const formdata = new FormData()
            formdata.append('username', this.data.username)
            formdata.append('email', this.data.email)
            formdata.append('role', this.data.role)
            formdata.append('password', this.data.password)

            try {
                const response = await registerAdmin(formdata)

                if (response.status === 200) {
                    this.loading = false
                    this.showAlert("Succès", true)
                } else {
                    this.loading = false
                    this.showAlert("Erreur")
                }
            } catch (error) {
                this.loading = false
                this.showAlert("Une erreur est survenue !")
            }
        },
        async deleteAdmin(userId) {
            const swalResponse = await Swal.fire({
                title: 'Confirmation',
                text: 'Êtes-vous sûr de vouloir supprimer cet utilisateur ?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Oui, supprimer',
                cancelButtonText: 'Non, annuler',
            });

            if (swalResponse.isConfirmed) {
                const response = await deleteUser(userId);
                this.showAlert(response.message, true);
            }
        }


    }
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
                <div class="col-lg-7">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Listes des admin</h5>

                            <table class="table datatable">
                                <thead>
                                    <tr>
                                        <th scope="col">Nom</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody v-if="message === ''">
                                    <tr v-for="admin in admin">
                                        <td>{{ admin.username }}</td>
                                        <td>{{ admin.email }}</td>
                                        <td>
                                            <button type="button" @click="deleteAdmin(admin.id)" class="btn btn-danger"><i
                                                    class="bx bx-trash"></i></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <p class="text-muted text-center" v-if="message !== ''">{{ message }}</p>
                        </div>
                    </div>

                </div>

                <div class="col-lg-5">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Ajouter un admin</h5>
                            <form @submit.prevent="addAdmin">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Nom complet</label>
                                    <input type="text" name="username" id="name" v-model="data.username"
                                        class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" name="email" id="email" v-model="data.email" class="form-control"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label for="Role" class="form-label">Role</label>
                                    <select name="role" id="role" v-model="data.role" class="form-select">
                                        <option value="super admin">Super Admin</option>
                                        <option value="admin">Admin</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Mot de passe</label>
                                    <input type="password" name="password" v-model="data.password" id="password"
                                        class="form-control" required>
                                </div>

                                <button type="submit" class="btn btn-primary" :disabled="loading">
                                    <span v-if="!loading">Enregistrer</span>
                                    <div v-if="loading" class="spinner-border" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </main>
</template>