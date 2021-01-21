library(shiny)
library(plotly)
library(tidyverse)


# Define UI for application
ui <- fluidPage(

    # Application title
    titlePanel("Advertising Analytics"),

    
    fluidRow(
        # First metric input
        column(12,
            selectInput("cum_metric", h3("Metric"), 
                        choices = list("Total Conversions" = "total_conversions",
                                       "Total Impressions" = "total_impressions",
                                       "Total Publisher Split" = "total_cost",
                                       "Total Conversion Value" = "total_conversion_rev",
                                       "Conversion Value per mille" = "rev_per_1000_impression",
                                       "Publisher Split per mille" = "cost_per_1000_impression"
                        ), selected = 1)
            
        ),
        # Time series metric plot
        column(12,
               plotlyOutput("TSmetric"),
        hr()),
        
        fluidRow(
            # Second metric input
            column(6, 
            selectInput("device_metric", h3("Metric"), 
                        choices = list("Total Conversions" = "total_conversions",
                                       "Total Impressions" = "total_impressions",
                                       "Total Publisher Split" = "total_cost",
                                       "Total Conversion Value" = "total_conversion_rev",
                                       "Conversion Value per mille" = "rev_per_1000_impression",
                                       "Publisher Split per mille" = "cost_per_1000_impression"
                        ), selected = 1)),
            # Device selection
            column(6,
                   selectizeInput(inputId = "device", label=h3("Device"), choices = c("Desktop", "Tablet", "Mobile"),
                                  multiple=TRUE, selected=c("Desktop", "Tablet", "Mobile") ))
        ),
        
            # Device time series plot
        column(12,
               plotlyOutput("device_plot"),
               hr()),
        
        fluidRow(
            column(6,
                # Best Creative Id plot
                   plotlyOutput('creative_plot')),
            
                # Best Ad Unit Id plot
            column(6,
                   plotlyOutput('ad_unit_plot'),
                   br())
        )
    )
)

# Define server logic
server <- function(input, output) {
    
    # Read in dataframes
    metric_df<- read.csv('cum_table.csv')
    device_df <- read.csv('device.csv')
    ad_unit_df <- read.csv('ad_unit.csv')
    creative_df <- read.csv('creative_table.csv')
    
    # Convert date column to Date objects
    metric_df$date <- as.Date(metric_df$date)
    device_df$date <- as.Date(device_df$date)
    
    # List of full metric names
    full_metric_name <- c("Total Conversions",
    "Total Impressions",
    "Total Publisher Split",
    "Total Conversion Value",
    "Conversion Value per mille",
    "Publisher Split per mille")
    
    # Dataframe that connects column names to full metric names
    full_names <- data.frame(row.names = c("total_conversions", "total_impressions", "total_cost", 
                                           "total_conversion_rev", "rev_per_1000_impression",
                                           "cost_per_1000_impression"),
                             "Name" = full_metric_name)

    # Creating first plotly time series graph
    output$TSmetric <- renderPlotly({
        date <- metric_df$date
        metric <- metric_df[,c(input$cum_metric)]
        name <- full_names[c(input$cum_metric),]
        
        fig <- plot_ly(x = date, 
                       y = metric,type="scatter",
                       mode = "lines")
        fig %>% 
            layout(xaxis = list(title=""), yaxis = list(title = name)) %>% 
            config(displayModeBar = F)
        
        
    })
    
    # Creating second plotly time series graph
    output$device_plot <- renderPlotly({
        device_data <- subset(device_df, device %in% input$device)
        date <- device_data$date
        metric <- device_data[,c(input$device_metric)]
        device <- device_data$device
        name <- full_names[c(input$device_metric),]

        fig <- plot_ly(x =date, y=metric, color=device,
                type="scatter", mode="line")
        fig %>% 
            layout(xaxis = list(title=""), yaxis = list(title = name)) %>% 
            config(displayModeBar = F)
        
    })
    
    # Creating bar chart of best creative ids
    output$creative_plot <- renderPlotly({
        fig <- plot_ly( data = creative_df , x = ~rev_per_1000_impression, 
                 y = ~reorder(creative_id,rev_per_1000_impression),
                 type="bar", orientation= "h") %>% 
            layout(title = "Best Performing Creative Ids",
                   xaxis = list(title = "Conversion Value per mille ($)"),
                   yaxis = list(title = "Creative Id")) %>% 
            config(displayModeBar = F)
        
        
    })
    
    # Creating bar chart of best ad unit ids
    output$ad_unit_plot <- renderPlotly({
        fig <- plot_ly( data = ad_unit_df , x = ~rev_per_1000_impression, 
                        y = ~reorder(ad_unit_id,rev_per_1000_impression),
                        type="bar", orientation= "h") %>% 
            layout(title = "Best Performing Ad Unit Ids",
                   xaxis = list(title = "Conversion Value per mille ($)"),
                   yaxis = list(title = "Ad Unit Id")) %>% 
            config(displayModeBar = F)
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
