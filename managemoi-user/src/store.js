import { createStore } from 'vuex'

const store = createStore({
    state: {
        user: {
            data: {},
            token: localStorage.getItem('auth_token'),
            roles: localStorage.getItem('roles'),
            userDetail: localStorage.getItem('user')
        }
    },
    mutations: {
        setToken(state, token) {
            state.user.token = token;
            localStorage.setItem('auth_token', token);
        },
        setRoles(state, roles) {
            state.user.roles = roles;
            localStorage.setItem('roles', roles);
        },
        setUser(state, user) {
            state.user.userDetail = user;
            localStorage.setItem('user', user);
        },
    },
})

export default store;