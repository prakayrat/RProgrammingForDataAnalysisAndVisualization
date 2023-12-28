# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 4  โต้ตอบกับผู้ใช้ด้วย Shiny 

library(shiny)

ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)

server <- function(input, output) {
  output$static <- renderTable(head(iris))
  output$dynamic <- renderDataTable(iris)}

shinyApp(ui = ui, server = server)

