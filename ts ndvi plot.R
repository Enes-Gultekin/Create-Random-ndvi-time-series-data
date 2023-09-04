library(raster)
library(dplyr)
library(ggplot2)
#import points
coor = read.csv("points.csv")
coor = data.frame(coor)

#create random ndvi values
ndvi= runif(1000,min=0,max=1)

#create time interval
time_index=seq(from=as.Date("1995-11-11"),to=as.Date("2023-11-11"),by="6 months")





#import coordinates
coor = read.csv("points.csv")
coor = as.data.frame(coor)
#create random ndvi values
ndvi = runif(850,min=0,max=0.7 )
ndvi =as.data.frame(ndvi)


ndvi_s = data.frame(time_index,ndvi)
image(ndvi)http://127.0.0.1:38637/graphics/plot_zoom_png?width=825&height=771
df <- coor %>% select(-OID)
ts_df =data.frame(df,ndvi_s)


ext=extent(min(ts_df$x),min(ts_df$y),max(ts_df$x),max(ts_df$y))
rs=raster(ts_df,ext=ext)
wrr=raster(ext,resolution=1)
crs(wrr) =CRS("+proj=utm +zone=30 +datum=WGS84")
ras=rasterize(df,wrr,field=ndvi)
image(as.matrix(ras))
rass= as.data.frame(ras)
colnames(ts_df)<-c("x","y","Time_Index","ndvi_values")

plot(coor$x,coor$y)
plot(ras,xlab="longitude",ylab="latitude",main="NDVI values")
