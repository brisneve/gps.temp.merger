# GPS Data and Temperature Data Merger

merge_gps_temp_1 <- function(path_gps, path_temp, output_path = NULL){

  if(!require(tidyverse)){
    install.packages("tidyverse")
    library(tidyverse)
  }

  temp.data <- read_csv(path_temp, skip = 1)
  colnames(temp.data)[2:3] <- c("date","temp")

  temp <- temp.data %>%
    mutate(date = mdy_hms(date)) %>%
    mutate(time = as.POSIXct(paste(hour(date), minute(date), sep=":"), format = "%H:%M")) %>%
    group_by(time) %>%
    summarize(temp = median(temp))

  gps <- read_csv(path_gps) %>%
    mutate(time = as.POSIXct(paste(hour(`date time`) + 8, minute(`date time`), sep=":"), format = "%H:%M")) %>%
    group_by(time) %>%
    summarize(lat=median(latitude), lon = median(longitude)) %>%
    select(time,lat,lon)

  df <- merge(temp,gps, by="time") %>%
    group_by(lon,lat) %>%
    summarize(temp=mean(temp))

  if(!is.null(output_path)){
    write_csv(df,output_path)
  }

  df

}

merge_gps_temp_2 <- function(path_gps,path_temp,output_path = NULL){
  # import temperature data
  temp.data <- read_csv(path_temp, skip = 1)
  colnames(temp.data)[2:3] <- c("date", "temp")
  temp <- temp.data %>% mutate(date = mdy_hms(date)) %>%
    mutate(time = as.POSIXct(paste(hour(date),minute(date), sep = ":"), format = "%H:%M")) %>%
    group_by(time) %>%
    summarize(temp = median(temp))

  # import gps data
  gps <- read_csv(path_gps) %>%
    select(date = contains("date"), latitude,longitude) %>%
    separate(date,sep=" ", c("date","time")) %>%
    mutate(date = as.Date.character(date),
           time = as.POSIXct(time,format = "%H:%M")) %>%
    group_by(time) %>%
    summarize(lat = median(latitude), lon = median(longitude)) %>%
    select(time, lat, lon)

  # merge data
  df <- merge(temp, gps, by = "time") %>%
    group_by(lon, lat) %>%
    summarize(temp = mean(temp))

  # save merge data
  if (!is.null(output_path)) {
    write_csv(df, output_path)
  }
  df
}

