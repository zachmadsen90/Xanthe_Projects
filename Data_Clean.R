library(dplyr)
dat <- read.csv('Xanthe Stuff/LCC_Site_Data_01292025.csv')
conifer <- c('spruce','pine')
conifer2 <- paste(conifer, collapse = '|')
deciduous <- c('aspen','birch','willow','shrub')
deciduous2 <- paste(deciduous, collapse = '|')
mix <- paste()
dat <- dat %>% 
  mutate(
    Veg_Type = case_when(
      grepl(conifer2, Eco_Type, ignore.case = TRUE) &
        grepl(deciduous2, Eco_Type, ignore.case = TRUE) ~ 'Mix',
      grepl(conifer2, Eco_Type, ignore.case = TRUE) ~ 'Conifer',
      grepl(deciduous2, Eco_Type, ignore.case = TRUE) ~ 'Deciduous',
      TRUE ~ 'Open'
    )
  )

write.csv(dat, 'Xanthe Stuff/LCC_Site_Data_01292025.csv')
