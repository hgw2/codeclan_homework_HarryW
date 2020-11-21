server <- function(input, output){
  
  output$trophy <- renderPlot({
    trophies %>% 
      filter(year == 2011) %>% 
      drop_na() %>% 
      ggplot()+
      aes(x = trophy, fill = country)+
      geom_bar(colour = "black") +
      coord_flip() +
      labs(x = "Trophy", fill = "Nation")+
      scale_fill_manual(values = country_colours)+
      theme(axis.line=element_blank(),axis.text.x=element_blank(),
            axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            panel.background=element_blank(),
            panel.border=element_blank(),
            panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            plot.background=element_blank())
  })
  
  output$tries <- renderPlot({
    players %>% 
      distinct(country, club, player, forward_or_back) %>% 
      filter(country %in%  "France") %>% 
      group_by(club) %>% 
      summarise(total_number = n()) %>% 
      slice_max(total_number, n = 5, with_ties = FALSE) %>% 
      ggplot() + 
      aes(x= reorder(club, -total_number), y= total_number, fill = club)+
      geom_col() + 
      scale_fill_manual(values = club_colours, guide = FALSE)+
      labs(x = "Club", y ="Number of PLayers") +
      geom_text(aes(label= total_number),  vjust=-0.3) + theme(axis.line=element_blank(),axis.text.y=element_blank(),
                                                               axis.ticks=element_blank(),
                                                               axis.title.y=element_blank(),
                                                               panel.background=element_blank(),
                                                               panel.border=element_blank(),
                                                               panel.grid.major=element_blank(),
                                                               panel.grid.minor=element_blank(),
                                                               plot.background=element_blank())
    
  })
}

