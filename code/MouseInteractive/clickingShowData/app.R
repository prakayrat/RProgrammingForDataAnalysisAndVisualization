library(shinydashboard)
library(MASS)

ui <- dashboardPage(
  dashboardHeader(title = "Mouse Interactive"),
  dashboardSidebar(collapsed = TRUE),
  dashboardBody(h3("Mouse actions: clicking in data points"),
                fluidRow(plotOutput("CerealPlot",
                                    click = "single_click"),
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
    nearPoints(UScereal, input$single_click,
               xvar = "protein", yvar = "calories",
               threshold = 20)
  })
}

shinyApp(ui = ui, server = server)
