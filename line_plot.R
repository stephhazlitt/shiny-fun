## load libraries

library(ggplot2)
library(ggvis)

## load open data (BCOGL)
data <- read.csv("http://www.env.gov.bc.ca/soe/archive/data/plants-and-animals/2012_Vert_Species_Status/Conservation_status_index_vertebrates_1992-2012.csv")

## create plot theme
chart_theme <- theme(
  axis.line = element_line(colour="black"),
  axis.ticks = element_blank(),
  plot.title = element_text(size = 12, vjust=2),
  legend.title = element_text(size = 12, face="plain"),
  legend.text = element_text(size = 10),
  panel.background = element_rect(fill="white"),
  panel.grid.minor = element_blank(),
  panel.grid.major = element_line(colour = "grey80",size=0.5)
)

theme_set(theme_grey() + chart_theme)  

## ggplot2 version line graph
lineplot <- ggplot(data=data, aes(x = Year, y = Index_Value, colour = Taxonomic_Group)) + 
  geom_line() + geom_point()
plot(lineplot)

## ggvis version line graph

data$id <- 1:nrow(data) #Create the ID column.

text <- function(x) {
  if(is.null(x)) return(NULL)
  row <- data[data$id == x$id, "Exposition"]

}

data %>% ggvis(~Year, ~Index_Value) %>%
  layer_points(fill = ~Taxonomic_Group, key :=~id) %>% 
  add_tooltip(text, "hover") %>%
  group_by(Taxonomic_Group) %>%
  layer_lines(stroke = ~Taxonomic_Group) %>%
  add_axis("x", title="Assessment Year",  format="####") %>%
  add_axis("y", title="Conservation Status Index")


#  input_checkboxgroup(choices = c("Breeding Birds" = , "Freshwater Fish", "Mammals", "Reptiles and Amphibians"),
#                    label = "Taxonomic Group")
  

