library(shinydashboard)
library(MASS)

ui <- dashboardPage(
  dashboardHeader(title = "Mouse Interactive"),
  dashboardSidebar(collapsed = TRUE),
  dashboardBody(h3("Mouse actions: brushing in data points"),
                fluidRow(plotOutput("CerealPlot",
                                    brush = "brushing"),
                         print(h4(" Detail data in UScereal data frame")),
                         box((verbatimTextOutput("coords")), width = 12)
                )
  )
)

server <- function(input, output) {
  output$CerealPlot <- renderPlot({
    plot(x = UScereal$protein, y = UScereal$calories, 
         xlab = "Protein (gm)",
         ylab = "Calories",
         pch = as.character(UScereal$mfr))
  })
  output$coords <- renderPrint({
    brushedPoints(UScereal, input$brushing,
                  xvar = "protein", yvar = "calories")
  })
}

shinyApp(ui = ui, server = server)
