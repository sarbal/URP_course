# Lesson 5: So shiny!
Let's make something interactive! Start off by downloading this file:
- [lesson5](../data/lesson5.Rdata") 

## What's Shiny, precious, eh?
- Shiny is an R package that makes it easy to build interactive web apps.
- Shiny apps are interactive ways to display/showcase or work with your data. See here: https://shiny.rstudio.com/ 

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

