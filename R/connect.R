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
#' api_key <- "8c2cf1af-c970-47dd-a3fb-9841b2e9e8ed"
#' api_secret <- "pot_SvtyFegiqK2YckFNfAXPgjdNtVrM8BdW_jKd-zo"
#' connection_info <- api_connect(api_key = api_key, api_secret = api_secret)
#'
#' @export

api_connect <- function(api_key, api_secret) {
  base_url <- 'api.newswacafi.online/api'

  headers <- c(
    "Api-Key" = api_key,
    "Api-Secret" = api_secret
  )

  return(list(base_url = base_url, headers = headers))
}

