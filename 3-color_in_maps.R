library(RColorBrewer)
# 9 steps on the RColorBrewer "BuPu" palette: blups
blups <- brewer.pal(9, "BuPu")

# Add scale_fill_gradientn() with the blups palette
ggplot(preds) +
  geom_tile(aes(lon, lat, fill = predicted_price), alpha = 0.8)  +
  scale_fill_gradientn(colors = blups)


library(viridisLite)
# viridisLite viridis palette with 9 steps: vir
vir <- viridis(9)

# Add scale_fill_gradientn() with the vir palette
ggplot(preds) +
  geom_tile(aes(lon, lat, fill = predicted_price), alpha = 0.8)  +
  scale_fill_gradientn(colors = vir)

# mag: a viridisLite magma palette with 9 steps
mag <- magma(9)

# Add scale_fill_gradientn() with the mag palette
ggplot(preds) +
  geom_tile(aes(lon, lat, fill = predicted_price), alpha = 0.8) +
  scale_fill_gradientn(colors = mag)


# Generate palettes from last time
library(RColorBrewer)
blups <- brewer.pal(9, "BuPu")

library(viridisLite)
vir <- viridis(9)
mag <- magma(9)

# Use the blups palette
tm_shape(prop_by_age) +
  tm_raster("age_18_24", palette = blups) +
  tm_legend(position = c("right", "bottom"))

# Use the vir palette
tm_shape(prop_by_age) +
  tm_raster("age_18_24",
            palette = vir) +
  tm_legend(position = c("right", "bottom"))

# Use the mag palette but reverse the order
tm_shape(prop_by_age) +
  tm_raster("age_18_24",
            palette = rev(mag)) +
  tm_legend(position = c("right", "bottom"))

mag <- viridisLite::magma(7)

library(classInt)

# Create 5 "pretty" breaks with classIntervals()
classIntervals(values(prop_by_age[["age_18_24"]]), n = 5, style = "pretty")


# Create 5 "quantile" breaks with classIntervals()
classIntervals(values(prop_by_age[["age_18_24"]]), n = 5, style = "quantile")


# Use 5 "quantile" breaks in tm_raster()
tm_shape(prop_by_age) +
  tm_raster("age_18_24", palette = mag,
            n = 5, style = "quantile") +
  tm_legend(position = c("right", "bottom"))

# Create histogram of proportions
hist(values(prop_by_age)[, "age_18_24"])

# Use fixed breaks in tm_raster()
tm_shape(prop_by_age) +
  tm_raster("age_18_24", palette = mag,
            style = "fixed",
            breaks = c(0.025, 0.05, 0.1, 0.2, 0.25, 0.3, 1))

# Save your plot to "prop_18-24.html"
save_tmap(filename = "prop_18-24.html")

# Print migration
migration

# Diverging "RdGy" palette
red_gray <- brewer.pal(7, "RdGy")

# Use red_gray as the palette 
tm_shape(migration) +
  tm_raster(palette = red_gray) +
  tm_legend(outside = TRUE, outside.position = c("bottom"))

# Add fixed breaks 
tm_shape(migration) +
  tm_raster(breaks = c(-5e6, -5e3, -5e2, -5e1, 5e1, 5e2, 5e3, 5e6),
            palette = red_gray,
            style = "fixed") +
  tm_legend(outside = TRUE, outside.position = c("bottom"))

library(raster)

# Plot land_cover
tm_shape(land_cover) +
  tm_raster()


# Palette like the ggplot2 default
hcl_cols <- hcl(h = seq(15, 375, length = 9), 
                c = 100, l = 65)[-9]

# Use hcl_cols as the palette
tm_shape(land_cover) +
  tm_raster(palette = hcl_cols)


# Examine levels of land_cover
levels(land_cover)

# A set of intuitive colors
intuitive_cols <- c(
  "darkgreen",
  "darkolivegreen4",
  "goldenrod2",
  "seagreen",
  "wheat",
  "slategrey",
  "white",
  "lightskyblue1"
)

# Use intuitive_cols as palette
tm_shape(land_cover) +
  tm_raster(palette = intuitive_cols) +
  tm_legend(position = c("left", "bottom"))

