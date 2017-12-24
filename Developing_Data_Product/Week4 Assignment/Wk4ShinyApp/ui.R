library(shiny)
library(plotly)
shinyUI(fluidPage(
    titlePanel("Iris Classification Simple Application"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("SL", "Sepal Length", 4, 8, step = 0.1, value = 6),
            sliderInput("SW", "Sepal Width", 2, 4.5, step = 0.1, value = 3),
            sliderInput("PL", "Petal Length", 1, 7.0, step = 0.1, value = 6),
            sliderInput("PW", "Petal Width", 0, 2.5, step = 0.1, value = 2),
            submitButton("Submit")
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Documentations",
                                 h3("Iris Classfiction App"),
                                 hr(),
                                 p("This App is designed to classify new Iris flower,
                                   based on built-in dataset in r."),
                                 p("There are 3 classes of Iris:"),
                                 strong("Iris Setosa, Iris Versicolor, Iris Virginica",
                                        style = "color: blue"),
                                 br(),
                                 br(),
                                 p("The 3 classes of iris are distinguished by 4 attributes:"),
                                 strong("Sepal Length, Sepal Width, Petal Length,
                                        Petal Width", style = "color:red"),
                                 br(),
                                 br(),
                                 p("To find out which category a new flower belongs
                                   to, user needs to select the values for the 4
                                   attributes from the sliderbar on the left"),
                                 p("A prediction of class will be shown on the 'App'
                                   tab page. Two scatter plots will also be shown to
                                   compare attributes of new flower to the existing ones in
                                   iris dataset."),
                                 strong("On the two plots, the new data added by the user is
                                        represented by a rhombus shape or diamond.", 
                                        style = "color: red"),
                                 p("The prediction algorithm is random forest, 
                                   and the plot is done using ggplot and plotly."),
                                 br(),
                                 br()
                            
                                 ), 
                        tabPanel("App", 
                                 # plotOutput("plotPred"),
                                 #textOutput("pred", h2),
                                 h3("Classification"),
                                 hr(),
                                 htmlOutput("picture", align = "center"),
                                 h5(textOutput("pred"), align = "center"),
                                 br(),
                                 br(),
                                 br(),
                                 h3("Scatter Plots"),
                                 hr(),
                                 plotlyOutput("plot1"),
                                 br(),
                                 br(),
                                 br(),
                                 plotlyOutput("plot2"),
                                 br(),
                                 br(),
                                 br(),
                                 br()
                                 )
                        ),
            p("copyright 2017 Li Chenyang Merry Xmas ", align = "center")

            )
        )
    )
)