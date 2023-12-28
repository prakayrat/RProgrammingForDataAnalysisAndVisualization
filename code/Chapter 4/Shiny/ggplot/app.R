# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 4  โต้ตอบกับผู้ใช้ด้วย Shiny 

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Visualization using ggplot"),
  
  sliderInput(inputId = "number",
              label = "Select a number",
              value = 750, min = 25, max = 1000),
  sliderInput(inputId = "binwidth",
              label = "Select a binwidth",
              value = .05, min = .01, max = .10),

  plotOutput("hist"),
  
  h4(textOutput("mean")), 
  h4(textOutput("sd"))
)

server <- function(input, output) {
  histdata <- reactive({
    runif(input$number, min=0, max=1)
  })
  output$hist <- renderPlot({
    df <- data.frame(histdata())
    colnames(df) <- c("Value")
    ggplot(df, aes(x=Value)) +
      geom_histogram(binwidth = input$binwidth,
                     color="blue", fill="skyblue") +
      labs(y="Frequency", 
           title=paste("random number : ", input$number,
                       " values with binwidth : ", input$binwidth)) +
      theme_bw()
  })
  output$mean <- renderText({paste("Mean =", round(mean(histdata()), 2))})
  output$sd <- renderText({paste("Standard Deviation =", 
                                 round(sd(histdata()), 3))})
}


shinyApp(ui = ui, server = server)
