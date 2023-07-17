import { api, apiWithoutAuth } from "../api"

export function getStore() {
    const user = localStorage.getItem('user')
    const data = JSON.parse(user)
    return data
}

export async function register(formdata) {
    try {
        const response = await apiWithoutAuth.post(`/register`, formdata)
        return response.data
    } catch (error) {
        console.error(error)
    }
}

export async function login(formdata) {
    try {
        const response = await apiWithoutAuth.post(`/user/login`, formdata)
        return response.data
    } catch (error) {
        console.error(error)
    }
}

export async function allMessage(){
    try {
        const response = await api.get(`/admin/show-message`)
        return response.data
    } catch (error) {
        console.error(error)
    }
}

export async function asRead(message_id){
    try {
        const response = await api.put(`/messages/mark-as-read/${message_id}`)
        return response.data
    } catch (error) {
        console.log(error);
    }
}