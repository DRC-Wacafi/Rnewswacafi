#' Fonction pour récupérer les news par les endpoints
#'
#' Cette fonction récupère les données publiés dà les variables de flitrage configurées.
#'
#' @param connect_info Une liste contenant les informations d'authentification, obtenue en utilisant la fonction `api_connect`.
#' @param start_date La date de début de la période de sélection des données (format "yyyy-mm-dd").
#' @param end_date La date de fin de la période de sélection des données (format "yyyy-mm-dd").
#' @return Une table de données, avec leurs détails tels que l'identifiant, le titre, la description, le contenu, la date de publication, le pays, le tri par pays, le nombre de commentaires et les mentions.
#'
#' @import httr
#' @import jsonlite
#'
#' @examples
#' # Utilisation de la fonction pour récupérer les news par date
#' api_key <- "6a07a7ee-ade3-4209-aa1b-b4504ebc0e68"
#' api_secret <- "pbkdf2_sha256$600000$eVJKaltgn341HcwJWfVlWg$bpuIG09itt+g1R2MDOzS/QMoJstT6bWZTTVTcQlQ3cc="
#' connect_info <- api_connect(api_key = api_key, api_secret = api_secret)
#' start_date <- as.Date("2024-01-01")
#' end_date <- as.Date("2024-01-31")
#' news <- get_news(connect_info, start_date, end_date)
#' head(news,2)
#'
#' @export

get_news <- function(connect_info, start_date, end_date) {
  base_url <- connect_info$base_url

  if (is.null(start_date) || is.null(end_date)) {
    stop("start_date and end_date are required")
  }

  start_date <- format(start_date, "%d-%m-%Y")
  end_date <- format(end_date, "%d-%m-%Y")
  url <- paste0(base_url, "/news/?start_date=", start_date, "&end_date=", end_date)

  response <- httr::GET(url, add_headers(.headers = connect_info$headers))

  if (http_type(response) == "application/json" && response$status_code == 200) {
    json_data <- httr::content(response, as = "text")
    news_df <- jsonlite::fromJSON(json_data)$data[,c("date","country","countrysort",
                                    "title","description","content","ncomments","mentions")]
    return(news_df)
  } else {
    error <- content(response, as = "text")
    if ("detail" %in% names(error)) {
      stop(error$detail)
    } else if ("message" %in% names(error)) {
      stop(error$message)
    } else {
      stop("An error occured")
    }
  }
}


