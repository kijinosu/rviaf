#' Get VIAF cluster IDs
#'
#' @description Get VIAF cluster from LC and other IDs
#'
#' @rdname getviafid
#' @usage getviafid_lccn(lccns)
#' @param lccns A list of Library of Congress Control Numbers
#' @param cache Directory for (usually temporary) downloaded responses
#' @return A tibble of LC control numbers and corresponding VIAF IDs.
#' @details The [Authority Cluster Resource](https://www.oclc.org/developer/api/oclc-apis/viaf/authority-cluster.en.html)
#' of the VIAF API provides redirect responses to queries of Library of Congress control numbers
#' and Source ID's. When queried using the [curl::multi_download()] function of
#' [Jeroen Ooms's R package curl](https://github.com/jeroen/curl),
#' one gets a data.frame that contains the final url (after redirects) of the request.
#' This final url is to the VIAF cluster to which the control number belongs. This url
#' contains the desired VIAF ID. 
#' @importFrom curl multi_download
#' @importFrom stringi stri_match_first_regex
#' @import tibble
#' @export
getviafid_lccn <- function(lccns = NULL, cache = tempdir()) {
    library(curl)
    library(tibble)
    library(stringi)
    pat <- "https://viaf.org/viaf/(\\d++)/"
    dfiles <- file.path(cache,paste0(lccns,".html",sep=""))
    url <- paste0("https://viaf.org/viaf/lccn/",tolower(lccns),sep="")
    results <- curl::multi_download(url, dfiles)
    viafids <- stringi::stri_match_first_regex(results$url,pattern=pat)[,2]
    tb <- tibble(lccn = lccns, viafID = viafids)
    return(tb)
}

#' @description Get VIAF cluster from LC and other IDs
#'
#' @rdname getviafid
#' @usage getviafid_sourceids(sids)
#' @param sids A list of source IDs in the format ```{SRC}|{number}```, for example,
#' ```DNB|1034425390```.
#' @param cache Directory for (usually temporary) downloaded responses
#' @return A tibble of source ID numbers and corresponding VIAF IDs.
#' @importFrom curl multi_download
#' @importFrom stringi stri_match_first_regex
#' @import tibble
#' @export
getviafid_sourceids <- function(sids = NULL, cache = tempdir()) {
    library(curl)
    library(tibble)
    library(stringi)
    pat <- "https://viaf.org/viaf/(\\d++)/"
    dfiles <- file.path(cache,paste0(sids,".html",sep=""))
    url <- paste0("https://viaf.org/viaf/sourceID/",tolower(sids),sep="")
    results <- curl::multi_download(url, dfiles)
    viafids <- stringi::stri_match_first_regex(results$url,pattern=pat)[,2]
    tb <- tibble(sourceID = sids, viafID = viafids)
    return(tb)
}

