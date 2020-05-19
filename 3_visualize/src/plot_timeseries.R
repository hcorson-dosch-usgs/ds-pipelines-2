plot_nwis_timeseries <- function(filepath, formatted_data_file, width = 12, height = 7, units = 'in'){
  formatted_data <- read_csv(formatted_data_file)  
  ggplot(data = formatted_data, aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  ggsave(filepath, width = width, height = height, units = units)
}