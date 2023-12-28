# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 5  สรุปภาพรวมและเรียลไทม์ด้วย Dashboard 

library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title="Sampling"),
  dashboardSidebar(
    sidebarMenu(
      sliderInput(inputId = "number",
                  label = "Number of observations: ",
                  value=100, min=10, max=500),
      menuItem("Uniform distribution", tabName= "uniform", icon=icon("table")),
      menuItem("Normal distribution", tabName= "normal", icon=icon("bar-chart-o"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName="uniform", h2("Uniform Distribution"),
              fluidRow(column(8,
                              box(title = "Histogram",
                                  background="purple",
                                  solidHeader = TRUE,
                                  width=90,
                                  plotOutput("hist", height=300))),
                       column(12,
                              valueBoxOutput("meanBox"),
                              valueBoxOutput("sdBox")))),
      
      tabItem(tabName="normal", h2("Normal Distribution"),
              fluidRow(column(8,
                              box(title = "Density plot",
                                  background="green",
                                  solidHeader = TRUE,
                                  width=90,
                                  plotOutput("density", height=300))),
                       column(12,
                              valueBoxOutput("mean_Box"),
                              valueBoxOutput("sd_Box"))))
    )
  )
)

server <- function(input, output) {
  set.seed(2023)
  histdata <- reactive({runif(input$number, min=0, max=1)})
  densitydata <- reactive({rnorm(input$number)})
  
  output$hist <- renderPlot({
    hist(histdata(),
         main=paste(input$number, "random values"))
  })
  output$density <- renderPlot({
    hist(densitydata(), 
         main=paste(input$number, "random values"),
         probability=TRUE)
    lines(density(densitydata()))
  })
  
  output$meanBox <- renderValueBox({
    valueBox(round(mean(histdata()), 2), "Mean", color="lime")
  })
  output$sdBox <- renderValueBox({
    valueBox(round(sd(histdata()), 3), "Standard Deviation", color="fuchsia")
  })
  
  output$mean_Box <- renderValueBox({
    valueBox(round(mean(densitydata()), 2), "Mean", color="maroon")
  })
  output$sd_Box <- renderValueBox({
    valueBox(round(sd(densitydata()), 3), "Standard Deviation", color="aqua")
  })
}

shinyApp(ui = ui, server = server)

