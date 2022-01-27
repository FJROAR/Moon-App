library(shiny)
library(shinydashboard)
library(magick)
library(data.table)
library(dplyr)
library(DT)

#Se selecciona sólo objetos de cara visible
df <- fread('data/geo/moon_geografy.txt', sep = '|')

df_visible <- df[which(df$num_long >= -90 & df$num_long <= 90),]
