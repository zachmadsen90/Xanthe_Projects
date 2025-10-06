library(dplyr)
dat.1 <- read.csv('~/NAU/Xanthe Stuff/LC_Plot_Final_01292025.csv')
dat.2 <- read.csv('~/NAU/Helicopter/Planning/Coordinates/CCE-Sites-Wildfire.csv')
dat.3 <- read.csv('~/NAU/Xanthe Stuff/cce_site.csv')

length(unique(dat.1$fire)) #31
length(unique(dat.1$site)) #169
length(unique(dat.2$FireScar)) #8
length(unique(dat.3.filt$FireScar))#9

dat.3.filt <- dat.3 %>% 
  filter(!fire_scar %in% dat.2$FireScar) %>% 
  rename(Latitude = latitude.1,
         Longitude = longitude.1,
         FireScar = fire_scar) %>% 
  select(FireScar, Latitude, Longitude)
#Summarize
dat.1.sum <- dat.1 %>% 
  group_by(fire, site) %>% 
  summarise(
    latitude = mean(latitude),
    longitude = mean(longitude)
  ) %>% 
  ungroup() %>% 
  rename(FireScar = fire,
         Latitude = latitude,
         Longitude = longitude) %>% 
  select(-site)

dat.2.sum <- dat.2 %>% 
 select(FireScar, Latitude, Longitude)

dat.3.sum <- dat.3.filt %>% 
  select(FireScar, Latitude, Longitude)
dat.merge <- rbind(dat.1.sum, dat.2.sum, dat.3.sum)

write.csv(dat.merge, '~/NAU/Xanthe Stuff/Combined_LC_CCE_Site.csv', row.names = FALSE)
