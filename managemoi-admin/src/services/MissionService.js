import { api } from '../api'

export async function index(currentPage, searchMission='') {
    try {
        const response = await api.get(`/missions?page=${currentPage}&search=${searchMission}`)
        return response.data
    } catch{
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function show(missionId){
    try {
        const response = await api.get(`/missions/${missionId}/read`)

        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function createMission(formdata) {
    try {
        const response = await api.post(`/missions/create`, formdata);
        return response.data
    } catch {
        // Gestion des erreurs
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function updateMission(formdata, missionId) {
    try {
        const response = await api.post(`/missions/${missionId}/update`, formdata);

        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function getUsersByMission(mission_id, currentPage, searchSoumission='') {
    try {
        const response = await api.get(`/missions/getUsersBymission?mission_id=${mission_id}&page=${currentPage}&search=${searchSoumission}`)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function missionHistory(userId) {
    try {
        const response = await api.get(`/missions/demande-mission/hitorique/${userId}`)
        return response.data
    } catch{
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}