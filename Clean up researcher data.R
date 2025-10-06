library.func(c('dplyr'))

lc <- read.csv('~/NAU/Xanthe Stuff/LC-Sites.csv')
lcc <- read.csv('~/NAU/Xanthe Stuff/LCC_Site_Data_01292025.csv')
nwt <- read.csv('~/NAU/Xanthe Stuff/NWT_Site_Data_Walker.csv')
lc <- lc %>%
  mutate(
    Location = ifelse(Researcher == 'Walker', 
                       'Interior Alaska', 
                       lcc$StudyArea[lcc$Researcher %in% Researcher]),
    Location = case_when(
      Location == 'North-West Territory' ~ 'NWT',
      Location == 'Interior Alaska' ~ 'Alaska',
      Location == 'Newfoundland' ~ 'NL',
      Location == 'Alaska Tundra' ~ 'AK Tundra',
      TRUE ~ Location
    )
  )

nwt2 <- nwt[,c(1,9,10,2)]
colnames(nwt2)[4] <- 'Location'

lc2 <- rbind(lc,nwt2)

lc2 <- lc2 %>% 
  mutate(
    Researcher = case_when(
      Researcher == 'Dominique Arseneault' ~ 'Arseneault',
      Researcher == 'Gundale/Nilsson' ~ 'Gundale',
      Researcher == 'Kirsten Reid' ~ 'Brown',
      Researcher == 'Lucas Brehaut' ~ 'Brehaut',
      Researcher == 'Hung and Natali' ~ 'Hung-Natali',
      TRUE ~ Researcher
    ),
    Longitude = ifelse(Longitude > 0 & Location != 'Sweden', Longitude*-1, Longitude)
  ) %>% 
  arrange(Researcher)

write.csv(lc2, '~/NAU/Xanthe Stuff/LC-Sites2.csv', row.names = FALSE)
