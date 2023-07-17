import { api, apiWithoutAuth } from '../api'


export async function allUser(currentPage, searchUser = '') {
    try {
        const response = await api.get(
            `/utilisateurs?page=${currentPage}&search=${searchUser}`
        );
        return response.data;
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}


export async function allAdmin() {
    try {
        const response = await api.get(`/admin/all`)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function showUser(user_id) {
    try {
        const response = await api.get(`/utilisateurs/${user_id}/show`)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export function getStore() {
    const user = localStorage.getItem('user')
    const data = JSON.parse(user)
    return data
}

export async function register(formdata) {
    try {
        const response = await api.post(`/register`, formdata)

        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function registerAdmin(formdata) {
    try {
        const response = await api.post(`/admin/create`, formdata)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement d'un admin ou super admin");
    }
}

export async function login(formdata) {
    try {
        const response = await apiWithoutAuth.post(`/admin/login`, formdata)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de la connexion");
    }
}

export async function deleteUser(userId) {
    try {
        const response = await api.delete(`/admin/${userId}/destroy`)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de la supression de l'utilisateur");
    }
}

export async function banUsers(userId) {
    try {
        const response = await api.post(`/utilisateurs/${userId}/bannir`)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors du banissement de l'utilisateur");
    }
}

export async function updatePassword(formdata) {
    try {
        const response = await api.post('/utilisateurs/update_password', formdata)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de la modification du mot de passe");
    }
}

export async function activeUsers(userId) {
    try {
        const response = await api.put(`/utilisateurs/${userId}/activate`)

        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'activation de l'utilisateur");
    }
}

export async function isSuperActif(formdata) {
    try {
        const response = await api.post(`/admin/change_statut`, formdata)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors du changement du statut de l'utilisateur");
    }
}

// send message
export async function sendMessage(formdata){
    try {
        const response = await api.post('/admin/send-message', formdata)
        return response.data
    } catch (error) {
        throw new Error("Une erreur s'est produite lors de l'envoi du message");
    }
}