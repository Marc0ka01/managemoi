import { api } from "../api"

export async function index(currentPage) {
    try {
        const response = await api.get(`/missions?page=${currentPage}`)

        return response.data
    } catch (error) {
        console.error(error)
    }
}

export async function show(mission_id){
    try {
        const response = await api.get(`/missions/${mission_id}/read`)
        return response.data
    } catch (error) {
        console.error(error)
    }
}

export async function submit(formdata){
    try {
        const response = await api.post(`/missions/submit-mission`, formdata)

        // Actualiser le solde de l'utilisateur dans le localStorage
        const currentUser = JSON.parse(localStorage.getItem('user'));
        const updatedUser = {
            ...currentUser,
            solde: response.data.solde,
            missions_effectuees: response.data.missions_effectuees
        };
        localStorage.setItem('user', JSON.stringify(updatedUser));

        return response.data
    } catch (error) {
        console.error(error)
    }
}