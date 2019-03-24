
[![Travis-CI Build
Status](https://travis-ci.org/hrbrmstr/ipasnhistory.svg?branch=master)](https://travis-ci.org/hrbrmstr/ipasnhistory)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/ipasnhistory/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/ipasnhistory)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/ipasnhistory)](https://cran.r-project.org/package=ipasnhistory)

# ipasnhistory

Retrieve Announcement History for IP Addresses

## Description

IP ASN History is an open source project
(<https://github.com/D4-project/IPASN-History>) to figure out the ASN
announcing an IP and the closest prefix announcing it at a specific
date. Methods are provided to query CIRCL-LU’s API endpoint and/or a
local API endpoint.

## What’s Inside The Tin

The following functions are implemented:

  - `ip_asn_db_meta`: Returns meta informations about the information
    currently stored in the database at the specified endpoint
  - `ip_history`: Retrieve IP ASN advertisement history
  - `mass_cache`: Populate the API cache
  - `mass_query`: Mass query IP ASN history info
  - `timedelta`: Construct a time delta value for ‘ip\_history()’

## Installation

``` r
install.packages("ipasnhistory", repos="https://cinc.rud.is/")
# or 
remotes::install_git("https://sr.ht.com/~hrbrmstr/ipasnhistory.git")
# or
remotes::install_gitlab("hrbrmstr/ipasnhistory")
# or (if you must)
remotes::install_github("hrbrmstr/ipasnhistory")
```

## Usage

``` r
library(ipasnhistory)

# current version
packageVersion("ipasnhistory")
## [1] '0.1.0'
```

``` r
str( ip_asn_db_meta(), 2 )
## List of 3
##  $ cached_dates     :List of 2
##   ..$ caida     :List of 2
##   ..$ ripe_rrc00:List of 2
##  $ expected_interval:List of 2
##   ..$ first: chr "2018-11-24"
##   ..$ last : chr "2019-03-24"
##  $ sources          : chr [1:2] "ripe_rrc00" "caida"

str( ip_history("146.185.222.49"), 3 )
## List of 2
##  $ meta    :List of 3
##   ..$ address_family: chr "v4"
##   ..$ ip            : chr "146.185.222.49"
##   ..$ source        : chr "caida"
##  $ response:List of 1
##   ..$ 2019-03-22T12:00:00:List of 2
##   .. ..$ asn   : chr "44050"
##   .. ..$ prefix: chr "146.185.222.0/24"

str( ip_history("146.185.222.49", first="2018-11-01", last="2018-11-25"), 3 )
## List of 2
##  $ meta    :List of 3
##   ..$ address_family: chr "v4"
##   ..$ ip            : chr "146.185.222.49"
##   ..$ source        : chr "caida"
##  $ response:List of 1
##   ..$ 2018-11-24T12:00:00:List of 2
##   .. ..$ asn   : chr "44050"
##   .. ..$ prefix: chr "146.185.222.0/24"
```

## ipasnhistory Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines | (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | --: | -------: | ---: |
| R    |       10 | 0.91 | 199 | 0.94 |          50 | 0.7 |      178 | 0.81 |
| Rmd  |        1 | 0.09 |  12 | 0.06 |          21 | 0.3 |       41 | 0.19 |

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
