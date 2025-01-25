# Objects and functions
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

# Using packages
library(tidyverse)

# built in data sets
data()
View(starwars)

starwars %>% 
  filter(height > 150 & mass < 200) %>% 
  mutate(height_in_meters = height/100) %>% 
  select(height_in_meters, mass) %>% 
  # View()
  plot()

# Exploring the data
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

# Cleaning data
# Selecting variables
starwars %>% 
  select(name, height, mass)

starwars %>% 
  select(1:3)

starwars %>% 
  select(ends_with("color"))

# Changing variable order
starwars %>% 
  select(name, mass, height, everything())

# Renaming variables
starwars %>% 
  rename("character" = "name") %>% 
  View()

# Changing variable type
# variable type
class(starwars$hair_color)

starwars$hair_color <- as.factor(starwars$hair_color)
class(starwars$hair_color)

starwars %>% 
  mutate(hair_color = as.character(hair_color)) %>% 
  glimpse()

# Changing factor levels
df <- starwars

df$sex <- as.factor(df$sex)

levels(df$sex)

df <- df %>% 
  mutate(sex=factor(sex, levels=c("male", "female", "hermaphroditic", "none")))

levels(df$sex)

# Filter rows
starwars %>% 
  select(name, mass, sex) %>% 
  filter(mass < 55 & sex == "male")

# Re-code data
starwars %>% 
  select(sex) %>% 
  mutate(sex = recode(sex, "male" = "man", "female" = "woman"))

# Dealing with missing data
mean(starwars$height, na.rm=TRUE)

# Dealing with duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends = data.frame(Names, Age)  
friends

friends %>% 
  distinct()

distinct(friends)

# Create or change a variable
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m)

# Conditional change (if-else)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m) %>% 
  mutate(tallness = if_else(height_m < 1, 'short', 'tall'))

# Reshape data with pivot wider
library(gapminder)
View(gapminder)

data <- select(gapminder, country, year, lifeExp)
View(data)

wide_data <- data %>% 
  pivot_wider(names_from = year, values_from=lifeExp)
View(wide_data)

# Reshape data with pivot longer
long_data <- wide_data %>% 
  pivot_longer(2:13, names_to = 'year', values_to = 'lifeExp')
View(long_data)

# Describe
View(msleep)

# Range and Spread
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)

# Centrality
mean(msleep$awake)
median(msleep$awake)

# Variance and Standard Deviation
var(msleep$awake)
sd(msleep$awake)

summary(msleep$awake)

msleep %>% 
  select(awake, sleep_total) %>% 
  summary()

# Summarize
msleep %>% 
  drop_na(vore) %>% 
  group_by(vore) %>% 
  summarise(Minimum = min(sleep_total),
            Average = mean(sleep_total),
            Maximum = max(sleep_total),
            Range = max(sleep_total) - min(sleep_total)) %>% 
  arrange(Average) %>% 
  View()

# Create tables
table(msleep$vore)

msleep %>%
  select(vore, order) %>% 
  filter(order %in% c("Rodentia", "Primates")) %>% 
  table()

# Visualization

plot(pressure)

# Grammar of Graphics
  # data
  # mapping
  # geometry

# Bar Graph
ggplot(data = starwars,
       mapping = aes(x = gender)) + 
  geom_bar()

# Histogram
starwars %>% 
  drop_na(height) %>% 
  ggplot(aes(x = height)) +
  geom_histogram()

# Box Plot
starwars %>% 
  drop_na(height) %>% 
  ggplot(aes(x = height)) +
  geom_boxplot(fill = "steelblue") +
  theme_bw() + 
  labs(title = "Box Plot of Height",
       x = "Height of Characters")

# Density Plot
starwars %>% 
  drop_na(height) %>% 
  filter(sex %in% c("male", "female")) %>% 
  ggplot(aes(height, color = sex, fill = sex)) +
  geom_density(alpha = 0.2) +
  theme_bw()

# Scatter Plot
starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(x = height, y = mass, color = sex)) +
  geom_point(size = 5, alpha = 0.7) +
  theme_minimal() +
  labs(title = "Height and Mass by Sex")

# Scatter Plot
starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(x = height, y = mass, color = sex)) +
  geom_point(size = 5, alpha = 0.7) +
  geom_smooth() +
  facet_wrap(~sex) +
  theme_bw() +
  labs(title = "Height and Mass by Sex")
