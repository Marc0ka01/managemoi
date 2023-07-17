import { api } from '../api';



export async function showDemande(statut, currentPage, searchAll='') {
    try {
        const response = await api.get(`/versements/all?statut=${statut}&page=${currentPage}&search=${searchAll}`)
        return response.data
    } catch{
        throw new Error("Une erreur s'est produite lors de l'affichage des versements");
    }
}

export async function versementHistory(userId){
    try {
        const response = await api.get(`/versements/demande-versement/hitorique/${userId}?statut=effectue,echoue`)
        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function updateSoldeUser(formdata){
    try {
        const response = await api.post(`/versements/update-solde`, formdata)

        return response.data
    } catch {
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function updateVersementUser(formdata){
    try {
        const response = await api.post(`/versements/update-versement`, formdata)
        return response.data
    } catch{
        throw new Error("Une erreur s'est produite lors de l'enregistrement de la mission");
    }
}

export async function showTransac(user_id){
    const response = await api.get(`/users/transac_history?user_id=${user_id}`)
    return response.data
}