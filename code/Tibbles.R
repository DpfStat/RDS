#vignette('tibble')
library(tidyverse)
library(ggplot2)

# tibble ------------------------------------------------------------------

tibble(x= 1:5,
       y= 1,
       z= x^2+y)

# the name can start with symbols
tb <- tibble(
  ':)' = 'smile',
  ' ' = 'space',
  '2000' = 'number'
)

# tribble :transposed tibble
# good for small data sets
tribble(
  ~x, ~y, ~z,
  #--|--|--|
  "a", 2, 3.6,
  "b", 1, 8.5
)

# tibble vs. data frame -----------------------------------------------------------------
##print
# tibble shows str() for each column
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

# options(tibble.print_max = n, tibble.print_min = m): 
#if more than n rows, print only m rows
  
#options(tibble.print_min = Inf) to always show all rows

## subsetting
df <- tibble(
  x=runif(5),
  y=rnorm(5)
  )
df$x
df$y
# [['x']] is for name as df$x
df[['x']]
# by position
df[[1]]
# df[1] wil return a column not only the number inside

# in pipe, add '.' in front of names
df %>% .[[1]]

# as.data.frame (tb) returns data frame


# exercise ---------------------------------------------------------------
#2 
df <- data.frame(abc = 1, xyz = "a")
df$x #data fram can return the matched xyz for x, partial matching
df[, "xyz"]
df[, c("abc", "xyz")]

df.tb <- as.tibble(df)
df.tb$x
df.tb[, "xyz"]
df.tb[, c("abc", "xyz")]

#4
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying[[1]] #only number
annoying[,1] #column 
# refer the special names with backticks ``
ggplot(annoying, aes(x= `2`, y= `1`)) +
  geom_point()

annoying$`3` <- annoying$`2`/2
colnames(annoying) <- c('one','two', 'three')
