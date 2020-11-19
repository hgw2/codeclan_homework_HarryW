library(shiny)
library(tidyverse)
library(shinythemes)

olympics_medals <- read_csv("data/olympics_overall_medals.csv")


ui <- fluidPage(
  theme = "practice.css",
  titlePanel(tags$h1("Top Five Country Medal Comparison")),
  tabsetPanel(
    tabPanel(
      "Top 5",
      fluidRow(
        column(
          12,
          plotOutput(outputId = "medal_plot")
        )
      ),
      fluidRow(
        column(
          5,
          ""
        ),
        column(
          4,
          radioButtons(
            inputId = "season",
            label = "Summer or Winter Olympics?",
            choices = c("Summer", "Winter")
          ),
          column(
            3,
            ""
          )
        )
      )
    ),
    tabPanel(
      "UK medals",
      sidebarPanel(
        radioButtons(
          inputId = "medals",
          label = "Select medal?",
          choices = c("Gold", "Silver", "Bronze")
        )
      )
    )
  )
)

server <- function(input, output) {
  output$medal_plot <- renderPlot({
    colour <- case_when(
      input$medals == "Gold" ~ "#C9B037",
      input$medals == "Silver" ~ "#B4B4B4",
      input$medals == "Bronze" ~ "#AD8A56"
    )

    olympics_medals %>%
      filter(team %in% c(
        "United States",
        "Soviet Union",
        "Germany",
        "Italy",
        "Great Britain"
      )) %>%
      filter(medal == input$medals) %>%
      filter(season == input$season) %>%
      ggplot() +
      aes(x = team, y = count) +
      geom_col(fill = colour) +
      theme(plot.background = element_rect(fill = "#00ffb9"),
            panel.background = element_rect(fill = "#00ffb9"))
      
  })
}

# Run the application
shinyApp(ui = ui, server = server)
