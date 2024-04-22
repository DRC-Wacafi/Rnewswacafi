#' Fonction pour récupérer les news par les endpoints
#'
#' Cette fonction récupère les données publiées dans les variables de filtrage configurées. Pour plus de détails, consultez la documentation à l'adresse suivante : https://docs.newswacafi.online/
#'
#' @param connect_info Une liste contenant les informations d'authentification, obtenue en utilisant la fonction `api_connect`.
#' @param start_date La date de début de la période de sélection des données (format "yyyy-mm-dd").
#' @param end_date La date de fin de la période de sélection des données (format "yyyy-mm-dd").
#' @param query Requête pour filtrer les données par mots-clés (facultatif), ex: query='securité au sahel'.
#' @param source Source des données (facultatif), ex: source=c('journaldumali.com', 'faso.net').
#' @param category Catégorie des données (facultatif), ex: category=c('economique','politique').
#' @param country Pays des données (facultatif), ex: country=c('ml')
#' @return Une table de données, avec leurs détails tels que l'identifiant, le titre, la description, le contenu, la date de publication, le pays, le tri par pays, le nombre de commentaires et les mentions.
#'
#' @import httr
#' @import jsonlite
#'
#' @examples
#'
#' # Utilisation de la fonction pour récupérer les news par date
#' api_key <- "8c2cf1af-c970-47dd-a3fb-9841b2e9e8ed"
#' api_secret <- "pot_SvtyFegiqK2YckFNfAXPgjdNtVrM8BdW_jKd-zo"
#' connect_info <- api_connect(api_key = api_key, api_secret = api_secret)
#' start_date <- as.Date("2024-01-01")
#' end_date <- as.Date("2024-01-31")
#' news <- get_news(connect_info, start_date, end_date)
#' head(news,2)
#'
#' @details
#' Possible values for each parameter:
#'
#' Source:
#' - lefaso.net
#' - burkina24.com
#' - sidwaya.info
#' - aib.media
#' - lesahel.org
#' - actuniger.com
#' - levenementniger.com
#' - journaldumali.com
#' - maliweb.net
#' - maliactu.net
#'
#' Category:
#' - Politique
#' - Economique
#' - Society
#' - Gouvernance
#'
#' Country:
#' - ml (Mali)
#' - bf (Burkina Faso)
#' - ne (Niger)
#'
#' @export

get_news <- function(connect_info, start_date, end_date, query=NULL,
                     source=NULL, category=NULL, country=NULL) {
  base_url <- connect_info$base_url

  if (is.null(start_date) || is.null(end_date)) {
    stop("start_date and end_date are required")
  }

  start_date <- as.POSIXct(start_date, format="%d-%m-%Y")
  end_date <- as.POSIXct(end_date, format="%d-%m-%Y")

  url <- paste0(base_url, "/news/?start_date=", start_date, "&end_date=", end_date)

  if(!is.null(source)) {
    source <- gsub(" ", "", source)
    source <- paste0("&source=", paste(source, collapse = ","))
    url <- paste0(url, source)
  }

  if(!is.null(category)) {
    category <- gsub(" ", "", category)
    category <- paste0("&category=", paste(category, collapse = ","))
    url <- paste0(url, category)
  }

  if(!is.null(country)) {
    country <- gsub(" ", "", country)
    country <- paste0("&country=", paste(country, collapse = ","))
    url <- paste0(url, country)
  }

  if(!is.null(query)) {
    url <- paste0(url, "&query=", query)
  }

  req_url <- utils::URLencode(url)
  response <- httr::GET(req_url, httr::add_headers(.headers = connect_info$headers))

  if (response$headers$`content-type` == "application/json" && response$status_code == 200) {
    json_data <- httr::content(response, as = "text", encoding = "UTF-8")
    json_list <- jsonlite::fromJSON(json_data)
    if(length(json_list$data) == 0){
      #warning("No data in this selection.")
      cat("No data in this selection.\n")
      news_df <- data.frame(NULL)
    }else{
      news_df <- json_list$data[,c("date","country","countrysort",
                        "title","description","content","category","ncomments","mentions",
                        "source","link")]
    }
    return(news_df)
  } else {
    error <- httr::content(response, as = "text", encoding = "UTF-8")
    error <- jsonlite::fromJSON(error)
    if("error" %in% names(error)) {
      stop(error$error)
    } else if ("detail" %in% names(error)) {
      stop(error$detail)
    } else if ("message" %in% names(error)) {
      stop(error$message)
    } else {
      stop("An error occured")
    }
  }
}


