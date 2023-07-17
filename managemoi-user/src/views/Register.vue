<script>
import { GET_VILLES_TAB } from '../constant';
import { register } from '../services/AuthService';



export default {
    data() {
        return {
            status: false,
            message: '',
            loading: false,
            data: {
                name: '',
                contact: '',
                email: '',
                date_de_naissance: '',
                ville: '',
                quartier: '',
                password: '',
                sexe: '',
            }
        }
    },
    computed: {
        villesTriees() {
            return GET_VILLES_TAB.sort();
        },
    },
    methods: {
        calculateAge(dateOfBirth) {
            const today = new Date();
            const birthDate = new Date(dateOfBirth);
            let age = today.getFullYear() - birthDate.getFullYear();
            const monthDiff = today.getMonth() - birthDate.getMonth();

            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }

            return age;
        },
        showAlert(message) {
            this.$swal(message);
        },

        validateNumber() {
            // Expression régulière pour vérifier si le champ contient uniquement des chiffres
            const regex = /^\d+$/;

            if (!regex.test(this.data.contact)) {
                this.status = true;
            } else {
                this.status = false;
            }
        },
        async inscription() {
            this.loading = true
            const age = this.calculateAge(this.data.date_de_naissance);

            if (age < 16) {
                this.loading = false
                // Afficher un message d'erreur ou empêcher la soumission du formulaire
                return this.showAlert("Vous devez avoir au moins 18 ans !");
            }

            if (this.status) {
                this.loading = false
                this.message = "Entrez un numéro valide"
            } else {
                this.loading = true
                const formdata = new FormData()
                formdata.append('name', this.data.name)
                formdata.append('contact', this.data.contact)
                formdata.append('email', this.data.email)
                formdata.append('date_de_naissance', this.data.date_de_naissance)
                formdata.append('ville', this.data.ville)
                formdata.append('quartier', this.data.quartier)
                formdata.append('password', this.data.password)
                formdata.append('sexe', this.data.sexe)
                try {
                    const response = await register(formdata)

                    if (response.status === 200) {
                        this.loading = false
                        this.$router.push('/connexion')
                        this.showAlert(response.message)
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
                                    <img src="../assets/logo.jpeg" alt="managemoi logo">
                                    <span class="d-none d-lg-block">ManageMoi</span>
                                </a>
                            </div>
                            <div class="card mb-3">

                                <div class="card-body">

                                    <div class="pt-4 pb-2">
                                        <h5 class="card-title text-center pb-0 fs-4">Créer un compte</h5>
                                    </div>

                                    <form class="row g-3 needs-validation" @submit.prevent="inscription">
                                        <div class="col-12">
                                            <label for="name" class="form-label">Nom complet</label>
                                            <input type="text" name="name" v-model="data.name" class="form-control"
                                                id="yourName" required>
                                            <div class="invalid-feedback">S'il vous plait, entrer votre nom complet!</div>
                                        </div>

                                        <div class="col-12">
                                            <label for="contact" class="form-label">Numero de téléphone</label>
                                            <div class="input-group has-validation">
                                                <span class="input-group-text" id="contact">+225</span>
                                                <input type="text" name="contact" v-model="data.contact" maxlength="10"
                                                    minlength="10" class="form-control" id="contact" @input="validateNumber"
                                                    required>
                                            </div>
                                            <p class="text-danger" v-if="status">S'il vous plait entrez un numero de
                                                téléphone
                                                valide.</p>
                                        </div>

                                        <div class="col-12">
                                            <label for="yourEmail" class="form-label">Email</label>
                                            <input type="email" name="email" v-model="data.email" class="form-control"
                                                id="yourEmail" required>
                                            <div class="invalid-feedback">S'il vous plait entrez une adresse email valide!
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <label for="date_de_naissance" class="form-label">Date de naissance</label>
                                            <input type="date" name="date_de_naissance" v-model="data.date_de_naissance"
                                                class="form-control" id="date_de_naissance" required>
                                            <div class="invalid-feedback">Entrez votre date de naissance.</div>
                                        </div>

                                        <div class="col-12">
                                            <label for="sexe" class="form-label me-3">Sexe: </label>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                                    id="inlineRadio1" value="M" v-model="data.sexe">
                                                <label class="form-check-label" for="inlineRadio1">M</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="inlineRadioOptions"
                                                    id="inlineRadio2" value="F" v-model="data.sexe">
                                                <label class="form-check-label" for="inlineRadio2">F</label>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <label for="ville" class="form-label">Ville</label>
                                            <select name="ville" id="ville" class="form-select" v-model="data.ville">
                                                <option selected>-- Choisissez votre ville --</option>
                                                <option v-for="ville in villesTriees" :key="ville" :value="ville">{{ ville
                                                }}</option>
                                            </select>
                                            <div class="invalid-feedback">Entrez votre ville de residence!</div>
                                        </div>

                                        <div class="col-12">
                                            <label for="quartier" class="form-label">Quartier</label>
                                            <input type="text" name="quartier" v-model="data.quartier" class="form-control"
                                                id="quartier" required>
                                            <div class="invalid-feedback">Entrez le nom de votre quartier s'il vous plait!
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <label for="yourPassword" class="form-label">Mot de passe</label>
                                            <input type="password" name="password" class="form-control"
                                                v-model="data.password" id="yourPassword" minlength="8" required>
                                            <div class="invalid-feedback">S'il vous plait entrez un mot de passe!</div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-check">
                                                <input class="form-check-input" name="terms" type="checkbox"
                                                    id="acceptTerms" required>
                                                <label class="form-check-label" for="acceptTerms">Je suis d'accord et
                                                    j'accepte les <a
                                                        href="https://drive.google.com/file/d/1qCiOJvWVbTKkC9rjZPHJMzvW5RO8nlL5/view?usp=sharing">terms
                                                        and conditions</a><span class="text-danger">*</span></label>
                                                <div class="invalid-feedback">You must agree before submitting.</div>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <button class="btn btn-primary w-100" type="submit" :disabled="loading">
                                                <span v-if="!loading">Créer un compte</span>
                                                <div v-if="loading" class="spinner-border" role="status">
                                                    <span class="visually-hidden">Loading...</span>
                                                </div>
                                            </button>
                                        </div>
                                        <div class="col-12">
                                            <p class="small mb-0">J'ai déjà un compte ? <a href="/connexion">Connexion</a>
                                            </p>
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

<style scoped></style>