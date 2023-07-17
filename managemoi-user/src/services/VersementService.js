import { api } from "../api"

export async function versement(currentPage) {
    try {
        const response = await api.get(`/versements/show?page=${currentPage}`)

        return response.data
    } catch (error) {
        console.error(error)
    }
}

export async function demandeVersement(formdata) {
    try {
        const response = await api.post(`/versements/demande-versement`, formdata)

        // Actualiser le solde de l'utilisateur dans le localStorage
        if (response.data.status === 200) {
            const currentUser = JSON.parse(localStorage.getItem('user'))
            const updatedUser = {
                ...currentUser,
                solde: response.data.solde,
            }
            localStorage.setItem('user', JSON.stringify(updatedUser))
        }

        return response.data
    } catch (error) {
        console.error(error)
    }
}