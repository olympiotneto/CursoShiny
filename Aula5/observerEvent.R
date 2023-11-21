library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Formulário"),
  hr(),
  textInput(
    inputId = "nome",
    label = "Nome",
    value = ""
  ),
  dateInput(
    inputId = "data_nascimento",
    label  = "Data de nascimento",
    value = Sys.Date(),
    language = "pt-BR",
    format = "dd-mm-yyyy"
  ),
  selectInput(
    inputId = "pais",
    label = "País",
    choices = c("Brasil", "Argentina", "Bolívia", "Peru"),
    selected = "Brasil"
  ),
  actionButton(
    inputId = "enviar_excel",
    label = "Salvar Excel",
  ),
  actionButton(
    inputId = "enviar_csv",
    label = "Salvar csv"
  ),
  hr(),
  textOutput(outputId = "texto")
)

server <- function(input, output, session) {

  observeEvent(input$enviar_excel, {

    nome_sem_espaco <- stringr::str_remove_all(input$nome, " ")
    hora_sem_espaco <- stringr::str_remove_all(
      as.character(Sys.time()), " |:|-")
    nome_arquivo <- glue::glue(
      "arq_salvos/{nome_sem_espaco}_{hora_sem_espaco}.xlsx"
    )
    tibble::tibble(
      nome = input$nome,
      data_nascimento = input$data_nascimento,
      pais = input$pais
    ) |> writexl::write_xlsx(nome_arquivo)
  })

  observeEvent( input$enviar_csv, {
    tibble::tibble(
      nome = input$nome,
      data_nascimento = input$data_nascimento,
      pais = input$pais
    ) |>
      write_csv2("arq_salvos/dados.csv", append = TRUE)
  })

  texto <- reactive({
    idade <- round(
      as.numeric(Sys.Date() - lubridate::as_date(input$data_nascimento))/365
    )

    glue::glue("Olá, {input$nome}! Você tem {idade} anos e mora no/na {input$pais}.")


  }) |>

    bindEvent(input$enviar_excel, input$enviar_csv)

  output$texto <- renderText({
    texto()
  })


}

shinyApp(ui, server)
