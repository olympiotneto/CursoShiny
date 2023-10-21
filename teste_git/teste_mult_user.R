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
        tableOutput("tab_estat")
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
        tableOutput("tab_estat")

      )
    )
  )

)

server <- function(input, output, session) {


}

shinyApp(ui, server)
