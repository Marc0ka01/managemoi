<script setup>
import Navbar from '../components/Navbar.vue'
import Sidebar from '../components/Sidebar.vue'
import Footer from '../components/Footer.vue'
</script>

<template>
    <div class="bodyDash">
        <Navbar />
        <Sidebar />

        <router-view></router-view>

        <Footer />
    </div>
</template>

<style scoped></style>