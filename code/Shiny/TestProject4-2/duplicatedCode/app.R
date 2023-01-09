library(shiny)
ui <- fluidPage(
  numericInput("num1", "Insert Number1: ", value=10, min=1, max=100),
  numericInput("num2", "Insert Number2: ", value=10, min=1, max=100),
  "then, (Number 1 + Number 2) is ", textOutput("plus"),
  "and, (Number 1 + Number 2) + 10 is ", textOutput("plus_plus10"),
  "and, (Number 1 + Number 2) x 10 is ", textOutput("plus_multiply10")
)

server <- function(input, output) {
  output$plus <- renderText({
    plus <- input$num1 * input$num2
    plus
  })
  output$plus_plus10 <- renderText({
    plus <- input$num1 * input$num2
    plus + 10
  })
  output$plus_multiply10 <- renderText({
    plus <- input$num1 * input$num2
    plus * 10
  })
}

shinyApp(ui = ui, server = server)
