# Lesson 5: So shiny!
Let's make something interactive! Start off by downloading this file:
- [lesson5](../data/lesson5.Rdata") 

## What's Shiny, precious, eh?
- Shiny is an R package that makes it easy to build interactive web apps.
- Shiny apps are interactive ways to display/showcase or work with your data. See here: https://shiny.rstudio.com/ 
### Reactive == Interactive 
- Reactivity is the ability of a program to compute outputs from user inputs
- The program 'responds' to user defined changes
- Three components: 
1. Reactive Inputs
- Triggers that cause values to be set in the environment 
- actions from buttons, selections, uploads, forms, etc.  
2. Reactive Outputs
- Outputs displayed on the browser
- graphs, plots, tables, etc. 
3. Reactive Expressions
- expressions that take in the reactive input to a reactive output 

### Two main functions
- User interface function, defines the structure of the page 
```
ui <- fluidPage( 
  
  titlePanel("This is the title"),
  
  # Inputs
  sidebarLayout(
    sidebarPanel(
      textInput("one", "Number1"),
      textInput("two", "Number2"),
      textInput("caption", "Text1"),      
      actionButton("add", "Add"),
      checkboxInput(inputId = "obs", label = strong("Show individual observations"), value = FALSE),
      sliderInput("bins", "Number of bins:",  min = 1, max = 10, value = 5) 
    ),
    
    # Show result
    mainPanel(
      textOutput("sum"),
      plotOutput("distPlot"),
      tableOutput("table")
      
    )
  )
)
```

- The server function, where all the action happens
```
server <- function(input,output,session) {
  observeEvent( input$add,{
    x <- as.numeric(input$one)
    y <- as.numeric(input$two)
    title <- as.character(input$caption)
    
    #reactive expression
    n <- x+y
    d <- round(abs(rnorm(n)  ) * n )
    m <- mean(d)
    output$test <- renderPrint("Done!")
    output$distPlot <- renderPlot({
      
      bins <- seq(min(d), max(d), length.out = input$bins + 1)
      # draw the histogram with the specified number of bins
      hist(d, breaks = bins, col = 'darkgray', border = 'white', main=title)
      abline(v=m, lty=2, lwd=3, col=4)
      if (input$obs) {
        rug( d  )
      }
      
      })
    output$table <- renderTable({
      data = cbind(n,m)
      return( data ) 
    })

 )
```
### Run!
```
shinyApp(ui = ui, server = server)
```
 

## Easy as 1, 2, 3, infinity 
1. Install it! 
``` 
install.packages("shiny") 
```
2. Load it!
```
library(shiny)
```
3. RStudio makes it very easy to build an app. Simply click on the "File" dropdown menu, then "New File" and then "Shiny Web App...". A pop up box will ask you for an "Application name", call your app whatever you wish (e.g., my_app). Select the "Single File (app.R)" radio button. And then pick your working directory (click Browse on the final box). When you are ready, click "Create".   
4. This will generate a folder with your app name, and a file called "app.R". We will be working with this file. It should have two functions: ui and server. They should be pre-filled with a historgram drawing app. You can test it out by running in the command console (make sure you are in the working directory where your app is):
```
runApp("my_app")
```
5. We can modify the different bits of code in the ui and server functions to change the display and functionality of the code. 
 

6. Play around! 


Back to the [homepage](../README.md)

