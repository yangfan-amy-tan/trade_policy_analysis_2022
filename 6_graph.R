# import Final_dva_gtrade.dta
library(haven)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(reshape2)

setwd <- ("C:/Users/gerod/Desktop/EGEI Master/Trade Policy Analysis/Vurchio/Assignment/Report/data")

data <- read_dta('Final_dva_gtrade.dta')

# 1. Count the RTAs grouped by year

cu <-
  dplyr::filter(data, cu == 1)

CU <- cu %>% 
  group_by(year) %>% 
  summarise(CU = sum(cu), .groups = "drop") 


fta <- 
  dplyr::filter(data, fta == 1)

FTA <- fta %>% 
  group_by(year) %>% 
  summarise(FTA = sum(fta), .groups = "drop") 


psa <- 
  dplyr::filter(data, psa == 1)

PSA <- psa %>% 
  group_by(year) %>% 
  summarise(PSA = sum(psa), .groups = "drop") 


eia <- 
  dplyr::filter(data, eia == 1)

EIA <- eia %>% 
  group_by(year) %>% 
  summarise(EIA = sum(eia), .groups = "drop") 


cueia <- 
  dplyr::filter(data, cueia == 1)

CUEIA <- cueia %>% 
  group_by(year) %>% 
  summarise(CUEIA = sum(cueia), .groups = "drop")


ftaeia <- 
  dplyr::filter(data, ftaeia == 1)

FTAEIA <- ftaeia %>% 
  group_by(year) %>% 
  summarise(FTAEIA = sum(ftaeia), .groups = "drop") 


psaeia <- 
  dplyr::filter(data, psaeia == 1)

PSAEIA <- psaeia %>% 
  group_by(year) %>% 
  summarise(PSAEIA = sum(psaeia), .groups = "drop") 



# 2. Merge dataframes 

merged <- print(list(CU, FTA, PSA, EIA, 
                     CUEIA, FTAEIA, PSAEIA) %>% 
                  reduce(full_join, by='year'))


# 3. Convert from wide to long format

data_long <- melt(merged, id.var=c("year"),
                  measure.vars=c("CU", "FTA", "PSA", "EIA", 
                     "CUEIA", "FTAEIA", "PSAEIA"),
                  variable.name="rta",
                  value.name="pairs")


# 4. Make a plot

plot1a <-
  ggplot(data=data_long, aes(fill=rta, y=pairs, x=year)) + 
           geom_bar(position="stack", stat="identity")
    ggtitle("") +
    geom_col(fill = "blue") +

    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    xlab("Year") +
    ylab("Number of Bilateral Pairs")
    

plot1a +labs(title="",
             x ="Years", y = "Number of Bilateral Country Pairs", 
             fill = "RTA Type")








