## ui.R ##

library(shinydashboard)

dashboardPage(skin = "purple",
              
    dashboardHeader(
        title = "RevMon",
        dropdownMenu(type = "messages"),
        dropdownMenu(type = "notifications"),
        dropdownMenu(type = "tasks")
    ),
    
    dashboardSidebar(
        sidebarMenu(
            menuItem("Overview", tabName = "overview", icon = icon("dashboard"))
            
        )
    ),
    
    dashboardBody(
        fluidRow(
            valueBox(112, "NPS", 
                     icon = icon("thumbs-up", lib = "glyphicon"),
                     color = ifelse(TRUE, "green", "yellow"))
            
        )
        
    )
)

