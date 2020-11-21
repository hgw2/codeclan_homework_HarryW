library(here)
source(here("code.R"))

ui <- fluidPage(
  dashboardPage(
    dashboardHeader(title = "2019 Six Nations "),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Overall", tabName = "overall", icon = icon("trophy")),
        menuItem("Top 5", tabName = "top_5", icon = icon("football-ball"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName= "overall",
          fluidRow(
            box(width = 12,
              sliderInput("year",
                          "Select year",
                          value = 2019,
                          max = 2019, min = 2000,
                          sep = "")
            ),
            box(
            title ="Trophies Won",
                  width = 12,
                  plotOutput("trophy")
            )
          )
        )
      )
    )
  )
)