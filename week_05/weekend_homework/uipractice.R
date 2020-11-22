library(here)
source(here("code.R"))

ui <- fluidPage(
  dashboardPage(
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "overall",
          fluidRow(
            box(
              title = "Trophy Winners",
              width = 12, status = "primary",
              column(
                12,
                sliderInput("year",
                            
                            "Select year",
                            value = 2019,
                            max = 2019, min = 2000,
                            sep = "")
              )
            ),
            box(title ="Trophies Won",
                width = 12,
                plotOutput("trophy")
            )
            
          )
        ),
        tabItem(
          tabName = "top_5",
          fluidPage(
            fluidRow(
              box(
                width = 12, status = "primary",
                fluidRow(
                  column(
                    4, =
                    "sdfads"
                  ),
                  
                  column(
                    4,
                    "sdfasdf"
                  ),
                  column(
                    4,
                    "sdfgsdfg"
                  )
                )
              )
            ),
            fluidRow(
              box(
                title = "Top 5 TryScorers",
                width = 6,
                plotOutput("tries")
              ),
              box(
                title = "Top 5 Points Scorers",
                width = 6,
                plotOutput("points")
              )
            ),
            fluidRow(
              box(
                title = "Top 5 Points Scorers",
                width = 6,
                plotOutput("points")
              ),
              box(
                title = "Top 5 Points Scorers",
                width = 6,
                plotOutput("points")
              )
            )
          )
        )
      )
    )
  )
)

