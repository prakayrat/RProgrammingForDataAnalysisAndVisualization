library(shiny)

ui <- dashboardPage(skin = "yellow",
                    dashboardHeader(title="My Projects"),
                    dashboardSidebar(
                      sidebarMenu(
                        print("Sampling: "),
                        sliderInput(inputId = "number",
                                    label = "Number of observations: ",
                                    value=100, min=10, max=500),
                        menuItem("Uniform distribution", tabName= "uniform", icon=icon("table")),
                        menuItem("Normal distribution", tabName= "normal", icon=icon("bar-chart-o")),
                        print("Mouse Interactive: "),
                        menuItem("x y coordinates", tabName= "mouseact1", icon=icon("cog")),
                        menuItem("rows in data frame", tabName= "mouseact2", icon=icon("square"))
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
                                                valueBoxOutput("sd_Box")))),
                        tabItem(tabName="mouseact1", h2("Mouse Action 1")),
                        tabItem(tabName="mouseact2", h2("Mouse Action 2"))
                        )
                      )
                    )

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)
