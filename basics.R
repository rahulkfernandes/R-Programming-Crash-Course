5 + 6

a <- 5
b <- 6

a + b

sum(a, b)


ages <- c(5, 6)
ages
sum(ages)

names <- c("John", "James")

friends <- data.frame(names, ages)

View(friends)
str(friends)

friends$ages
friends$names

friends[1,1]
friends[1,]
friends[,1]

library(tidyverse)
data()
View(starwars)

starwars %>% 
  filter(height > 150 & mass < 200) %>% 
  mutate(height_in_meters = height/100) %>% 
  select(height_in_meters, mass) %>% 
  # View()
  plot()


View(msleep)

glimpse(msleep)

head(msleep)
tail(msleep)

class(msleep$name)

length(msleep)

length(msleep$name)

names(msleep)

unique(msleep$vore)

missing <- !complete.cases(msleep)
msleep[missing,]

