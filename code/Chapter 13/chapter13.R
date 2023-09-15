# Chapter 13

## getData
library(raster)
th <- getData("GADM", country="Thailand", level=1)

library(ggplot2)
ggplot() +
  geom_polygon(data=th, aes(x=long, y=lat, group=group, fill=id), 
               show.legend=FALSE)

th_bw <- ggplot(th, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
th_bw

th_bw + coord_map()

th_bw + coord_map(orientation = c(-36, 175, 0))
th_bw + coord_map("conic", lat0 = 50)

## map_data
c5 <- c("BRA","RUS","IND","CHN","ZAF")
brics <- map_data("world", region = c5)
head(brics)

ggplot(brics, aes(x=long, y=lat, group=group, fill=factor(group))) +
  geom_polygon(col="white") +
  theme(legend.position="none") + 
  coord_map()


## spData package
library(spData) 
library(sf) 
world <- st_read(system.file("shapes/world.gpkg", package="spData"))
summary(world)

plot(world, max.plot = 10)

summary(world["gdpPercap"])

world_asia <- world[world$continent == "Asia", ]
th = world[world$name_long == "Thailand", ]
plot(st_geometry(th), expandBB = c(0, 0.2, 0.1, 1), col = "blue", lwd = 1)
plot(world_asia[0], add = TRUE)


## tmap package
library(tmap)	# for static and interactive maps
data(World)
tm_shape(World) +
  tm_borders()


tm_shape(World) +
  tm_polygons("HPI") +
  tm_compass(show.labels = 2)


World$pollution <- ifelse(World$iso_a3 %in% c("BGD","PAK","MNG","AFG","IND"),
                          "red","grey")
tm_shape(World, projection=4000, ylim=c(.1, 1.1), relative = TRUE) + 
  tm_polygons("pollution") + 
  tm_layout("Countries with the most pollution 
               :World Population Review, 2022",
            inner.margins=c(0,0,.05,0), title.size=.8,
            legend.show = TRUE)


tmap_mode("view")
tm_shape(World) +
  tm_polygons("HPI") 

## Shapes และ Layers
data(World, land)
tmap_mode("plot")

tm_shape(land) +
  tm_raster("elevation", palette = terrain.colors(10)) +
  tm_shape(World) +
  tm_borders("white", lwd = .5) +
  tm_text("iso_a3", size = "AREA") +
  tm_legend(show = FALSE)

## Facets
### 1)
ttm() 
tm_shape(World) +
  tm_polygons(c("continent", "economy")) +
  tm_facets(sync = TRUE, ncol = 2)

### 2)
tmap_mode("plot")
tm_shape(World) +
  tm_polygons("income_grp") +
  tm_facets(by = "continent")

### 3)
tm1 <- tm_shape(World) + tm_polygons("income_grp", convert2density = TRUE)
tm2 <- tm_shape(World) + tm_bubbles(size = "pop_est_dens") 
tmap_arrange(tm1, tm2)

## Basemaps และ overlay tile maps
tmap_mode("view")
tm_basemap("Esri.WorldTopoMap") +
  tm_shape(World) +
  tm_bubbles(size = "inequality", col="brown") +
  tm_tiles("Stamen.TonerLabels")

## Exporting maps
tm <- tm_shape(World) +
  tm_polygons("HPI", legend.title = "Happy Planet Index")

### save an image ("plot" mode)
tmap_save(tm, filename = "world_map.png")

### save as stand-alone HTML file ("view" mode)
tmap_save(tm, filename = "world_map.html")



