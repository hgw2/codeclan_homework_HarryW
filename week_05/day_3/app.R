library(shiny)
library(tidyverse)
library(shinythemes)

olympics_medals <- read_csv("data/olympics_overall_medals.csv")


ui <- fluidPage(
  titlePanel("Five Country Medal Comparison"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "season",
        label = "Summer or winter olympics?",
        choices = c("Summer", "Winter")
      ), 
      radioButtons(
        inputId = "medals",
        label = "Select medal?",
        choices = c("Gold", "Silver", "Bronze")
        )
      ),
    mainPanel(
      plotOutput(outputId = "medal_plot")
      )
    )
  )
    
server <- function(input, output){
  
  output$medal_plot <-renderPlot({ 
   
     colour <- case_when(
      input$medals == "Gold" ~ "#C9B037",
      input$medals  == "Silver" ~ "#B4B4B4",
      input$medals  == "Bronze" ~ "#AD8A56")
    
  olympics_medals %>%
    filter(team %in% c("United States",
                       "Soviet Union",
                       "Germany",
                       "Italy",
                       "Great Britain")) %>%
    filter(medal == input$medals) %>%
    filter(season == input$season) %>%
    ggplot() +
    aes(x = team, y = count) +
    geom_col(fill = colour) 
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
