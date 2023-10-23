library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(
      rel = "stylesheet",
      href = "custom.css"
    )
  ),
  titlePanel("Exemplo usando linhas e colunas do bootstrap"),
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

server <- function(input, output, session) {
  output$grafico <- renderPlot({
    mtcars |>
      ggplot(aes(x = .data[[input$variavel_x]], y = mpg))+
      geom_point() +
      theme_minimal()

  })
}

shinyApp(ui, server)
