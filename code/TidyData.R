library(tidyverse)
library(ggplot2)

# tidy data ---------------------------------------------------------------


#1.  Each variable must have its own column.
#2.  Each observation must have its own row.
#3.  Each value must have its own cell.

table1 %>% 
  mutate(rate = cases/population*10000)

# count numbers of cases of each year
table1 %>%
  count(year, wt=cases)

ggplot(table1, mapping = aes(year, cases)) +
  geom_line(mapping = aes(group = country), col = 'grey50') +
  geom_point(aes(col = country))
  
#exercises 
#12.2.2
head(table2)

t2_cases <- filter(table2, type == "cases") %>%
  rename(cases = count) %>%
  arrange(country, year)
t2_population <- filter(table2, type == "population") %>%
  rename(population = count) %>%
  arrange(country, year)

#use merge would not keep the significant number of data
# and not tibble
t2_merge <- merge(t2_cases[-3], t2_population[-3], by=c('country', 'year')) %>%
  mutate(cases_per_cap = (signif((cases / population) * 10000, 3)) )%>%
  select(country, year, cases_per_cap)
t2_merge <- as_tibble(t2_merge)

# tibble the columns
t2_cases_per_cap <- tibble(
  year = t2_cases$year,
  country = t2_cases$country,
  cases = t2_cases$cases,
  population = t2_population$population
) %>%
  mutate(cases_per_cap = (cases / population) * 10000) %>%
  select(country, year, cases_per_cap)
# not totally the same
all.equal(t2_merge, t2_cases_per_cap)

# creat a type column and change the name of the cases_per_cap to count
t2_cases_per_cap <- t2_cases_per_cap %>%
  mutate(type = 'cases_per_cap')%>%
  rename(count = cases_per_cap)

# combine
bind_rows(table2, t2_cases_per_cap)%>%
  arrange(country, year, type, count)

#12.2.3
table2 %>%
  filter(type=='cases')%>%
  ggplot(aes(year,count))+
  geom_line(aes(group=country), col='grey50')+
  geom_point(aes(col=country))+
  #in the unique must be table2$year
  scale_x_continuous(breaks=unique(table2$year))+
  ylab('cases')



# Pivoting -------------------------------------------------

# wide table is with variable values as the column names
# long table is with variable names as the column names

# key is the category variables want to stack
# value is the column name of the quantative data
table4a <- table4a %>%
  gather('1999','2000', key = 'year', value = 'cases')

tidy4b <- table4b %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")
# combine table 4a and 4b
left_join(table4a, tidy4b)

# spread
tidy2 <- table2%>% 
  spread(key=type, value = count)

## exercise 
# 12.3.1
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
# use spread() the class of column would be changed to character.
# and it would not be changed back to number after gather()
# convert = T would help, but not accurate. 

#12.3.2
#use (c(3,4))

#12.3.3
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
# there are two age for the one name
people%>%spread(key, value)

# add a column named 'obs' which is order of the each group
people2 <- people%>% 
  group_by(name, key)%>%
  mutate(obs = row_number())
# this makes two identical row in people different in people 2 with different 
# obs vales
spread(people2, key, value)

# 12.3.4
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
preg_tidy <- preg %>% 
  gather(male, female, key = 'sex', value='count')

# remove the NA row
preg_tidy2 <- preg %>% 
  gather(male, female, key = 'sex', value='count', na.rm=T)

# to store the data in a logical value
preg_tide3 <-  preg_tidy2 %>% 
  mutate(female = sex== 'female',
         pregnant = pregnant =='yes')%>%
  select(female, pregnant, count)




# Sperating and uniting ---------------------------------------------------

table3_sep <- table3%>%
  separate(rate, into = c('cases','poplation'))
# sperate() would keep the type of the column seperated
# convert = TRUE can be used to get better type of the new column
table3_sep_int <- table3%>%
  separate(rate, into = c('cases','poplation'), convert=T)

# seperate a vector with the position using sep=n
# positive from left side
#negative from the right side
table3_sep_cha <- table3 %>% 
  separate(year, into = c('century','year'), sep =2)
