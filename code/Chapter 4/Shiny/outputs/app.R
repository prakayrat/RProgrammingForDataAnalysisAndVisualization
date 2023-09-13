library(shiny)

ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)

server <- function(input, output) {
  output$static <- renderTable(head(iris))
  output$dynamic <- renderDataTable(iris)}

shinyApp(ui = ui, server = server)

