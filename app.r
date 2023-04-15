# Load necessary libraries
library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  
  # Set up tabs
  tabsetPanel(
    tabPanel("Age distribution", 
             plotOutput("age_plot")),
    tabPanel("Gender distribution",
             plotOutput("gender_plot")),
    tabPanel("AJCC staging",
             plotOutput("ajcc_plot")),
    tabPanel("Tumor Location",
             plotOutput("tumor_plot")),
    tabPanel("Cancer Surgery and Survival",
             plotOutput("surgery_plot")),
    tabPanel("Overall Survival",
             tableOutput("survival_table"))
  )
)

# Define server logic
server <- function(input, output) {
  
  # Load data
  Clinical_Data1 <- read.csv("Copy of HEAD-NECK-RADIOMICS-HN1 Clinical data updated July 2020.csv")
  
  # Age distribution plot
  output$age_plot <- renderPlot({
    barplot(Clinical_Data1$age, main = "Age distribution", xlab = "Age", ylab = "Frequency")
  })
  
  # Gender distribution plot
  output$gender_plot <- renderPlot({
    pie(Clinical_Data1$gender, labels = Clinical_Data1$gender, main = "Gender distribution")
  })
  
  # AJCC staging plot
  output$ajcc_plot <- renderPlot({
    barplot(Clinical_Data1$ajcc, main = "AJCC staging", xlab = "Stage", ylab = "Frequency", names.arg = Clinical_Data1$ajcc, col = "purple")
  })
  
  # Tumor location boxplot
  output$tumor_plot <- renderPlot({
    ggplot(Clinical_Data1, aes(x = age_at_diagnosis, y = index_tumour_location)) +
      geom_boxplot(fill = "orange") +
      labs(x = "age", y = "tumor") +
      ggtitle("Highest Number of People for Tumor")
  })
  
  # Cancer surgery and survival boxplot
  output$surgery_plot <- renderPlot({
    ggplot(Clinical_Data1, aes(x = cancer_surgery_performed, y = event_overall_survival)) +
      geom_boxplot(fill = "blue") +
      labs(x = "Cancer Surgery Performed", y = "event_overall_survival") +
      ggtitle("Highest Number of People for Tumor")
  })
  
  # Overall survival table
  output$survival_table <- renderTable({
    table(Clinical_Data1$event_overall_survival)
  })
}

# Run the app
shinyApp(ui, server)
