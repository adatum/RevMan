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
            menuItem("About", tabName = "about", icon = icon("dot-circle-o")),
            br(),
            actionButton("refresh", "Refresh Data", icon = icon("refresh")),
            br(),
            br(),
            a("View/edit data in browser", href = GSHEET_URL, target = "_blank")
            
        )
    ),
    
    # Body ------------------------------------------------------------------
    dashboardBody(
        
        useShinyjs(),
        
        tabItems(
            
            # Overview tab --------------------------------------------------
            tabItem(tabName = "overview",
                helpText("Welcome to your Revenue Management Dashboard.
                   See highlights", 
                   a("here", 
                     href = "http://rpubs.com/adatum/RevMan", 
                     target = "_blank"),
                   " or documentation in the About tab. Have a profitable day!"
                   ),
                
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
            tabItem(tabName = "nps",

                    box(
                        #height = "400px",
                        width = "1024px",
                        
                        dygraphOutput("npsPlot")
                    ),

                    fluidRow(
                        
                        box(collapsible = TRUE,
                            title = "NPS data",
                            DT::dataTableOutput("npsTable")
                        ),
                        
                        box(collapsible = TRUE,
                            title = tagList(icon = icon("pencil"), 
                                            "Enter NPS data"),
                            
                            # # unfocus/blur button after click
                            # tags$script(
                            #     HTML("$(document).ready(function() {
                            #         $('.btn').on('click', function(){$(this).blur()});
                            #         })"
                            #     )
                            # ), 
                            
                            dateInput("newNPS_date", 
                                      label = "Date", 
                                      startview = Sys.Date(), 
                                      min = Sys.Date()
                            ),
                            
                            numericInput("newNPS_value",
                                         label = "NPS value", 
                                         min = -100,
                                         max = 100, 
                                         value = 50,
                                         step = 1
                            ),
                            
                            actionButton("nps_submit", 
                                         label = "Submit", 
                                         icon = icon("check")
                            )
                        )
                    
                    )
                
            ),
            
            # About tab ----------------------------------------------------
            tabItem(tabName = "about",
                    
                    h3("RevMan: Your Revenue Management Dashboard"),
                    p("RevMan is a proof-of-concept productivity tool for the 
                      hospitality industry highlighting some of the many features
                      available through", 
                      a("Shiny Apps.", href = "http://shiny.rstudio.com")),
                    br(),
                    p("The main sections of the Dashboard are:"),
                    tags$ul(
                        tags$li(strong("Overview tab: "), "Industry-standard 
                                Key Performance Indicators for monitoring the 
                                state of the business in real time. Implements 
                                a red-light/yellow-light/green-light color-coding
                                scheme based on underlying threshold values, to 
                                allow an at-a-glance overview of business health. ",
                                em("Tip: try different values of the modifiable 
                                   parameters in the Google Sheet to see color
                                   changes!")),
                        tags$li(strong("ADR tab: "), "ADR (average daily rate)
                                being an important hospitality business metric 
                                has its own page for viewing year-over-year
                                changes in the metric, as well as exploring the 
                                raw data values. ",
                                em("Tip: plots are highly interactive. Zooming,
                                   rescaling, as well as filtering data by the
                                   legend are all possible! The data table can
                                   also be searched, sorted, and filtered.")),
                        tags$li(strong("NPS tab: "), "NPS (net promoter score)
                                reveals customer satisfaction trends.",
                                em("Tip: try entering new NPS entries with the 
                                   data entry tool. The plot and table will 
                                   automatically refresh."))
                        
                    ),
                    br(),
                    p("What other great features, you ask? How about:"),
                    tags$ul(
                        tags$li(strong("Mobile friendly: "), "Page design is 
                                fluid and adapts to many screen sizes and ratios.
                                Try resizing the browser window or viewing on a
                                mobile device to see what happens!"),
                        tags$li(strong("Persistent data storage: "), "This App
                                lives in the cloud, and can be deployed strictly
                                locally. In either case, it can read and write 
                                data to central data stores like Google Sheets. ",
                                em("(Click the link in the Sidebar.) "),
                                "Other interfaces are of course possible as well.
                                Integrate easily with your existing technologies."),
                        tags$li(strong("In control: "), 'The App is smart about 
                                what data to download, and when. Only the pages
                                viewed are downloaded, and then cached for faster
                                subsequent access. When adding data from the App, 
                                affected plots and tables are automatically reloaded.
                                Plus, the "Refresh Data" button is useful in case
                                manual edits are made in external data stores 
                                (Google Sheets, etc). Automatic periodic polling
                                and refreshing is also possible.')
                    )
            )
        )
    )
)

