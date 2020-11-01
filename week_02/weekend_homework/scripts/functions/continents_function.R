continents1 <- function(longitude, latitude){
  if(longitude > 180 |
        longitude < -180 | 
        latitude > 90 | 
        latitude < -90){
    stop("Input out of bounds")
  }
  
   if(longitude >= -19.335938 &
     longitude <= 60.734375 & 
     latitude >= 1.933227 & 
     latitude <= 35.029996) {
     return("Africa")
   } else if (longitude >= 3.691406 &
     longitude <= 51.328125 &
     latitude >= -35.889050 & 
     latitude <= 3.074695){
     return("Africa")
   } else if (longitude >= -21.972656 & 
     longitude <= 55.546875 & 
     latitude >= 33.57419 & 
     latitude <= 69.037142){
     return("Europe")
   } else if (longitude >= 55.546875 & 
     longitude <= 180 & 
     latitude >= 6.315299 & 
     latitude <= 73.022592){
     return("Asia")
   } else if (longitude >= -165.937500 & 
     longitude <=-53.085938 & 
     latitude >= 13.923404 & 
     latitude <= 69.287257){
     return("North America")
   } else if (longitude >= -82.617188 & 
    longitude <= - 34.804688 & 
    latitude >= -55.677584 & 
    latitude <= 12.554564) {
     return("South America")
    } else if (longitude >= 108.632813 & 
    longitude <=180 & 
    latitude >= -48.458352 & 
    latitude <= 2.635789) {
      return("Oceania") 
    } else if (longitude >= -180 & 
    longitude <=180 & 
    latitude >= -90 & 
    latitude <= -69.037142) {
      return("Antartica") 
    } else {
       return("Ocean") 
    }
}
  
        