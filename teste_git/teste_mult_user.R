library(shiny)
library(tidyverse)

ui <- navbarPage(
  title = "Teste app",
  tabPanel(
    title = "Página 1",
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        selectInput(
          inputId = "var_p_1",
          label = "Selecione a variável",
          choices = names(mtcars)
        )
      ),
      mainPanel = mainPanel(
        tableOutput("tab_estat_1")
      )
    )
          ),
  tabPanel(
    title = "Página 2",
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        selectInput(
          inputId = "var_p_2",
          label = "Selecione a variável",
          choices = names(mtcars)
        )
      ),
      mainPanel = mainPanel(
        tableOutput("tab_estat_2"),
        plotOutput("grafico_p_2")

      )
    )
  )

)

server <- function(input, output, session) {

  output$tab_estat_1 <- renderTable({
    mtcars |> summarise(
      Media = mean(.data[[input$var_p_1]], na.rm = TRUE),
      DP = sd(.data[[input$var_p_1]], na.rm = TRUE))
  })

  output$tab_estat_2 <- renderTable({
    mtcars |> summarise(
      Media = mean(.data[[input$var_p_2]], na.rm = TRUE),
      DP = sd(.data[[input$var_p_2]], na.rm = TRUE))
  })

  output$grafico_p_2 <- renderPlot({
    mtcars |> ggplot(
      aes(x = .data[[input$var_p_2]], y= mpg)
      ) +
      geom_point()
  })
}


shinyApp(ui, server)
