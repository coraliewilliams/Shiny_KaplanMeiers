# Install packages
install.packages("shiny"); install.packages("ggplot2"); install.packages("dplyr")
install.packages("survminer"); install.packages("survival")

# Load library
library(shiny);library(ggplot2);library(dplyr);library(survminer);library(survival); library(httr)

# Load data
### check data source
### baz3 <- read.csv2("https://raw.githubusercontent.com/opetchey/RREEBES/master/Beninca_etal_2008_Nature/data/nutrients_original.csv",sep = ",")
baz4 <- baz3[baz3$date==baz3$timepoint+baz3$date.bl,]
baz5 <- baz4 %>%
  select("SLC5A7_p.I89V_MODERATE","chgt", "timepoint","PTGENDER","SIGMAR1_p.Q2P_MODERATE","ABCA7_p.G215S_MODERATE","bl")


# Create Shiny UI
shinyUI(navbarPage("Diagnostic change Analysis",
                   tabPanel( "Kaplan-Meier graphic",
                             sidebarLayout(
                               sidebarPanel(
                                 h3("Diagnostic change Graph"),
                                 selectInput('sur_var', 'Factor of Survival',names(baz5)[names(baz5) != "timepoint" & names(baz5) != "chgt"])
                                 # sliderInput('xvalue', 'Survival Days = ',value=1000, min=1, max=max(baz5$timepoint)) ## Added a table to give the probability of diagnostic change for each class at a given time
                                 )  
                               ,
                               mainPanel(
                                 h3(textOutput("caption")),plotOutput("plot1")
                                 , tableOutput("center")
                               )
                             )
                   )
))
