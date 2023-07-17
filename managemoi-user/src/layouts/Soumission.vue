<script>
import { submit } from '../services/MissionService'

export default {
    data() {
        return {
            img: {
                screenOne: null,
                screenTwo: null,
                screenThree: null
            },
            imgUrl: {
                screenOne: null,
                screenTwo: null,
                screenThree: null
            },
            loading: false,
        }
    },
    methods: {
        showAlert(message) {
            this.$swal(message);
        },
        // chargement des images
        onScreenOneChange(event) {
            this.img.screenOne = event.target.files[0];
            this.imgUrl.screenOne = URL.createObjectURL(this.img.screenOne)
        },
        onScreenTwoChange(event) {
            this.img.screenTwo = event.target.files[0];
            this.imgUrl.screenTwo = URL.createObjectURL(this.img.screenTwo)
        },
        onScreenThreeChange(event) {
            this.img.screenThree = event.target.files[0];
            this.imgUrl.screenThree = URL.createObjectURL(this.img.screenThree)
        },
        async soumission() {
            this.loading = true

            const formdata = new FormData()
            formdata.append('mission_id', this.$route.params.mission_id)
            formdata.append('screen_one', this.img.screenOne)
            formdata.append('screen_two', this.img.screenTwo)
            formdata.append('screen_three', this.img.screenThree)
            try {
                const response = await submit(formdata)
                if (response.status === 200) {
                    this.loading = false
                    this.$router.push('/missions')
                    this.showAlert(response.message)
                } else {
                    this.loading = false
                    this.showAlert("Une erreur est survenue rééssayez plus tard !")
                }
            } catch (error) {
                this.loading = false
                this.showAlert("Une erreur est survenue rééssayez plus tard !")
            }
        }
    }
}
</script>

<template>
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Soumission</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><router-link to="/" class="text-decoration-none">Accueil</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/missions"
                            class="text-decoration-none">Missions</router-link></li>
                    <li class="breadcrumb-item active">Soumission</li>
                </ol>
            </nav>
        </div>

        <!-- form soumission -->
        <section class="section">
            <div class="row">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Formulaire de soumission</h5>
                            <form @submit.prevent="soumission">
                                <div class="mb-3">
                                    <label for="inputText" class="form-label">Capture d'écran 1</label>
                                    <input type="file" class="form-control" accept="image/*" @change="onScreenOneChange"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label for="inputEmail" class="form-label">Capture d'écran 2</label>
                                    <input type="file" class="form-control" accept="image/*" @change="onScreenTwoChange"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label for="inputEmail" class="form-label">Capture d'écran 3 (Facultatif)</label>
                                    <input type="file" class="form-control" accept="image/*" @change="onScreenThreeChange">
                                </div>

                                <div class="row mb-3">
                                    <div class="col-sm-10">
                                        <button type="submit" class="btn btn-primary" :disabled="loading">
                                            <span v-if="!loading">Soumettre</span>
                                            <div v-if="loading" class="spinner-border" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>
                                        </button>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Prévisualisez vos images</h5>
                            <div class="row">
                                <div class="col-md-12 mb-4" v-if="imgUrl.screenOne">
                                    <h5 class="text-muted mb-3">Screen 1</h5>
                                    <img :src="imgUrl.screenOne" alt="" class="img-thumbnail">
                                </div>
                                <div class="col-md-12" v-if="imgUrl.screenTwo">
                                    <h5 class="text-muted mb-3">Screen 2</h5>
                                    <img :src="imgUrl.screenTwo" alt="" class="img-thumbnail">
                                </div>

                                <div class="col-md-12" v-if="imgUrl.screenThree">
                                    <h5 class="text-muted mb-3">Screen 3</h5>
                                    <img :src="imgUrl.screenThree" alt="" class="img-thumbnail">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</template>

<style scoped></style>