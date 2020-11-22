server <- function(input, output) {
  output$trophy <- renderPlot({
    trophies %>%
      filter(year == input$year) %>%
      drop_na() %>%
      ggplot() +
      aes(x = trophy, fill = country) +
      geom_bar(colour = "black") +
      coord_flip() +
      labs(x = "Trophy", fill = "Nation") +
      scale_fill_manual(values = country_colours) +
      theme(
        axis.line = element_blank(), axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })
  
  filtered_data <- reactive({
    filtered_data <- players %>%
      filter(country %in% input$country ) %>% 
      filter(forward_or_back %in% input$position ) %>% 
      filter(club %in% input$club ) %>% 
      mutate(count = na_if(count, 0)) %>% 
      drop_na()
    
  })

  output$club <- renderPlot({
    filtered_data() %>%
      distinct(country, club, player, forward_or_back) %>%
      group_by(club) %>%
      summarise(total_number = n()) %>%
      ggplot() +
      aes(x = reorder(club, -total_number), y = total_number, fill = club) +
      geom_col(colour = "black") +
      scale_fill_manual(values = club_colours, guide = FALSE) +
      labs(x = "Club", y = "Number of PLayers") +
      geom_text(aes(label = total_number), vjust = -0.3) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })


  
  output$tries <- renderPlot({
   filtered_data() %>% 
      filter(stat == "x2019_tries") %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      geom_text(aes(label = count), vjust = -0.3) +
      labs(x = "Player", y = "Tries")+
      scale_fill_manual(values = country_colours, guide = FALSE) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })


  output$points <- renderPlot({
    filtered_data() %>%
      filter(stat == "x2019_points") %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      scale_fill_manual(values = country_colours, guide = FALSE) +
      labs(x = "Player", y = "Number of Points")+
      geom_text(aes(label = count), vjust = -0.3) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })

  output$assists <- renderPlot({
    filtered_data() %>%
      filter(stat == "x2019_try_assists") %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      scale_fill_manual(values = country_colours, guide = FALSE) +
      labs(x = "Player", y = "Try Assists")+
      geom_text(aes(label = count), vjust = -0.3) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })
  output$carries <- renderPlot({
    filtered_data() %>% 
      filter(stat == "x2019_carries") %>%
      slice_max(count, n = 5, with_ties = FALSE) %>%
      ggplot() +
      aes(x = reorder(player, -count), y = count, fill = country) +
      geom_col(colour = "black") +
      geom_text(aes(label = count), vjust = -0.3) +
      labs(x = "Player", y = "Tries")+
      scale_fill_manual(values = country_colours, guide = FALSE) +
      theme(
        axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank()
      )
  })
  
player_filter <- reactive({
  player_info %>% 
    filter(country == input$select_country) 
})
  
output$player_info <- renderTable({
player_filter() %>% 
    select(player:weight_in_kg) %>% 
    rename(position = position_detailed) %>%
    rename("height_(m)" = height_in_metres) %>% 
    rename("weight_(Kg)"= weight_in_kg) %>% 
    rename_all(funs(str_replace_all(., "_", " "))) %>% 
    rename_all(funs(str_to_title(.))) 
   })


output$club <- renderPlot({
player_filter( ) %>% 
    group_by(club) %>%
    summarise(total_number = n()) %>%
    ggplot() +
    aes(x = reorder(club, total_number), y = total_number, fill = club) +
    geom_col(colour = "black") +
    scale_fill_manual(values = club_colours, guide = FALSE) +
    labs(x = "Club", y = "Number of PLayers") +
    geom_text(aes(label = total_number), vjust = 0.3, hjust = -1) +
    coord_flip() +
    theme(
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks = element_blank(),
      axis.title.y = element_blank(),
      axis.title.x = element_blank(),
      panel.background = element_blank(),
      panel.border = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.background = element_blank())
})


}
