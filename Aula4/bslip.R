library(shiny)
library(tidyverse)

ui <- navbarPage(
  title = "Exemplo navbarPage",
  #escolhe a versão do bootstrap
  theme = bslib::bs_theme(5),
  tabPanel(
    title = "Página 1",
    selectInput(
      inputId = "var1",
      label = "Selecione a variável",
      choices = mtcars |> names()
    ),
    plotOutput("grafico1")
  ),
  tabPanel(
    title = "Página 2",
    fluidRow(
      column(
        width = 4,
        selectInput(
          inputId = "var2",
          label = "Selecione a variável",
          choices = mtcars |> names()
        )
      ),
      column(
        width = 8,
        plotOutput("grafico2")
      )
    )

  ),
  tabPanel(
    title = "Página 3",
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        width = 4,
        tags$p(
          class = "nome_input",
          "Filtro da aplicação"
        ),

        selectInput(
          inputId = "variavel_x",
          label = "Selecione a variável do eixo X",
          choices = mtcars |> names()
        )

      ),
      mainPanel = mainPanel(
        width =8,
        plotOutput("grafico")
      )
    )
  )
)



server <- function(input, output, session) {
  output$grafico1 <- renderPlot({
    plot(mtcars[[input$var1]], mtcars$mpg)
  })

  output$grafico2 <- renderPlot({
    plot(mtcars[[input$var2]], mtcars$mpg)
  })

  output$grafico <- renderPlot({
    plot(mtcars[[input$variavel_x]], mtcars$mpg)
  })

}

shinyApp(ui, server)
