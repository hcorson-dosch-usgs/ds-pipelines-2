process_data <- function(output_path, nwis_data_file, site_info){
  nwis_data <- read_csv(nwis_data_file)
  # process data
  nwis_data_clean <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, tz_cd)
  
  # annotate data
  annotate_data(output_path, nwis_data_clean, site_info)
}

annotate_data <- function(output_path, site_data_clean, site_info){
  annotated_data <- left_join(site_data_clean, site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va)
  
  # style data
  style_data(output_path, annotated_data)
}

style_data <- function(output_path, site_data_annotated){
  mutate(site_data_annotated, station_name = as.factor(station_name))
  
  # create output directory
  project_output_dir <- '2_process/out'
  dir.create(project_output_dir)
  
  # write data
  write_csv(site_data_annotated, path = output_path)
}