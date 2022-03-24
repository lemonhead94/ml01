# Packages
library(dplyr)
library(quantmod)
# Directory
setwd("~/HSLU/FS 22/Machine learning/Groupwork/Data")

# Files
Inflation <- readxl::read_excel("Inflation_data.xlsx")
str(Inflation)
Landlocked_countries <- readxl::read_excel("Landlocked_Countries.xlsx")
str(Landlocked_countries)
Country_codes <- readxl::read_excel("Country_codes.xlsx")

# Landlocked Countries / Country Codes merge
Landlocked1 <- left_join(Landlocked_countries, Country_codes,
                        by = c("Country" = "Country or Area"))
Landlocked2 <- Landlocked1[,1:10]

# Constructing Master Data
# Filter Inflation data for years 2006 - now
md1 <- na.omit(Inflation[,1:7])
sum(is.na(md1))
md2 <- md1 %>% filter(TIME > 2005)
# Merge with Continents
colnames(Country_codes) <- c("Country", "ISO", "Region", "Continent")
md3 <- left_join(md2, Country_codes, 
                 by =c("LOCATION" = "ISO"))
# Add landlocked data
md4 <- left_join(md3, Landlocked2,
                 by = c("LOCATION" = "ISO-alpha3 Code"))
# Deleting not needed columns
md5 <- md4[ , !names(md4) %in% c("FREQUENCY", "Country.y", "Area_km2", 
                                        "Continent.x", "UN subregion",
                                        "Surrounding countries", "Count", 
                                        "Region 1", "Population")]
# Changing NA of Landlocked column
md5$Access_high_seas[is.na(md5$Access_high_seas)] <- "Access"

# Downloading Oil / Gas prices
data.frame(data <- NULL)
tickers_index <- c("CL=F", "NG=F")
for (Ticker in tickers_index){
  data <- cbind(data,
                getSymbols.yahoo(Ticker, from="2005-01-11", to = "2022-01-07", periodicity = "monthly", auto.assign=FALSE)[,6])
}

colnames(data) <- c("Crude Oil", "Natural Gas")
plot(data$`Crude Oil`)
plot(data$`Natural Gas`)
# yearly mean
data1 <- data[11:174,]
yearly_data <- matrix(nrow = 16, ncol = 3)
yearly_data[,3] <- NA
year = 2006
for (i in 1:16){
  yearly_data[i,3] <- year
  year = year + 1
}
colnames(yearly_data) <- c("Crude Oil", "Natural Gas", "Year")
for (i in 1:2){
yearly_data[1,i] <- mean(data1[1:10,i])
yearly_data[2,i] <- mean(data1[11:20,i])
yearly_data[3,i] <- mean(data1[21:32,i])
yearly_data[4,i] <- mean(data1[33:42,i])
yearly_data[5,i] <- mean(data1[43:54,i])
yearly_data[6,i] <- mean(data1[55:60,i])
yearly_data[7,i] <- mean(data1[61:71,i])
yearly_data[8,i] <- mean(data1[72:81,i])
yearly_data[9,i] <- mean(data1[82:92,i])
yearly_data[10,i] <- mean(data1[93:101,i])
yearly_data[11,i] <- mean(data1[102:112,i])
yearly_data[12,i] <- mean(data1[113:122,i])
yearly_data[13,i] <- mean(data1[123:131,i])
yearly_data[14,i] <- mean(data1[132:142,i])
yearly_data[15,i] <- mean(data1[143:151,i])
yearly_data[16,i] <- mean(data1[152:163,i])
}
ts1 <- ts(yearly_data[,1:2])
plot(ts1)

# Joining Master Data
yearly_data <- data.frame(yearly_data)
md6 <- left_join(md5, yearly_data,
                 by = c("TIME" = "Year"))
str(md6)
sum(is.na(md6)) # NA in Rows Country, Region, Continent for e.g. G7 / EU 27 etc.

#write excel

writexl::write_xlsx(md6, "Master_Data.xlsx")
