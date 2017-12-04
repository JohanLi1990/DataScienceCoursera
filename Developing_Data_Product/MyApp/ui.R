#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
      
    sidebarPanel(
        h1("H1 Text"),
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    # h1("H1 Text"),
    # h2("H2 Text"),
    # h3("H3 Text"),
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
        # h3("Main Panel Text"),
        # code("some code")
    )
  )
))
