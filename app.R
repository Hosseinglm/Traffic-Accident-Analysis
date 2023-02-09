library(shiny)
library(shinydashboard)
library(rsconnect)
library(readr)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(rvest)
library(summarytools)
#install.packages("devtools")
#devtools::install_github("haleyjeppson/ggmosaic")
library(ggmosaic)
library(devtools)
library(markdown)

#getwd()
#setwd("URL Address")

data<- read_csv("traffic_Accident_Cleaned.csv")
#head(data, header=T)


shinyUI(fluidPage(
# Define UI for application that draws a histogram
ui <- fluidPage(

  ui <- dashboardPage(
    skin = "yellow",
   
    
    dashboardHeader(title = "Traffic Accident Analysis"),
    
    dashboardSidebar(width = 425,
      sidebarMenu(
        HTML(paste0(
          "<br>",
          "<a href='' target='_blank'><img style = 'display: block; margin-left: auto; margin-right: auto;' src='traffic_accident.png' width = '186'></a>",
          "<br>",
          
          "<br>"
        )),
        menuItem("Home", tabName = "Home",icon = icon("home")),
        
        
        #menuItem("Average Time of Accidents", tabName = "tree", icon = icon("random", lib = "glyphicon")),
        #menuItem("Sex of Casaulity", tabName = "charts", icon = icon("stats", lib = "glyphicon")),
        #menuItem("Correlation", tabName = "choropleth", icon = icon("map marked alt")),
        #menuItem("Our Team", tabName = "releases", icon = icon("tasks")),
        menuItem("The Severity and Number of Accident Individual-Based Analytics", startExpanded = TRUE,
                 menuSubItem("Based on Gender Categories", tabName = "Gender"),
                 menuSubItem("Based on Age Categories", tabName = "Age"),
                 menuSubItem("Based on Driving Experience", tabName = "Experience")
                 
        ),
        menuItem("The Severity and Number of Environmental-Based Analytics", startExpanded = TRUE,
                 
                 menuSubItem("Based on Type of Juctions", tabName = "Junction"),
                 menuSubItem("Based on Weather Conditions", tabName = "Weather"),
                 menuSubItem("Based on Road Surface Type", tabName = "Road"),
                 menuSubItem("Based on Light Conditions", tabName = "Light")
        ),
        menuItem("Type of Collision", tabName = "Collision", icon = icon("thumbtack")),
        menuItem("Cause of Accidents", tabName = "Cause", icon = icon("table")),
        menuItem("Our Team", tabName = "Team_Members")
        
      )
    ),
    
    dashboardBody(

      tabItems(
        # Home tab content
        tabItem(tabName = "Home",
                
                # home section
                includeMarkdown("www/home.md")
                
                
        ),
        
          # Collision tab content
          tabItem(tabName = "Collision",
                  
                  fluidRow(
                    box(
                      titlePanel("Accident Severity and Type of Collision"),
                      p("The diagram below shows the number of accidents in every level of severity and every level categorized by the number of collision types. The highest level of severity accounts for most of the accidents with vehicle collisions."),
                      br(),br(),
                      plotOutput("Collision", height = 400),
                      br(),p("Accident Severity and Type of Collision"),br(),
                      plotOutput("Collision2", height = 400),
                      
                      width = 12,
                    ),
                  ),
 
          ),
        # Cause tab content
        tabItem(tabName = "Cause",
                
                fluidRow(
                  box(
                    titlePanel("Cause of Accident"),
                    p("There are plenty of causes for an accident to take place. The highest cause for an accident is “No Distance” with a total of 2,250 accidents. This indicated that accidents happened due to no safe distance between vehicles when on the road."),
                    br(),br(),
                    plotOutput("Cause", height = 400),
                    br(),p("The amount of Accident Severity Based on Cause of Accident"),br(),
                    plotOutput("Cause2", height = 400),
                    
                    width = 12,
                  ),
                ),
                
        ),
          
        # Second tab content
        
        tabItem(tabName = "Gender", 
                br(),
                fluidRow(
                box(
                  titlePanel("Gender"),
                  p("The overwhelming majority of drivers are men in this dataset. There is a small part in the dataset with unknown sex."),
                  br(),br(),
                  plotOutput("Gender", height = 400),
                  
                  width = 12,
                  ),
                ),
                ),
        
        tabItem(tabName = "Age", 
                br(),
                fluidRow(
                  box(
                    titlePanel("Accident Severity and Age"),
                    p("Accidents with the most severity (Class 2) have different age groups of drivers. The highest number of accidents in level 2 belongs to drivers aged between 18 to 30 years old. This group of age has more than 3500 number of accidents recorded. The second highest belongs to drivers aged between 31 to 50 years old with 3500 number of accidents recorded."),
                    br(),br(),
                    plotOutput("Age", height = 400),
                    width = 12,
                  ),
                ),
        ),
        tabItem(tabName = "Experience", 
                br(),
                fluidRow(
                  box(
                    titlePanel("Accident Severity and Experience"),
                    p("Driving experiences of each driver on level 2 has been categorized based on the total years driving experiences. Drivers with 5 to 10 years of driving experience have the highest number of accidents in Class 2. This category counted more than 2,500 accidents. While drivers with 2 to 5 years of driving experience in Class 2 have a record of slightly more than 2,000 accidents."),
                    br(),br(),
                    plotOutput("Experience", height = 400),
                    width = 12,
                  ),
                ),
        ),
       
        
        tabItem(tabName = "Junction",
                br(),
                fluidRow(
                  box(
                    titlePanel("Accident Severity and Junction"),
                    p("Accidents with the most severity in Class 2 occurred at various junction on the road. Based on the stacked bar graph, accidents mostly happened at the “Y” shape junction as well as at location with No junction. Both locations of the road have equal total of accidents recorded with about 2500 of accidents."),
                    br(),br(),
                    plotOutput("Junction", height = 400),
                    width = 12,

                  ),

                ),
        ),
        
         tabItem(tabName = "Weather",
                 br(),
                 fluidRow(
                   box(
                     titlePanel("Weather Condition"),
                     p("As the diagram shows, the vast majority of accidents occur in normal weather. It seems weather conditions do not play an important role in the occurrence of accidents."),
                     br(),br(),
                     plotOutput("Weather", height = 400),
                     width = 12,
        
                   ),
        
                 ),
        ),
        
        tabItem(tabName = "Road",
                br(),
                fluidRow(
                  box(
                    titlePanel("Type of Road"),
                    p("The number of accidents that happen on Asphalt roads are dramatically higher than other types of road. It seems the type of roads do not play an important role in the occurrence of accidents."),
                    br(),br(),
                    plotOutput("Road", height = 400),
                    width = 12,

                  ),

                ),
        ),
        
        tabItem(tabName = "Light",
                br(),
                fluidRow(
                  box(
                    titlePanel("Accident Severity and Light Conditions"),
                    p("The majority of the accidents took place during the daylight in each of the accident severity classes. However, conditions with total darkness and no lighting are also considerable."),
                    br(),br(),
                    plotOutput("Light", height = 600),
                    width = 12,
                    
                  ),
                  
                ),
                #sidebarLayout(
                 # sidebarPanel(h3("Input"), 
                 #              #sliderInput("flightHour", "Flight Hour", min = 1, max = 24, step = 1, round = TRUE, value = 20),
                 #              radioButtons("Accident_severity", "Accident_severity",choices = c(0,1,2), selected = 0),
                  #             selectInput("Vehicle_driver_relation", "Vehicle_driver_relation",choices = c("Employee","Owner","Other","Unknown"), selected = 4)),
                 # mainPanel(
                    
                  #  plotOutput("Light"),
                  #  br(),br(),
                   # tableOutput("results")
                    
                    
                 # )
               # )
                
            
        ),
       
       
        tabItem(tabName = "Team_Members",
                br(),
                #box(
                  titlePanel("Our Team Members"),
                  #h3("Project : "),
                br(),br(),
                  tags$ul(
                    h3(tags$li("ID: S2155520 || Name: Hossein Golmohammadi"), 
                    tags$li("ID: S2108177 || Name: Rahman karimiyazdi"), 
                    tags$li("ID: S2162214  || Name: Yang Wang"), 
                    tags$li("ID: S2150932 || Name: Amirah Nur Binti Azman"), 
                    tags$li("ID: S2163882 || Name: Yaping Wang"))
                  ),
                
               
        )
       
      )
    )
  )

)
))
# Define server logic required to draw a histogram
server <- function(input, output) {

  #Collision  
  output$Collision <- renderPlot({
    ggplot(data) +
      geom_bar(aes(x = Accident_severity, fill = Type_of_collision)) +
      xlab("Severity of Accidents") + ylab("Number of Accidents")
    
    
  })
  output$Collision2 <- renderPlot({
    
    ggplot(data) +
      geom_bar(aes(x = Accident_severity, fill = Type_of_collision)) +
      xlab("Severity of Accident") + ylab("Count")
    
  })
  
  #Causes  
  output$Cause <- renderPlot({
    
    
    p_causes <- ggplot(data) +
      geom_bar(aes(x = Cause_of_accident), position = "dodge", width = 0.2) +
      xlab("Causes of Accidents") + ylab("Number of Accidents")
    p_causes + coord_flip()

  })
  output$Cause2 <- renderPlot({
    
      ggplot(data) +
      geom_bar(aes(x = Accident_severity, fill = Cause_of_accident)) +
      xlab("Severity of Accident") + ylab("Count")
    
  })
  
  output$Gender <- renderPlot({
    
      #dataIns %>%
      #group_by(flightDay) %>%
      #summarise(numOfFlag = sum(insFlag)) %>%
      #arrange(desc(numOfFlag)) %>%
      
    ggplot(data, aes(x=Accident_severity, fill=Sex_of_driver )) + 
      geom_bar(position = "dodge") + 
      labs(x="Severity of Accidents",y="Number of Accidents")  
  })

  output$Age <- renderPlot({

     
    ggplot(data, aes(x=Accident_severity, fill=Age_Categories )) + 
      geom_bar(position = "dodge") + 
      labs(x="Severity of Accidents",y="Number of Accidents")

  })
  output$Experience <- renderPlot({
      
    ggplot(data, aes(x=Accident_severity, fill=Driving_experience )) + 
      geom_bar(position = "dodge") + 
      labs(x="Severity of Accidents",y="Number of Accidents")
  })

  output$Junction <- renderPlot({
     
    ggplot(data) +
      geom_bar(aes(x = Accident_severity, fill = Types_of_Junction)) +
      xlab("Severity of Accidents") + ylab("Number of Accidents")

  })
  
  output$Weather <- renderPlot({
    
    p_weather <- ggplot(data) +
      geom_bar(aes(x =Weather_conditions , fill = Weather_conditions), width = 0.5) +
      xlab("Weather Condistions") + ylab("Number of Accidents")
    p_weather + coord_flip()
  })
  
  output$Road <- renderPlot({
    p_road <- ggplot(data) +
      geom_bar(aes(x = Road_surface_type, fill=Road_surface_type), position = "dodge", width = 0.5) +
      xlab("Type of Roads Surface") + ylab("Number of Accidents")
    p_road + coord_flip()
  })
  
  output$Light <- renderPlot({

    ggplot(data) + geom_mosaic(aes(x = product(Light_conditions, Accident_severity), fill = Light_conditions)) + 
      xlab("Severity of Accidents") + ylab("Light Conditions")
   
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
