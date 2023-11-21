library(shiny)
library(tidyverse)

dados <- mtcars[1:10,1:6]

ui <- fluidPage(
  titlePanel("Adicionando e removendo linhas"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      h3("Remover uma linha"),
      numericInput(
        "linha_remover",
        label = "Escolha uma linha para remover",
        value = 1
      ),
      actionButton(
        "remover",
        label = "Remover linha"
      )
    ),
    mainPanel = mainPanel(
      tableOutput("tabela")
    )
  )
)

server <- function(input, output, session) {

  #Cria valor reativo:
  tabela_atual <- reactiveVal(dados)

  observeEvent(input$remover,{
    nova_tabela <-  tabela_atual() |>
      slice(-input$linha_remover)

    tabela_atual(nova_tabela)

  })

  # tab <- eventReactive(input$remover, ignoreNULL = FALSE,{
  #
  #   dados |>
  #     slice(-input$linha_remover)
  # })

  output$tabela <- renderTable(
   tabela_atual() |>
      rownames_to_column()
  )

}

shinyApp(ui, server)
