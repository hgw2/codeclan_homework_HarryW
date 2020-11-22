library(here)
source(here("6_nations_app/code.R"))

ui <- fluidPage(
  dashboardPage(
    dashboardHeader(title = "2019 Six Nations "),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Overall", tabName = "overall", icon = icon("trophy")),
        menuItem("Top 5", tabName = "top_5", icon = icon("football-ball")),
        menuItem("Teams", tabName = "teams", icon = icon("users"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName= "overall",
          fluidRow(
            box(width = 12, 
                status = "primary",
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
        ),
        tabItem(
          tabName = "top_5",
          fluidRow(
            box(
              width = 12,
              status = "primary",
              fluidRow (
                column(4, 
                       pickerInput("country",
                                   "Country", 
                                   choices=all_countries,
                                   selected = all_countries,
                                   options = list(`actions-box` = TRUE),
                                   multiple = T)
                       ),
                column(4,
                       pickerInput("position",
                                   "Forward or Back", 
                                   choices= all_positions,
                                   selected = all_positions,
                                   options = list(`actions-box` = TRUE),
                                   multiple = T)),
                column(4,pickerInput("club",
                                     "Club", 
                                     choices= all_clubs,
                                     selected = all_clubs,
                                     options = list(`actions-box` = TRUE),
                                     multiple = T) )
              )
            )
            
          ),
          fluidRow(
            box(title = "Top 5 Try Scorers",
                width = 6,
                plotOutput("tries")),
            box(title = "Top 5 Point Scorers",
                width = 6,
                plotOutput("points"))
          ),
          fluidRow(
            box(title = "Top 5 Try Assisters",
                width = 6,
                plotOutput("assists")),
            box(title = "Top 5 carries",
                width = 6,
                plotOutput("carries"))
            
          )
        ),
        tabItem(
          tabName = "teams",
          fluidRow(
            box(width =12,
                prettyRadioButtons("select_country",
                             "Select Country",
                             choices = all_countries,
                             inline = TRUE))
          ),
          fluidRow(
            column(6,
                   box(width = 12,
                       tableOutput("player_info"))
                   ), 
            column(6,
                   box(width = 12),
                   box(width = 12),
                   box(title = "Clubs",
                       width = 12,
                       plotOutput("club"))
                   
                   )
                   
            
          )
        )
      )
    )
  )
)