const errorHandler = (error, router) => {
    // Vérifiez si l'erreur est une erreur réseau (exemple: erreur de connexion)
    if (!error.response) {
        console.error('Erreur réseau:', error.message);
        // Gérez l'erreur réseau selon vos besoins (par exemple, afficher un message d'erreur à l'utilisateur)
        return;
    }

    // Récupérez les détails de l'erreur de réponse de l'API
    const { status, data } = error.response;

    // Gérez les codes d'erreur spécifiques comme vous le souhaitez
    if (error.response && error.response.status === 401) {
        // Redirection vers la page de connexion
        localStorage.removeItem('auth_token')
        localStorage.removeItem('user')
        localStorage.removeItem('roles')
        router.push('/connexion');
    }

    // Gérez d'autres codes d'erreur ici

    // Affichez un message d'erreur générique pour les erreurs non gérées
    console.error('Erreur de requête:', status, data);
};

export default errorHandler;
