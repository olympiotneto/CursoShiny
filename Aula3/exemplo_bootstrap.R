library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Exemplo usando linhas e colunas do bootstrap"),
  tags$hr(),
  fluidRow(
    column(
      width = 3,
      selectInput(
        inputId = "variavel_x",
        label = "Selecione a variável do eixo X",
        choices = mtcars |> names()
      )
    ),
    column(
      width = 9,
      plotOutput("grafico")
    )
  )
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    mtcars |>
      ggplot(aes(x = .data[[input$variavel_x]], y = mpg))+
      geom_point() +
      theme_minimal()

  })

}

shinyApp(ui, server)
