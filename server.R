## server.R ##

library(shiny)

shinyServer(function(input, output) {

    # Data loading functions -----------------------------------------------
    
    metrics_Data <- reactive({
        #refresh data on Refresh button click
        input$refresh
        
        # Current metrics
        current_metrics <- GSHEET_URL %>% 
            gs_url() %>% 
            gs_read(ws = "Current_Metrics", range = "A2:B12")
        
        metrics <- as.list(
            setNames(current_metrics$Current_Values,
                     current_metrics$Metric)
            )
        
        return(metrics)
    })
    
    adr_Data <- reactive({
        #refresh data on Refresh button click
        input$refresh
        
        # Historical ADR
        monthly_adr <- GSHEET_URL %>% 
            gs_url() %>% 
            gs_read(ws = "Monthly_ADR", range = "A1:C13") %>%
            gather(key = Year, value = ADR, -Month)
        
        return(monthly_adr)
    })
    
    nps_Data <- reactive({
        #refresh data on Refresh button click
        input$refresh
        
        nps <- GSHEET_URL %>% 
            gs_url() %>% 
            gs_read(ws = "Historical_NPS")
        
        return(nps)
    })
    
    
    
  
    # Overview Value Boxes -------------------------------------------------
    
    output$npsBox <- renderValueBox({
        nps_now <- metrics_Data()$NPS
        
        valueBox(nps_now, "NPS", 
                 icon = icon("thumbs-up"),
                 color = ifelse(nps_now >= 50, "green", 
                                ifelse(nps_now > 0, "yellow", "red"))
        )
    })
    
    output$adrBox <- renderValueBox({
        adr_now <- metrics_Data()$ADR
        
        valueBox(paste(round(adr_now, 2), "$"),
                 subtitle = "ADR", 
                 icon = icon("diamond"),
                 color = "teal"
        )
    })
    
    output$occBox <- renderValueBox({
        occ_now <- metrics_Data()$Occupancy
        
        valueBox(paste(occ_now*100, "%"), 
                 subtitle = "Occupancy", 
                 icon = icon("bed"),
                 color = "maroon"
        )
    })
    
    output$nlocBox <- renderValueBox({
        nloc_now <- metrics_Data()$N_Loc
        
        valueBox(nloc_now, 
                 subtitle = "Locations", 
                 icon = icon("flag"),
                 color = "blue"
        )
    })
    
    output$rpBox <- renderValueBox({
        rp_now <- metrics_Data()$RevPAL
        
        valueBox(paste(round(rp_now, 2), "$"), 
                 subtitle = "Revenue per available location", 
                 icon = icon("dollar"),
                 color = "orange"
        )
    })
    
    output$arpBox <- renderValueBox({
        arp_now <- metrics_Data()$ARPAL
        
        valueBox(paste(round(arp_now, 2), "$"), 
                 subtitle = a("Adjusted RevPAL", href = "http://www.hospitalitynet.org/news/4066863.html"), 
                 icon = icon("random"),
                 color = "yellow"
        )
    })
    
    output$profitBox <- renderValueBox({
        profit_now <- metrics_Data()$Profit
        
        valueBox(paste(round(profit_now, 2), "$"), 
                 subtitle = "Profit", 
                 icon = icon("bank"),
                 color = "olive"
        )
    })
    
    
    # ADR body -------------------------------------------------------------
    output$adrPlot <- renderPlotly({
        adrplot <- ggplot(adr_Data(),
                          aes(x = factor(Month, levels = month.name),
                              y = ADR,
                              fill = Year)) +
            geom_bar(stat = "identity",
                     position = "dodge") +
            xlab("") +
            ylab("ADR [$]") +
            ggtitle("Average daily rate by month") +
            theme_classic() +
            theme(axis.text.x = element_text(angle = 45),
                  panel.margin.y = unit(5, "cm"))
        
        ggplotly(adrplot)
    })
    
    
    adr_ts <- reactive({
        adr_ts <- xts(adr_Data()$ADR,
                      order.by = as.yearmon(paste(adr_Data()$Year, adr_Data()$Month),
                                  format = "%Y %B")
                      )
        names(adr_ts) <- "ADR"
        return(adr_ts)
    })
        
    output$adrtsPlot <- renderDygraph({
        dygraph(adr_ts(), ylab = "ADR [$]")
    })
    
    output$adrtsTable <- DT::renderDataTable({
        DT::datatable(adr_Data(), filter = "bottom")
    })
    
    
    # NPS body -------------------------------------------------------------
    
    # NPS plot
    nps_ts <- reactive({
        nps_ts <- xts(nps_Data()$NPS, order.by = nps$Date)
        names(nps_ts) <- "NPS"
        return(nps_ts)
    })
    
    output$npsPlot <- renderDygraph({
        dygraph(nps_ts(), ylab = "NPS")
    })
    
    
    # NPS data table
    
    output$npsTable <- DT::renderDataTable(
        DT::datatable(nps_Data())
    )
    
    
    # Add NPS data
    updateNPS <- function(URL, date, nps){
        URL %>%
            gs_url() %>%
            gs_add_row(ws = "Historical_NPS", input = c(date, nps))
    }
    
    observeEvent(input$nps_submit,
        {updateNPS(GSHEET_URL, input$newNPS_date, input$newNPS_value)}
    )
    
    
    
})
