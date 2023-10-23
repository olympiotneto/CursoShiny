library(shiny)

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
    inputId = "enviar",
    label = "Enviar"
  ),
  hr(),
  textOutput(outputId = "texto")
)

server <- function(input, output, session) {
  
  texto <- eventReactive(input$enviar,{
    idade <- round(
      as.numeric(Sys.Date() - lubridate::as_date(input$data_nascimento))/365
    )
    
    glue::glue("Olá, {input$nome}! Você tem {idade} anos e mora no/na {input$pais}.")
    
    
  })
  
  output$texto <- renderText({
    texto()
    
    
  })
  
}

shinyApp(ui, server)