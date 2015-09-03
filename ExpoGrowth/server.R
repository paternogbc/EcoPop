library(shiny)
library(ggplot2)
library(shinydashboard)
library(markdown)


server <- function(input, output) {

 ### Saving data:
 Rawdata <- reactive({

  r <- input$r
  N0 <- input$N0
  time.max <- input$time
  ### Simulations:
  time.min <- 1
  count <- 2
  pop <- data.frame(N = numeric(length = time.max + 1),
                    TIME = numeric(length = time.max + 1))
  pop[1,1] <- N0
  pop[1,2] <- 0
  system.time({
    for (time in time.min:time.max){
      N <- N0 + r * N0
      N0 <- N
      pop[count, 1] <- round(N, digits = 10)
      pop[count, 2] <- time
      count <- count + 1
    }
  })
  
  Rawdata <-pop
 })

 

### Graphs:
 output$p.pop <- renderPlot({
   ggplot(data = Rawdata(), aes(y = N, x = TIME))+
     geom_point(size = 3, alpha = .7, colour = "red")+ geom_line(colour = "red")+
     theme_bw()+
     xlab("Time") + 
     ylab("Population (N)")+
     scale_x_continuous(limits = c(0, input$time))

 })
 
### Raw Data:
 output$data <- renderDataTable(
   Rawdata()[c(1,2)], options = list(
     searchable = FALSE, searching = FALSE, pageLength = 100))
 

}
