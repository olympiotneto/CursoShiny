library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Exercício 8"),
  hr(),
  selectInput(
    inputId = "eixoy",
    label = "Selecione a variável Y",
    choices = diamonds |> select_if(where(is_bare_numeric)) |> names(),
    selected = "carat"
    ),
  hr(),
  selectInput(
    inputId = "eixox",
    label = "Selecione a variável X",
    choices = diamonds |> select_if(where(is.factor)) |> names(),
    selected = "cut"
  ),
  hr(),
  plotOutput("boxplot")

)

server <- function(input, output, session) {

  output$boxplot <- renderPlot({
    diamonds |> ggplot(
      aes(x=.data[[input$eixox]], y = .data[[input$eixoy]])
    )+
      geom_boxplot()

  })

}

shinyApp(ui, server)
