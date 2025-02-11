[![img](https://img.shields.io/badge/Lifecycle-Maturing-007EC6)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## bc-small-business

A shiny dashboard for the [BC Small Business Profile](https://bcstats.shinyapps.io/sb-profile). This dashboard was designed to replace the PDF format in which the BC Small Business Profile was previously published. PDF reports up to 2022 are available on the [Legislative Library website](https://llbc.ent.sirsidynix.net/client/en_GB/main/search/results?qu=small+business+profile&te=)

### Data

**BC Small Business Profile Data**

The data used in the dashboard is available in the [BC Data Catalogue](https://catalogue.data.gov.bc.ca/dataset/14828d0e-3cab-4477-af30-eab919d3451a), released under the [Open Government Licence - British Columbia](https://www2.gov.bc.ca/gov/content?id=A519A56BC2BF44E4A008B33FCF527F61). 

**British Columbia Census Economic Regions**

[Current Census Economic Regions](https://catalogue.data.gov.bc.ca/dataset/1aebc451-a41c-496f-8b18-6f414cde93b7) geospatial data, released under the [Statistics Canada Open Licence](https://www.statcan.gc.ca/eng/reference/licence), are sourced from the B.C. Data Catalogue using the [`bcdata`](https://bcgov.github.io/bcdata/) package.

### Requirements

To run the dashboard, the following actions are required:

**Packages**

Install these packages.

``` r
install.packages(bcdata)

install.packages("remotes")
remotes::install_github("bcgov/bcgovr")
remotes::install_github("bcgov/bcstatslinks")
remotes::install_github("bcgov/bcsapps")
```

[bcsapps](https://github.com/bcgov/bcsapps): used for standardizing the header and footer of BC Stats apps/dashboards

[bcstatslinks](https://github.com/bcgov/bcstatslinks): contains a list of BC Stats dashboards used by bcsapps::bcsHeaderUI and bcsapps::bcsHeaderServer

**Data**

Download the [BC Small Business Profile data](https://catalogue.data.gov.bc.ca/dataset/14828d0e-3cab-4477-af30-eab919d3451a/resource/1b1fa49f-d11a-405f-8cc8-57237aa57c96). Save the csv file, load it into R and save as app/data/new_data.rds.

Run R/get_geo_data.R to download and format the [Current Census Economic Regions](https://catalogue.data.gov.bc.ca/dataset/1aebc451-a41c-496f-8b18-6f414cde93b7).

**Code**

Change google_tracking to FALSE in [app/R/global.R](app/R/global.R)

**Notes**

The highlights presented in the app are not included in this github repo. Instead, a set of placeholder highlights are included in [app/R/faux_highlight_text.R](app/R/faux_highlight_text.R).

The downloadable data is also not included in this repo, so the download data buttons in the app will not work.

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an [issue](https://github.com/bcgov/sb-bc/issues/).

### How to Contribute

If you would like to contribute, please see our [CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

### License

    Copyright 2023 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an 
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.

------------------------------------------------------------------------

*This project was created using the [bcgovr](https://github.com/bcgov/bcgovr) package.*
