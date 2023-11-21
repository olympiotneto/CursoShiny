library(shiny)
library(tidyverse)

# ocorrencias <- dados |>
#   select(estupro:vit_latrocinio) |>
#   names() |>
#   #Cria o código que gera o vetor
#   dput()

ui <- fluidPage(
  titlePanel("Dados de criminalidade da SSP"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "ocorrencia",
        label = "Selecione uma ocorrência",
        choices = c(
          "estupro",
          "estupro_total",
          "estupro_vulneravel",
          "furto_outros",
          "furto_veiculos",
          "hom_culposo_acidente_transito",
          "hom_culposo_outros",
          "hom_doloso",
          "hom_doloso_acidente_transito",
          "hom_tentativa",
          "latrocinio",
          "lesao_corp_culposa_acidente_transito",
          "lesao_corp_culposa_outras",
          "lesao_corp_dolosa",
          "lesao_corp_seg_morte",
          "roubo_banco",
          "roubo_carga",
          "roubo_outros",
          "roubo_total",
          "roubo_veiculo",
          "vit_hom_doloso",
          "vit_hom_doloso_acidente_transito",
          "vit_latrocinio"
        )
      ),
      shinyWidgets::pickerInput(
        inputId = "regiao",
        label = "Selecione as regiões",
        choices = c("Carregando..." = ""),
        multiple = TRUE,
        options = shinyWidgets::pickerOptions(
          actionsBox = TRUE,
          selectAllText = "Selecionar tudo",
          deselectAllText = "Limpar seleção"
        )
      ),
      #como usa update, pode fazer isso
      shinyWidgets::pickerInput(
        inputId = "municipio",
        label = "Selecione um ou mais municípios",
        multiple = TRUE,
        choices = c("Carregando..." = ""),
        selected = c(""),
        options = shinyWidgets::pickerOptions(
          actionsBox = TRUE,
          selectAllText = "Selecionar tudo",
          deselectAllText = "Limpar seleção"
        )


      )
    ),
    mainPanel(
      plotOutput("grafico")

    )
  )
)

server <- function(input, output, session) {

  dados <- read_rds(
    here::here(
      "dados/ssp.rds"
    )
  ) |>
    mutate(
      data = lubridate::make_date(
        year = ano,
        month = mes,
        day =1
      )
    )


  output$grafico <- renderPlot({


    #req() testa se o argumento dela é válido. Caso não, retorna erro.
    #É usado para validar coisas
    #req(input$regiao)

    #esse outro jeito de validar gera uma msg na tela
    validate(
      need(
        isTruthy(input$municipio),
        message = "Selecione pelo menos um municipio para gerar um gráfico"
      )
    )

    dados |>
      filter(municipio_nome %in% input$municipio) |>
      group_by(data) |>
      summarise(
        media = mean(.data[[input$ocorrencia]], na.rm = TRUE)
      ) |>
      ggplot(aes(x = data, y=media))+
      geom_line() +
      theme_classic()
  })

  regioes <- dados |>
    pull(regiao_nome) |>
    unique() |>
    sort()

  shinyWidgets::updatePickerInput(
    session =  session,
    inputId = "regiao",
    choices = regioes,
    selected = regioes
  )

  # output$select_municipios <- renderUI({

  #
  # })

  observe({
    municipios <- dados |>
      filter(regiao_nome %in% input$regiao) |>
      pull(municipio_nome) |>
      unique() |>
      sort()
    shinyWidgets::updatePickerInput(
      session =  session,
      inputId = "municipio",
      choices = municipios,
      selected = municipios
    )
  })

}

shinyApp(ui, server)
