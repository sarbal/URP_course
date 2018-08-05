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
- expressions that take in the reactive input and convert it to a reactive output 

### Two main functions
- User interface function (```ui```) defines the structure of the page 
- Placing a function in ui tells shiny where to display your object
- Add an R object to your user interface, the object will be reactive if the code that builds it calls a widget value
- a widget is a web element that your users can interact with 
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
    
    # Result display
    mainPanel(
      textOutput("check"),
      plotOutput("distPlot"),
      tableOutput("table")
      
    )
  )
)
```

- The server function (```server```), where all the action happens
- Where you tell shiny how to build your objects
- it builds a list named ```output``` that contains all of the code needed to update the R objects in your app
- Note, each R object needs to have its own entry in the list, and you do so by "defining" the element. Each ouput element needs to be matched to its input element in the ui. 
. E.g., element "check": 
 -- ```output$check``` in ```server``` matches ```textOutput("check")``` in ```ui```  

```
server <- function(input,output,session) {
  # Reactive input 
  observeEvent( input$add,{
    x <- as.numeric(input$one)
    y <- as.numeric(input$two)
    title <- as.character(input$caption)
    
    # Reactive expressions
    n <- x+y
    d <- round(abs(rnorm(n)  ) * n )
    m <- mean(d)
    sdd <- sd(d)
    bins <- seq(min(d), max(d), length.out = input$bins + 1)
      
    # Reactive output
    output$check <- renderPrint("Done!")
    output$distPlot <- renderPlot({
      
      # Draw the histogram with the specified number of bins
      hist(d, breaks = bins, freq=F, col = 'darkgray', border = 'white', main=title)
      ld <- density(d)
      lines(ld, col=4) 
      abline(v=m, lty=2, lwd=3, col=4)      
      if (input$obs) { rug(d) }
      
    })
    output$table <- renderTable({
      data = cbind(n,m, sdd)
      return( data ) 
    })
    
  })
)
```
### Run!
```
shinyApp(ui = ui, server = server)
```



#### Widgets (input)  
- go in the ui function 


function | widget
--- | --- 
actionButton | Action Button
checkboxGroupInput | A group of check boxes
checkboxInput | A single check box
dateInput | A calendar to aid date selection
dateRangeInput | A pair of calendars for selecting a date range
fileInput | A file upload control wizard
helpText | Help text that can be added to an input form
numericInput | A field to enter numbers
radioButtons | A set of radio buttons
selectInput | A box with choices to select from
sliderInput | A slider bar
submitButton | A submit button
textInput | A field to enter text



#### Output functions 
- go in the ui function 


 Output function   |   Creates  
  --- | ---  
 dataTableOutput   |   DataTable 
 htmlOutput   |   raw HTML  
 imageOutput   |   image  
 plotOutput   |   plot 
 ableOutput   |   table  
 textOutput   |   text 
 uiOutput   |   raw HTML  
 verbatimTextOutput   |   text  

#### Render functions 
- go in the server function 


render function   |   Creates
---   |   ---  
renderDataTable   |   DataTable
renderImage   |   images (saved as a link to a source file)
renderPlot   |   plots
renderPrint   |   any printed output
renderTable   |   data frame, matrix, other table like structures
renderText   |   character strings
renderUI   |   a Shiny tag object or HTML




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

