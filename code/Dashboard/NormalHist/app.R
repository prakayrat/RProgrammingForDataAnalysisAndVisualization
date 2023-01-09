library(shinydashboard)
library(moments)

ui <- dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      column(width=8,
             box(title = "Numbers", width=NULL,
                 status="warning",
                 background="yellow", 
                 sliderInput(inputId = "number",
                             label = "Number of observations: ",
                             value=100, min=10, max=500)),
             box(title = "Histogram", width=NULL,
                 status="primary",
                 background="light-blue",
                 plotOutput("plot1", height=250))
      ),
      column(width=4,
             tabBox(title="Central Tendency",
                    id="tabs1", height=150, width=NULL, side="right",
                    tabPanel("Mean", h4(textOutput("meantext"))
                             , width=NULL),
                    tabPanel("Median", h4(textOutput("mediantext"))
                             , width=NULL)),
             tabBox(title="Dispersion",
                    id="tabs2", height=150, width=NULL, side="right",
                    tabPanel("Variance", h4(textOutput("vartext"))
                             , width=NULL),
                    tabPanel("Standard Deviation", h4(textOutput("sdtext"))
                             , width=NULL)),
             tabBox(title="Appearance",
                    id="tabs3", height=150, width=NULL, side="right",
                    tabPanel("Skewness", h4(textOutput("skewtext")), width=NULL),
                    tabPanel("Kurtosis", h4(textOutput("kurtext")), width=NULL))
      )
    )
  )
)

server <- function(input, output) {
  set.seed(2023)
  histdata <- reactive({rnorm(input$number, mean=0, sd=1)})
  
  output$plot1 <- renderPlot({
    hist(histdata(),
         main=paste("Normal Distribution of ", input$number, "values"))
  })
  output$meantext <- renderText({
    paste("Mean = ", round(mean(histdata()), 2))
  })
  output$mediantext <- renderText({
    paste("Median = ", round(median(histdata()), 2))
  })
  output$vartext <- renderText({
    paste("Variance = ", round(var(histdata()), 3))
  })
  output$sdtext <- renderText({
    paste("Standard Deviation = ", round(sd(histdata()), 3))
  })
  output$skewtext <- renderText({
    paste("Skewness = ", round(skewness(histdata()), 3))
  })
  output$kurtext <- renderText({
    paste("Kurtosis = ", round(kurtosis(histdata()), 3))
  })
}

shinyApp(ui = ui, server = server)
