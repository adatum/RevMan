library(shiny)
library(shinydashboard)
library(googlesheets)
library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(zoo)
library(xts)
library(dygraphs)
library(DT)

# Google Sheet URL (make sure it is "published to the web")
GSHEET_URL <- "https://docs.google.com/spreadsheets/d/1LySNMsSKJhahSGK81gq_CY7t1glGU6E8TJWppFZMdLk/edit?usp=sharing"

# Read only URL:
#GSHEET_URL <- "https://docs.google.com/spreadsheets/d/1LySNMsSKJhahSGK81gq_CY7t1glGU6E8TJWppFZMdLk/pubhtml"


# # NPS time series
# nps <- GSHEET_URL %>% 
#     gs_url() %>% 
#     gs_read(ws = "Historical_NPS")
# 
# nps_ts <- xts(nps$NPS, order.by = nps$Date)
# 
# dygraph(nps_ts)

