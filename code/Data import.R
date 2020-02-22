library(tidyverse)

# Names -------------------------------------------------------------------


#read_csv2() for semicolon
#read_fwf() for fixed width file
#read_delim() for  any delimiters
#read_tsv() for any tab seperated 
# _csv not .csv, produces tibbles

#the first row would be column names
# colnames = FALSE to skip it
# or col_names = c()
read_csv('x,y,z
         1,2,3')

a <- read_csv("x,y\n1,\"a,b\"")

read_csv("a;b\n1;3")
read_csv("a,b\n\"1")


# parsing a vectcor -------------------------------------------------------

parse_logical()
parse_integar()
parse_data()

parse_integer(c("1", "231", ".", "456"), na = ".")

x <- parse_integer(c("123", "345", "abc", "123.45"))
x #missing 
problems(x) #return a tibble
parse_number()
parse_double()
#get the coding 
chartoRaw()# a raw factor
guess_encoding(chartoRaw())
parse_datetime() #time
d1 <- "January 1, 2010"

parse_date(d1, "%B %d, %Y")


# parsing a file ----------------------------------------------------------
challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
tail(challenge)
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)


challenge2 <- read_csv(readr_example("challenge.csv"), 
                       col_types = cols(.default = col_character())
)


df <- tribble(
  ~x,  ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
type_convert(df) from character to numeric


)
