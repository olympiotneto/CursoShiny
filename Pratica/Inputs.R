library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Gráfico A"),
  
  selectInput(
    inputId = "variavel_A",
    label = "Selecione uma variável do eixo X do gráfico A",
    choices = names(mtcars),
    selected = "wt"
  ),
  
  plotOutput(outputId = "grafico_A"),
  
  titlePanel("Gráfico B"),
  
  selectInput(
    inputId = "variavel_B",
    label = "Selecione uma variável do eixo X do gráfico B",
    choices = names(mtcars),
    selected = "wt"
  ), 
  
  plotOutput(outputId = "grafico_B")
  
)

server <- function(input, output, session){
  
  output$grafico_A <- renderPlot({
    print("Executando código do gráfico A")
    
    mtcars |> 
      ggplot(aes(x = .data[[input$variavel_A]], y=mpg))+
      geom_point()
    
  })
  
  output$grafico_B <- renderPlot({
    print("Executando código do gráfico B")
    
    mtcars |> 
      ggplot(aes(x = .data[[input$variavel_B]], y=mpg))+
      geom_point()
  })
  
  
}

shinyApp(ui, server)