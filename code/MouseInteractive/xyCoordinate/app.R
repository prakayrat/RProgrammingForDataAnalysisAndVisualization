library(shinydashboard)
library(MASS)
ui <- dashboardPage(
  dashboardHeader(title = "Mouse Interactive"),
  dashboardSidebar(),
  dashboardBody(h3("Mouse actions: clicks, double clicks or brushes"),
                fluidRow(plotOutput("CerealPlot", 
                                    click = "single_click",
                                    dblclick = "double_click",
                                    hover = "hovering",
                                    brush = "brushing"),
                         print(h4(" show x y coordinates")),
                         box((verbatimTextOutput("coords")), width = 12))
  )
)

server <- function(input, output) {
  output$CerealPlot <- renderPlot({
    plot(x = UScereal$protein, y = UScereal$calories, 
         xlab = "Protein (gm)",
         ylab = "Calories",
         pch = as.character(UScereal$mfr))
  })
  output$coords <- renderText({
    xy_points <- function(datapoints) {
      if(is.null(datapoints)) return("\n")
      paste("x = ", round(datapoints$x, 2), "y = ", round(datapoints$y, 2), "\n")
    }
    xy_points_range <- function(datapoints) {
      if(is.null(datapoints)) return("\n")
      paste("xmin = ", round(datapoints$xmin, 2),
            "xmax = ", round(datapoints$xmax, 2),
            "ymin = ", round(datapoints$ymin, 2),
            "ymax = ", round(datapoints$ymax, 2))
    }
    paste0(
      "single click: ", xy_points(input$single_click),
      "double click: ", xy_points(input$double_click),
      "hovered over: ", xy_points(input$hovering),
      "brushed box: ", xy_points_range(input$brushing)
    )
  })
}
shinyApp(ui = ui, server = server)
