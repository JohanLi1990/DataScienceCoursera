library(shiny)
library(caret)
library(ggplot2)
library(plotly)
library(ggthemes)

iris_virginica <- "https://www.fs.fed.us/wildflowers/beauty/iris/Blue_Flag/images/iris_virginica_virginica_lg.jpg"
iris_verisicolor <- "https://www.plant-world-seeds.com/images/item_images/000/003/884/large_square/IRIS_VERSICOLOR.JPG?1495391088"
iris_setosa <- "http://www.twofrog.com/images/iris38a.jpg"

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   modFit <- train(Species~ .,data=iris,method="rf",prox=TRUE)
   
   InputData<- reactive({
       data.frame(Sepal.Length = input$SL, Sepal.Width = input$SW, 
                  Petal.Length = input$PL, Petal.Width = input$PW)
   }) 
       
   pred <- reactive({
      predict(modFit, newdata = InputData())
   })
   
   
   output$pred <- renderText({
       as.character(pred())
   })
   
   output$picture <- renderText({
       num <- as.numeric(pred())
       if(num == 1){
           file_url <- iris_setosa
       }
       else if(num == 2){
           file_url <- iris_verisicolor
       }
       else if(num == 3){
           file_url <- iris_virginica
       }
       else{
           file_url <- iris_virginica
       }
           
       
       c(
           '<img src="',
           file_url,
           '"width=', "240", 'height="', "220", 'alt="', "Cannot Find Appropriate Picture",
           '">'
       )
   })
   
   output$plot1 <- renderPlotly({

       p1<- ggplot(data = iris, aes(x= Petal.Length, y=Sepal.Length, color = Species)) + geom_point()
       plotInput <- InputData()
       plotInput$Species <- as.character(pred())
       p1 <- p1 + geom_point(data = plotInput, shape = 23, size = 4) + theme_gdocs()
       print(ggplotly(p1))
       
   })
   
   output$plot2 <- renderPlotly({
       
       p2<- ggplot(data = iris, aes(x= Petal.Width, y=Sepal.Width, color = Species)) + geom_point()
       plotInput <- InputData()
       plotInput$Species <- as.character(pred())
       p2 <- p2 + geom_point(data = plotInput, shape = 23, size = 4) + theme_gdocs()
       print(ggplotly(p2))
       
   })
       
   
})
       

