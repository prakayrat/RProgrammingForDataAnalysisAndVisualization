library(shiny)
library(datasets)
library(tidyr)
library(tibble)

airquality_NoMissing <- drop_na(airquality) 

options <- c("Ozone (parts per billion)" = "Ozone",
             "Solar (Langleys)" = "Solar.R",
             "Wind (MPH)" = "Wind",
             "Temperature (F)" = "Temp")
df_options <- data.frame(options)
df_label <- rownames_to_column(df_options)
colnames(df_label) <- c("label", "value")

ui <- fluidPage(
  selectInput("X", "X Variable: ", options),
  selectInput("Y", "Y Variable: ", options),
  plotOutput("scatter")
)

server <- function(input, output) {
  selections <- reactive({
    airquality_NoMissing[, c(input$X, input$Y)]
  })
  output$scatter <- renderPlot({
    x_column <- selections()[,1]
    y_column <- selections()[,2]
    
    correlation <- cor(x_column, y_column) 
    regression <- lm(y_column ~ x_column)
    intercept <- regression$coefficients[1] 
    slope <- regression$coefficients[2] 
    
    X_Label <- df_label$label[which(df_label$value == input$X)]
    Y_Label <- df_label$label[which(df_label$value == input$Y)]
    
    plot(x=x_column, y=y_column, xlab=X_Label, ylab=Y_Label,
         cex.axis=1.5, cex.lab=1.5, pch=20, cex=2,
         main=paste(Y_Label, "vs", X_Label, 
                    "\n r = ", round(correlation, 3), 
                    ",  Y_pred = ", round(intercept, 3), "+", round(slope, 3), "X"),
         cex.main=1.8)
    abline(intercept, slope, col="blue")
  })
}

shinyApp(ui = ui, server = server)
