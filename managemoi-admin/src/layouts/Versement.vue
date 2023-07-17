<script>
import EnCours from '../components/versement/EnCours.vue'
import All from '../components/versement/All.vue';


export default {
    data() {
        return {
            isAllDemandeActive: false,
            isEnCoursActive: true,
        };
    },
    methods: {
        activateAll() {
            this.isAllDemandeActive = true;
            this.isEnCoursActive = false;
        },
        activateEnCours() {
            this.isAllDemandeActive = false;
            this.isEnCoursActive = true;
        },
    },
    components: { EnCours, All }
}
</script>

<template>
    <main class="main" id="main">
        <div class="pagetitle">
            <h1>Versements</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Accueil</a></li>
                    <li class="breadcrumb-item">Versements</li>
                    <li class="breadcrumb-item active">Liste des versements en attente</li>
                </ol>
            </nav>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-around align-items-center">
                                <button type="button" class="btn btn-outline-secondary"
                                    :class="{ 'btn-secondary text-white': isEnCoursActive }"
                                    @click="activateEnCours">Versements en cours</button>
                                <button type="button" class="btn btn-outline-primary"
                                    :class="{ 'btn-primary text-white': isAllDemandeActive }"
                                    @click="activateAll">Versements achevés</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12" v-show="isEnCoursActive">
                    <div class="card">
                        <div class="card-body">
                            <EnCours />
                        </div>
                    </div>
                </div>

                <div class="col-lg-12" v-show="isAllDemandeActive">
                    <div class="card">
                        <div class="card-body">
                            <All />
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</template>

<style scoped></style>