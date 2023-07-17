import axios from 'axios';
import { API_LINK } from './constant';

// Instance avec autorisation
const api = axios.create({
    baseURL: `${API_LINK}`,
    headers: {
        'Content-Type': 'application/json',
        'Content-Type':'multipart/form-data'
    },
});

// Instance sans autorisation
const apiWithoutAuth = axios.create({
    baseURL: `${API_LINK}`,
    headers: {
        'Content-Type': 'application/json',
        // Autres en-têtes nécessaires pour les requêtes sans autorisation
    },
});

// Intercepteur d'autorisation
api.interceptors.request.use((config) => {
    const token = localStorage.getItem('auth_token');
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

export { api, apiWithoutAuth };
