library(shiny)

# Define the User Interface
ui <- fluidPage(
  titlePanel("Simple Interest Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("principal", "Principal Amount (P):", value = 1000, min = 0, step = 1),
      numericInput("rate", "Rate of Interest (% per year):", value = 5, min = 0, step = 0.1),
      numericInput("time", "Time (years):", value = 1, min = 0, step = 0.1),
      actionButton("calculate", "Calculate Interest")
    ),
    
    mainPanel(
      h3("Results"),
      verbatimTextOutput("result"),
      h4("Breakdown of Calculation"),
      verbatimTextOutput("breakdown")
    )
  )
)

# Define the Server Logic
server <- function(input, output) {
  observeEvent(input$calculate, {
    # Ensure all inputs are positive numbers
    if (input$principal < 0 || input$rate < 0 || input$time < 0) {
      output$result <- renderText({
        "All inputs must be positive numbers."
      })
      output$breakdown <- renderText({
        ""
      })
      return()
    }
    
    # Calculate Simple Interest
    simple_interest <- (input$principal * input$rate * input$time) / 100
    
    # Display Results
    output$result <- renderText({
      paste("The Simple Interest is:", round(simple_interest, 2), "currency units.")
    })
    
    # Display Breakdown
    output$breakdown <- renderText({
      paste(
        "Principal (P):", input$principal, "currency units\n",
        "Rate of Interest (R):", input$rate, "% per year\n",
        "Time (T):", input$time, "years\n",
        "\nFormula: Simple Interest = (P × R × T) / 100\n",
        "Calculation: (", input$principal, "×", input$rate, "×", input$time, ") / 100 =",
        round(simple_interest, 2), "currency units"
      )
    })
  })
}

# Combine UI and Server to create the Shiny app
shinyApp(ui = ui, server = server)
