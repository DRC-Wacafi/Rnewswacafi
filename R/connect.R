#' Fonction pour établir la connexion à l'API
#'
#' Cette fonction établit une connexion à l'API en utilisant les clés d'API fournies.
#'
#' @param api_key La clé d'API utilisée pour l'authentification.
#' @param api_secret Le secret d'API utilisé pour l'authentification.
#' @return Une liste contenant l'URL de base de l'API et les en-têtes d'authentification.
#'
#' @import httr
#' @import jsonlite
#'
#' @examples
#' # Utilisation de la fonction pour établir une connexion à l'API
#' api_key <- "6a07a7ee-ade3-4209-aa1b-b4504ebc0e68"
#' api_secret <- "pbkdf2_sha256$600000$eVJKaltgn341HcwJWfVlWg$bpuIG09itt+g1R2MDOzS/QMoJstT6bWZTTVTcQlQ3cc="
#' connection_info <- api_connect(api_key = api_key, api_secret = api_secret)
#'
#' @export

api_connect <- function(api_key, api_secret) {
  base_url <- 'http://173.249.41.98/api'

  headers <- c(
    "Api-Key" = api_key,
    "Api-Secret" = api_secret
  )

  return(list(base_url = base_url, headers = headers))
}

