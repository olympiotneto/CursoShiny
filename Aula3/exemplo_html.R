library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(
      rel = "stylesheet",
      href = "custom.css"
    )
  ),
  tags$h1(
    "App com exemplos de HTML"
    ),
  tags$hr(),
  includeMarkdown("md/descricao.md"),
  tags$hr(),
  tags$img(
    src = "https://www.tre-sp.jus.br/administracao/destaques/6-de-outubro-falta-um-ano-para-as-eleicoes-2024/@@images/36d1863e-0228-401a-8673-a89d30343252.jpeg",
  style = "width: 200px; display: block; margin: auto;"
  )
)


server <- function(input, output, session) {

}

shinyApp(ui, server)
