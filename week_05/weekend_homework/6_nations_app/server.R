server <- function(input,output){
  output$trophy <- renderPlot({
    trophies %>% 
      filter(year == input$year) %>% 
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
  
}