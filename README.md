rviaf - Another R client for VIAF cluster and authority records
================
Alan Engel
03 October, 2024

<!-- README.md is generated from README.Rmd. Please edit that file -->

# rviaf - Another R client for VIAF cluster and authority records

## Overview

This R package is forked from Stefanie Schneider’s original viafr
package at [GitHub](https://github.com/stefanieschneider/viafr)
([Schneider 2024](#ref-schneider2024viafr)). The objective is to extend
the original package to enable discovery of social networks of coauthors
from VIAF clusters. VIAF is an OCLC service that combines multiple LAM
(Library, Archive, and Museum) name authority files into a single name
authority service. It thus provides direct access to linked names for
the same entity across the world’s major name authority files, including
national and regional variations in language, character set, and
spelling. For more information go to [VIAF](https://viaf.org/).

This R package uses the VIAF (Virtual International Authority File) API.

## Installation

To install this development version from
[GitHub](https://github.com/kijinosu/rviaf) use:

``` r
# install.packages("devtools")
devtools::install_github("kijinosu/rviaf")  
```

You can install the original released version of viafr from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("viafr")
```

The development version of `viafr` can be installed from
[GitHub](https://github.com/stefanieschneider/viafr) with

``` r
# install.packages("devtools")
devtools::install_github("stefanieschneider/viafr") 
```

## Key background work

([Hajra 2020](#ref-hajra2020content)) proposed using globally known
persistent identifiers, such as VIAF IDs, in an algorithmic approach to
disambiguate authors. Particularly relevant is Hajra’s use of co-author
data from VIAF clusters.

## Other related work

- [viafr](https://github.com/stefanieschneider/viafr) R Interface to the
  VIAF (Virtual International Authority File) API ([Schneider
  2024](#ref-schneider2024viafr))

- [viaf](https://github.com/njahn82/viaf) R client for VIAF (Virtual
  International Authority File)([Jahn 2015](#ref-najko2015))

- [vocab-apis](https://github.com/jhu-library-applications/vocab-apis)
  Python scripts to pull and convert data between Library of Congress
  vocabularies and other external vocabularies (GeoNames, VIAF, etc)
  ([Janowiecki 2023](#ref-janowiecki2023vocab))

- [VIAF NPM](https://github.com/phette23/viaf-npm) JavaScript wrapper
  for the VIAF API in node ([Phetteplace 2014](#ref-phetteplace2014))

- [VIAF Information Service for
  CollectiveAccess](https://github.com/ideesculture/ca_viaf) PHP -
  Queries the VIAF for Personal Names and outputs the first page of hits
  to choose from. ([Michelin 2018](#ref-michelin2018))

- [viaf-analysis](https://github.com/notconfusing/viaf-analysis) R -
  takes result file from parser and make json input to R ([Klein
  2013](#ref-klein2013viaf))

- [wikidataSex](https://github.com/notconfusing/wikidataSex) Java,
  Python - for analysing, adding and sourcing sex claims on wikidata
  through VIAF and LCCN ([Klein 2014](#ref-klein2013wikidataSex))

- [viaf-jskos](https://github.com/gbv/viaf-jskos) PHP - JSKOS wrapper to
  Virtual International Authority File (VIAF) ([Voß
  2017](#ref-voss2017))

- [MATCHPOINT](https://github.com/hibernator11/matchpoint) JavaScript -
  Link author names to VIAF repository ([Candela
  2016](#ref-candela2016))

- [viafsbn](https://github.com/CristianCantoro/viafsbn) Python - Un
  semplice strumento per cercare da linea di comando codici VIAF (OCLC)
  e SBN (ICCU) ([Consonni 2013b](#ref-consonni2013viafsbn))

- [viaf-sbn_reconciler](https://github.com/CristianCantoro/viaf-sbn_reconciler)
  Python - Reconcile authority control files from VIAF (maintained by
  OCLC) and Italian SBN (maintained by ICCU) ([Consonni
  2013a](#ref-consonni2013viaf))

- [viaf-entity-lookup](https://github.com/cwrc/viaf-entity-lookup)
  JavaScript - Find entities (people, places, organizations) in VIAF.
  ([Frizzera 2021](#ref-frizzera2021))

- [viaf-link-quick-statements](https://github.com/kenirwin/viaf-link-quick-statements)
  PHP, JavaScript - convert VIAF authority links into importable
  Wikidata QuickStatements ([Irwin 2020](#ref-irwin2020))

- [ld4l_services](https://github.com/eichmann/ld4l_services) Java - A
  web app providing name lookup and triple extraction from a number of
  cached sources, including DBpedia, FAST, GeoNames, GRID, and VIAF
  ([Eichmann 2023](#ref-eichmann2023))

- [wiki_utils](https://github.com/angelzazo/wiki_utils) Python -
  Functions to retrieve data from VIAF, BNE, etc. and Wikimedia projects
  ([Zazo 2024](#ref-zazo2024))

## Contributing

Please report issues, feature requests, and questions to the [GitHub
issue tracker](https://github.com/kijinosu/rviaf/issues). [Contributor
Code of
Conduct](https://github.com/kijinosu/rviaf/blob/master/CODE_OF_CONDUCT.md).
By participating in rviaf you agree to abide by its terms.

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-candela2016" class="csl-entry">

Candela, Gustavo. 2016. “MATCHPOINT.” *GitHub Repository*.
<https://github.com/hibernator11/matchpoint>; GitHub.

</div>

<div id="ref-consonni2013viaf" class="csl-entry">

Consonni, Cristian. 2013a. “Viaf-Sbn_reconciler.” *GitHub Repository*.
<https://github.com/CristianCantoro/viaf-sbn_reconciler>; GitHub.

</div>

<div id="ref-consonni2013viafsbn" class="csl-entry">

———. 2013b. “Viafsbn.” *GitHub Repository*.
<https://github.com/CristianCantoro/viafsbn>; GitHub.

</div>

<div id="ref-eichmann2023" class="csl-entry">

Eichmann, Dave. 2023. “Ld4l_services.” *GitHub Repository*.
<https://github.com/eichmann/ld4l_services>; GitHub.

</div>

<div id="ref-frizzera2021" class="csl-entry">

Frizzera, Luciano. 2021. “Viaf-Entity-Lookup.” *GitHub Repository*.
<https://github.com/cwrc/viaf-entity-lookup>; GitHub.

</div>

<div id="ref-hajra2020content" class="csl-entry">

Hajra, Arben. 2020. “Content Enrichment of Digital Libraries: Methods,
Technologies and Implementations.” PhD thesis, Christian-Albrecht
University of Kiel.
<https://macau.uni-kiel.de/servlets/MCRFileNodeServlet/macau_derivate_00002293/dissertation_arben_hajra.pdf>.

</div>

<div id="ref-irwin2020" class="csl-entry">

Irwin, Ken. 2020. “Viaf-Link-Quick-Statements.” *GitHub Repository*.
<https://github.com/kenirwin/viaf-link-quick-statements>; GitHub.

</div>

<div id="ref-najko2015" class="csl-entry">

Jahn, Najko. 2015. “R Client for VIAF API.” *GitHub Repository*.
<https://github.com/njahn82/viaf>; GitHub.

</div>

<div id="ref-janowiecki2023vocab" class="csl-entry">

Janowiecki, Michelle. 2023. “Vocab-Apis.” *GitHub Repository*.
<https://github.com/jhu-library-applications/vocab-apis>; GitHub.

</div>

<div id="ref-klein2013viaf" class="csl-entry">

Klein, Max. 2013. “Viaf-Analysis.” *GitHub Repository*.
<https://github.com/notconfusing/viaf-analysis>; GitHub.

</div>

<div id="ref-klein2013wikidataSex" class="csl-entry">

———. 2014. “wikidataSex.” *GitHub Repository*.
<https://github.com/notconfusing/wikidataSex>; GitHub.

</div>

<div id="ref-michelin2018" class="csl-entry">

Michelin, Gautier. 2018. “VIAF NPM.” *GitHub Repository*.
<https://github.com/ideesculture/ca_viaf>; GitHub.

</div>

<div id="ref-phetteplace2014" class="csl-entry">

Phetteplace, Eric. 2014. “VIAF NPM.” *GitHub Repository*.
<https://github.com/phette23/viaf-npm>; GitHub.

</div>

<div id="ref-schneider2024viafr" class="csl-entry">

Schneider, Stefanie. 2024. “Viafr.” *GitHub Repository*.
<https://github.com/stefanieschneider/viafr>; GitHub.

</div>

<div id="ref-voss2017" class="csl-entry">

Voß, Jakob. 2017. “Viaf-Jskos.” *GitHub Repository*.
<https://github.com/gbv/viaf-jskos>; GitHub.

</div>

<div id="ref-zazo2024" class="csl-entry">

Zazo, Angel. 2024. “Wiki_utils.” *GitHub Repository*.
<https://github.com/angelzazo/wiki_utils>; GitHub.

</div>

</div>
