#' Normalization for compatability with VIAF contributors
#' 
#' @description
#' 'viaf_normalize()'' transforms xml nodes imported from viaf.xml, and
#' marc21.xml files into normalized name strings. The motivating example
#' is this xml element found in
#' [VAIF](https://viaf.org/viaf/253482919/viaf.xml)
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
#' @import xslt
#' @import xml2
#' @import stringr
#'
viaf_normalize <- function(string, source = "ALL") {
  normstring <- stringr::str_to_lower(string)
  if (source == "NDL" || source == "NII") {
    normstring <- stringr::str_replace_all(normstring, "[・]", " ")
    normstring <- stringr::str_replace_all(normstring, "[ガ]", "カ")
    normstring <- stringr::str_replace_all(normstring, "[ギ]", "キ")
    normstring <- stringr::str_replace_all(normstring, "[グ]", "ク")
    normstring <- stringr::str_replace_all(normstring, "[ゲ]", "ケ")
    normstring <- stringr::str_replace_all(normstring, "[ゴ]", "コ")
    normstring <- stringr::str_replace_all(normstring, "[ザ]", "サ")
    normstring <- stringr::str_replace_all(normstring, "[ジ]", "シ")
    normstring <- stringr::str_replace_all(normstring, "[ズ]", "ス")
    normstring <- stringr::str_replace_all(normstring, "[ゼ]", "セ")
    normstring <- stringr::str_replace_all(normstring, "[ゾ]", "ソ")
    normstring <- stringr::str_replace_all(normstring, "[ダ]", "タ")
    normstring <- stringr::str_replace_all(normstring, "[ヂ]", "チ")
    normstring <- stringr::str_replace_all(normstring, "[ヅ]", "ツ")
    normstring <- stringr::str_replace_all(normstring, "[デ]", "テ")
    normstring <- stringr::str_replace_all(normstring, "[ド]", "ト")
    normstring <- stringr::str_replace_all(normstring, "[バパ]", "ハ")
    normstring <- stringr::str_replace_all(normstring, "[ビピ]", "ヒ")
    normstring <- stringr::str_replace_all(normstring, "[ブプ]", "フ")
    normstring <- stringr::str_replace_all(normstring, "[ベペ]", "ヘ")
    normstring <- stringr::str_replace_all(normstring, "[ボポ]", "ホ")
    normstring <- stringr::str_remove_all(normstring, "[ー]")
  }
  normstring <- stringr::str_remove_all(normstring, "[:punct:]")
  normstring <- stringr::str_squish(normstring)
  normstring <- utf8::utf8_normalize(normstring)
  return(normstring)
}