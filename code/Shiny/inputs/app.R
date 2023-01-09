library(shiny)

color <- c("brown","azure","pink","other")
animal <- c("dog","cat","bird","other")


ui <- fluidPage(
  checkboxGroupInput("c1", "Q1: What animals do you like?", animal),
  textAreaInput("c3", "Q2: Description: ", row=3),
  radioButtons("c4", "Q3: What's your favourite color?", color),
  passwordInput("c5", "Q4: Password: ")
)
server <- function(input, output) {
}
shinyApp(ui = ui, server = server)

