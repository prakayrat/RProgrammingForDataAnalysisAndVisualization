library(shinydashboard)
library(datasets)

ui <- dashboardPage(
  dashboardHeader(title = "Brushing: Air quality data"),
  dashboardSidebar(collapsed = TRUE),
  dashboardBody(h3("Ozone vs. Temperature"),
                fluidRow(plotOutput("airqualityPlot",
                                    brush = "brushing"),
                         print(h3("Detail of row in airquality data frame")),
                         box((verbatimTextOutput("coords")), width = 12)
                )
  )
)

server <- function(input, output) {
  output$airqualityPlot <- renderPlot({
    plot(x = airquality$Ozone, y = airquality$Temp, 
         xlab = "Ozone (ppb)",
         ylab = "Temperature (F)")
  })
  output$coords <- renderPrint({
    brushedPoints(airquality, input$brushing,
                  xvar = "Ozone", yvar = "Temp")
  })
}

shinyApp(ui = ui, server = server)
