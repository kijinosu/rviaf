#' Data frame (tibble) from VIAF cluster xml
#'
#' @description
#' 'viafxml2df()' reads xml downloaded from viaf.org, transforms it to an
#' xml, and from that xml produces
#' a tibble. This function draws on Dominic Bordelon's
#' read_marcxml() function in
#' \href{https://github.com/dojobo/marc21r}{__marc21r__}.
#' 
#' \preformatted{
#' <ns1:x400>
#' <ns1:datafield dtype="MARC21" ind1="1" ind2=" " tag="400">
#' <ns1:subfield code="a">千葉, 玄彌</ns1:subfield>
#' <ns1:normalized>仟叶 伭弥</ns1:normalized>
#' </ns1:datafield>
#' <ns1:sources>
#' <ns1:s>NII</ns1:s>
#' <ns1:sid>NII|DA0067554X</ns1:sid>
#' </ns1:sources>
#' </ns1:x400>
#' }
#'
#' @usage viafxml2df(x, xslt=NULL, ...)
#' @param x Loaded viaf.xml document.
#' @param xslt Loaded xslt stylesheet
#' @param pattern {Regular expression pattern for tranforming xslt output for name
#' authority datafields into named lists.}
#' @param intercache Directory in which to story intermediate xml
#' output from transform.
#'
#' @import dplyr
#' @import purrr
#' @import stringi
#' @import tidyr
#' @import xml2
#' @import xslt
#' @importFrom tibble tibble
#' @importFrom magrittr "%>%"
#' @importFrom lubridate ymd_hms now ymd
#'
#' @return The target tibble containing columns determined by the xslt transform.
#' @export
viafxml2df <- function(x, # nolint
      xslt = NULL, # nolint
      pattern = NULL,
      params = list(), # nolint
      intercache = tempdir(), # nolint
      ...) { # nolint
  ps <- params
  if (length(ps) == 0) {
    vv <- as.character(utils::packageVersion("viafr"))
    pt <- as.character(lubridate::now("UTC"))
    ps <- list(viafrversion = vv, now = pt)
  }
  dataxml <- xslt::xml_xslt(x, xslt, params = ps)
  rootname <- xml2::xml_name(xml2::xml_root(dataxml))
  if (file.exists(intercache)) {
    vid <- xml2::xml_attr(xml2::xml_root(dataxml), attr = "viafid")
    wpath <- file.path(intercache, paste0(vid, ".", rootname, ".xml", sep = ""))
    xml2::write_xml(dataxml, wpath, options = "format", encoding = "UTF-8")
  }

  ## this gets the tibble out of the intermediary xml
  chlds <- xml2::xml_find_all(xml2::xml_root(dataxml), "row")
  if (length(chlds) == 0) return(NULL)

  labs <- trimws(xml2::xml_name(xml2::xml_children(chlds[1])))
  colclasses <- xml2::xml_attr(xml2::xml_children(chlds[1]), "ct")

  df <- read.table(text = "", colClasses = colclasses, col.names = labs)
  len <- length(chlds)
  for (i in 1:len) {
    cells <- xml2::xml_children(chlds[i])
    nocells <- length(cells)

    dv <- read.table(text = "", colClasses = colclasses, col.names = labs)
    for (j in 1:nocells) {
      cellcontents <- xml2::xml_contents(cells[j])
      tryCatch(
        {
          dv[1, j] <- switch(colclasses[j],
              "character" = as.character(cellcontents), # nolint
              "Date" = lubridate::ymd(xml2::xml_text(cells[j]),truncated = 2, quiet = TRUE), # nolint
              "POSIXct" = lubridate::ymd_hms(xml2::xml_text(cells[j]), quiet = TRUE), # nolint
              "factor" = as.factor(xml2::xml_text(cells[j])),
              "logical" = as.logical(xml2::xml_text(cells[j])),
              "integer" = as.integer(xml2::xml_text(cells[j])),
              "list" = .texttolist(xml2::xml_text(cells[j]),pattern))
        },
        error = function(cond) {
          message(paste("Error: viafxml2df Record ", i, " Cell ", j))
          message(paste("pattern: ", pattern ))
          message(paste("Content: ", xml2::xml_text(cells[j])))
          message(conditionMessage(cond))
        },
        warning = function(cond) {
          message(paste("Warning: viafxml2df Record ", i, " Cell ", j))
          message(paste("pattern: ", pattern ))
          message(paste("Content: ", xml2::xml_text(cells[j])))
          message(paste("Content: ", as.character(xml2::xml_text(cells[j]))))
          message(conditionMessage(cond))
        }
      )
    }
    df <- rbind(df, dv)
  }
  result <- dplyr::tibble(df)

  return(result)
}

.texttolist <- function(t, pattern = NULL) {
  defaultpat <-  "(?<code>\\w++)=[{](?<value>([^}]++))[}]"
  pat <- ifelse(is.null(pattern),defaultpat, pattern)
  con <- textConnection(t)
  tryCatch(
    {
      dat <- readLines(con)
    },
    error = function(cond) {
      message(paste("Error: texttolist readLines "))
      message(paste("Content: ", t ))
      message(conditionMessage(cond))
    },
    warning = function(cond) {
      message(paste("Warning: texttolist readLines "))
      message(paste("Content: ", as.character(t)))
      message(conditionMessage(cond))
    }
  )
  close(con)
  ms <- lapply(dat, function(v) {
    tryCatch(
      {
        mm <- stri_match_all_regex(v, pat )
      },
      error = function(cond) {
        message(paste("Error: texttolist stri_match_all_regex "))
        message(paste("pattern: ", pat ))
        message(paste("Content: ", as.character(v) ))
        message(conditionMessage(cond))
      },
      warning = function(cond) {
        message(paste("Warning: texttolist stri_match_all_regex "))
        message(paste("pattern: ", pat ))
        message(paste("Content: ", as.character(v)))
        message(conditionMessage(cond))
      }
    )
    tryCatch(
      {
        rs <-lapply(mm, function(x) {
          nams <- x[,2]
          vals <- x[,3]
          lvals <- split(vals , seq_len(nrow(x)))
          names(lvals ) <- nams
          return(lvals)
        })
      },
      error = function(cond) {
        message(paste("Error: texttolist rs lapply "))
        message(paste("Content: ", as.character(mm) ))
        message(conditionMessage(cond))
      },
      warning = function(cond) {
        message(paste("Warning: texttolist readLines "))
        message(paste("Content: ", as.character(mm)))
        message(conditionMessage(cond))
      }
    )
  } )
  return(ms)
}