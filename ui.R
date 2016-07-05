## ui.R ##

library(shinydashboard)

dashboardPage(skin = "purple",
    
    # Header ----------------------------------------------------------------                    
    dashboardHeader(
        title = "RevMan",
        dropdownMenu(type = "messages"),
        dropdownMenu(type = "notifications"),
        dropdownMenu(type = "tasks")
    ),
    
    # Sidebar ---------------------------------------------------------------
    dashboardSidebar(
        sidebarMenu(
            menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
            menuItem("ADR", tabName = "adr", icon = icon("dollar")),
            menuItem("NPS", tabName = "nps", icon = icon("thumbs-up")),
            br(),
            actionButton("refresh", "Refresh Data", icon = icon("refresh")),
            br(),
            br(),
            a("View/edit data in browser", href = GSHEET_URL)
            
            
        )
    ),
    
    # Body ------------------------------------------------------------------
    dashboardBody(
        
        tabItems(
            
            # Overview tab --------------------------------------------------
            tabItem(tabName = "overview",
                helpText("Welcome to your Revenue Management Dashboard.
                   Documentation available", 
                   a("here.", href = "http://rpubs.com/adatum/RevMan"),
                   "Have a profitable day!"),
                
                h3("Business Metrics Summary"),
                
                fluidRow(
                    valueBoxOutput("npsBox"),
                    valueBoxOutput("adrBox"),
                    valueBoxOutput("occBox")
                ),
                
                fluidRow(
                    valueBoxOutput("nlocBox"),
                    valueBoxOutput("rpBox"),
                    valueBoxOutput("arpBox")
                ),
                
                fluidRow(
                    valueBoxOutput("profitBox")
                )
            ),
            
            
            # ADR tab -------------------------------------------------------
            tabItem(tabName = "adr",
                    tabBox(
                        height = "400px",
                        width = "1024px",
                        
                        tabPanel("Year over Year ADR",
                                 plotlyOutput("adrPlot")
                        ),
                        
                        tabPanel("ADR timeseries", 
                                 dygraphOutput("adrtsPlot")),
                        
                        tabPanel("ADR data",
                                 DT::dataTableOutput("adrtsTable"))
                    )
            ),
            
            
            # NPS tab -------------------------------------------------------
            tabItem(tabName = "nps"
                
            )
        )
    )
)

#icon("line-chart")
