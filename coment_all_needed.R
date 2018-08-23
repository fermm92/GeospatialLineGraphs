library(tidyverse)
raster::raster("data-raw/glp00g30.asc") %>%
raster::rasterToPoints() %>%
as_data_frame() %>%
rename(z = glp00g30) %>%
mutate(z = ifelse(z < 5000, NA, z)) %>%
complete(x, y) %>%
mutate(z = y + z/0.5e6) %>%
ggplot() +
geom_path(data = map_data("world"), aes(long, lat, group = group), colour = "grey", alpha = 0.1) +
geom_polygon(data = map_data("world"), aes(long, lat, group = group), fill = "grey", alpha = 0.1) +
geom_line(aes(x, z, group = y), lwd = 0.1) +
coord_quickmap(ylim = c(-54.75, 69.75)) +
scale_x_continuous(NULL, NULL) +
scale_y_continuous(NULL, NULL)
