library(shiny);library(shinydashboard)

### Title:

header <- dashboardHeader(title = "Exponential Growth")

### SideBar:
sidebar <- dashboardSidebar(
  sidebarMenu(
   menuItem("Simulations", tabName = "simu", icon = icon("fa fa-circle")),
   menuItem("Raw Data", tabName = "data", icon = icon("fa fa-circle")),
   menuItem("About", tabName = "about", icon = icon("fa fa-info-circle"))
  )
 )


### Dashboard:
body <- dashboardBody(

  ### Tabintes:

  tabItems(

   ### TAB 1 = dashboard:
   tabItem(tabName = "simu",

   fluidRow(

    # Sample size slider
    box(width = 4, title = "Parameters",
        solidHeader = TRUE, status = "primary",

    sliderInput(inputId = "N0",
                    label = "Initial Population Size",
                    value = 50, min = 10, max = 100, step = 10),
    sliderInput(inputId = "time",
                label = "Time",
                value = 30, min = 10, max = 100, step = 10),
    sliderInput(inputId = "r",
               label = "Intrinsic growth rate (r)",
               value = .2, min = -.5, max = .5, step = .05)),

    mainPanel(

     box(width = 8,
         title = "Population Dynamic",
         solidHeader = TRUE, status = "primary",
         plotOutput(outputId = "p.pop")))
   )),

   # TAB 2 = dashboard:

   tabItem(tabName = "data",
           fluidRow(
            box(width = 6, solidHeader = TRUE, status = "primary",
                               title = "Raw Data",
                               dataTableOutput(outputId = "data"))
            )
            ),

   # TAB 3 = About
   tabItem(tabName = "about",
           fluidPage(
               box(width = 10,status = "success",
                   shiny::includeMarkdown("README.md"))
           )
           )
           )
   )

ui <- dashboardPage(header, sidebar, body)


