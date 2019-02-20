# Kaplan-Meier curves in Shiny
# Function to run shiny R file using ggsurvplot


shinyServer(function(input, output, session) {
  
  selectedData <- reactive({
    baz5[, c(input$sur_var)]
  })
  
  output$caption <- renderText({
    paste("Diagnostic Change graphic of", input$sur_var, sep="\n")
  })
  
  runSur <- reactive({
    survfit(as.formula(paste("Surv(timepoint,chgt) ~ ",paste(input$sur_var))),data=baz5)
    
  })
  
  
  output$plot1 <- renderPlot({
    
    
    surv_plot <- ggsurvplot(runSur(), 
               data=baz5,
               ylab= "Endpoint",
               xlab= "Time (Days)",
               font.main = 18,
               font.x =  14,
               font.y = 14,
               font.tickslab = 10,
               palette = c("#638CAE", "#DF564B","#F5AF22"),
               pval = TRUE,
               risk.table = TRUE, risk.table.y.text.col = TRUE)
    print(surv_plot)
    
  })
  

  
})
