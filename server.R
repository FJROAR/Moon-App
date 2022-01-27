
server <- function(input, output) {

  output$image1 <- renderImage({
    
    moon <- image_read("data/moon_img.png")
    
    #Proyección ortográfica
    ortograph_projection <- function(long, lat){
      
      long_rad = long * 3.14159 / 180.0
      lat_rad = lat * 3.14159 / 180.0
      
      coords = c((201) * cos(lat_rad) * sin(long_rad) + (247+252)/2, 
                 -(201) * sin(lat_rad)  + (216+221)/2)
      
      return(coords)  
    }
      
    
    
    
    #Se genera la imagen lunar en png
      
    localizador_lunar <- function(long, lat){
        
        #Se obtienen las coordenadas del punto a representar
        punto <- ortograph_projection(long, lat)
        
        #Se generan las coordenadas del cuadrado centrado en este punto
        
        cuadrado <- c(punto[1]-2.5, punto[2]-2.5,
                      punto[1]+2.5, punto[2]+2.5)
        
        moon2 <- image_scale(moon, "500")
        
        img <- image_draw(moon2)
        rect(cuadrado[1],
             cuadrado[2],
             cuadrado[3],
             cuadrado[4],
             border = "red", 
             lwd = 2)
        dev.off()
        image_write(img, 
                    'data/moon_mod.png',
                    format = 'png')
    }
     
    #Se generan las coordenadas
    
    accidente <- df_visible %>%
      filter(ch_name == input$obj1)
    
    longitud = accidente$num_long
    latitud = accidente$num_lat
    
    localiza <- localizador_lunar(longitud, latitud)
       
    # Return a list
    list(src = 'data/moon_mod.png', 
         contentType = "image/png")
    
  }, 
  deleteFile = FALSE)
  
  output$tb1 <- renderDT({
    
    accidente <- df_visible %>%
      filter(ch_name == input$obj1)
    
    char <- c("Tipo de accidente",
              "Descripción",
              "Longitud",
              "Latitud")
    value <- c(accidente$ch_type,
               accidente$ch_data,
               accidente$num_long,
               accidente$num_lat)
    
    df <- data.frame(char = char,
                     value = value)
    
    datatable(df,
              colnames = c("Datos del objeto lunar", "Valores"),
              options = list(
                pageLength = 5,
                dom = 't',
                initComplete = JS(
                  "function(settings, json) {",
                  "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                  "}")),
              rownames = FALSE)
    
  })
  
  
}