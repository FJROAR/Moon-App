shinyUI(fluidPage(

  theme = "bootstrap",
  skin = "black",
  title = "Localizador lunar",

  dashboardHeader(title = span("Localizador Lunar", 
                                    style = "color: red; font-size: 32px")),
  
  
  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet", 
        type = "text/css", 
        href = "bootstrap.css")
    ),
    
  fluidRow(
    column(4, wellPanel(selectizeInput("obj1", 
                                    "Selecciona/Busque un accidente geográfico: ",
                                    choices = df_visible$ch_name)
    )),
    column(6, DTOutput("tb1"))
    

  ), #end fluidRow
  fluidRow(column(4, imageOutput("image1")
    )
    ) #end fluidRow
  )#end body
)
)