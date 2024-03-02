# GPS and Temperature Merger

## Introduction

The package has functions to merge GPS data obtained from GPS Tracker mobile app and temperature data obtained from HOBO Logger.

## Installation

To install and load this package, you can use the following codes:

``` r
devtools:: install_github("brisneve/gps.temp.merger")
library(gps.temp.merger)
```

## Functions

**Merge GPS tracker data and temperature logger data**

``` r
merge_gps_temp(path_temp, path_gps, output_path = NULL)
```

**Map out the merged GPS tracker data and temperature logger data**

``` r
map_gps_temp(df)
```

## Arguments

| Arguments   | Definition                                                                           |
|---------------|---------------------------------------------------------|
| path_temp   | a path of the .csv file containing the temperature data obtained from HOBO logger    |
| path_gps    | a path of the .txt file containing the GPS data obtained from mobile app GPS tracker |
| output_path | a path to save merge dataset as .csv                                                 |
| df          | data frame generated from `merge_gps_temp()` function                                |

## Citation

Brisneve Edullantes (2024). GPS and Temperature Merger. R package version 0.1.0.
