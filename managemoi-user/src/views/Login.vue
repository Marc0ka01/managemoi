<script>
import { login } from '../services/AuthService'
import store from '../store'

export default {
    data() {
        return {
            status: false,
            user: {
                contact: '',
                password: '',
            },
            loading: false,
        }
    },
    methods: {
        validateNumber() {
            // Expression régulière pour vérifier si le champ contient uniquement des chiffres
            const regex = /^\d+$/;

            if (!regex.test(this.user.contact)) {
                this.status = true;
            } else {
                this.status = false;
            }
        },
        showAlert(message) {
            this.$swal(message);
        },

        async connexion() {
            this.loading = true


            const formdata = new FormData()
            formdata.append('contact', this.user.contact)
            formdata.append('password', this.user.password)


            try {
                const response = await login(formdata)

                if (response.status === 200) {
                    store.state.user.token = response.access_token
                    store.state.user.roles = response.role
                    store.state.user.userDetail = response.user
                    localStorage.setItem('auth_token', store.state.user.token)
                    localStorage.setItem('roles', store.state.user.roles)
                    localStorage.setItem('user', JSON.stringify(store.state.user.userDetail))
                    this.$router.push('/')

                    this.loading = false

                    this.showAlert(response.message)
                } else {
                    this.loading = false

                    this.showAlert(response.message)
                }
            } catch (error) {
                this.loading = false
                this.showAlert("Une erreur s'est produite rééssayer s'il vous plait!")
            }

        }
    }
}

</script>


<template>
    <main>
        <div class="container">

            <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                            <div class="d-flex justify-content-center py-4">
                                <a href="/" class="logo d-flex align-items-center w-auto text-decoration-none">
                                    <img src="../assets/logo.jpeg" alt="managemoi log">
                                    <span class="d-none d-lg-block">ManageMoi</span>
                                </a>
                            </div>

                            <div class="card mb-3">

                                <div class="card-body">

                                    <div class="pt-4 pb-2">
                                        <h5 class="card-title text-center pb-0 fs-4">Connectez-vous</h5>
                                    </div>

                                    <form class="row g-3 needs-validation" @submit.prevent="connexion">

                                        <div class="col-12">
                                            <label for="yourUsername" class="form-label">Numero de téléphone</label>
                                            <div class="input-group has-validation">
                                                <span class="input-group-text" id="inputGroupPrepend">+225</span>
                                                <input type="text" name="contact" class="form-control" maxlength="10"
                                                    minlength="10" v-model="user.contact" @input="validateNumber"
                                                    id="yourUsername" required>

                                            </div>
                                            <p class="text-danger" v-if="status">Entrez un numero valide svp.</p>
                                        </div>

                                        <div class="col-12">
                                            <label for="yourPassword" class="form-label">Mot de passe</label>
                                            <input type="password" v-model="user.password" name="password"
                                                class="form-control" id="yourPassword" required>
                                            <div class="invalid-feedback">S'il vous plait entrez un mot de passe!</div>
                                        </div>

                                        <div class="col-12">
                                            <button class="btn btn-primary w-100" type="submit" :disabled="loading">
                                                <span v-if="!loading">Connexion</span>
                                                <div v-if="loading" class="spinner-border" role="status">
                                                    <span class="visually-hidden">Loading...</span>
                                                </div>
                                            </button>

                                        </div>
                                        <div class="col-12">
                                            <p class="small mb-0">Je n'ai pas de compte? <a href="/inscription">Créer
                                                    un
                                                    compte</a></p>
                                        </div>
                                    </form>

                                </div>
                            </div>

                            <div class="credits">
                                Fait par <a href="https://in-novation.tech/">IN-NOVATION</a>
                            </div>

                        </div>
                    </div>
                </div>

            </section>

        </div>
    </main>
</template>