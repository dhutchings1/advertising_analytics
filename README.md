# Advertising Analytics Project

Advertising Analytics Dashboard: https://dhutchings.shinyapps.io/advertising_analytics/

## Overview
This project was designed to explore advertising data and create value adding recommendations and observations. I stored the data in Google BigQuery so that I could perform fast and efficient queries of the roughly 400,000 rows. To assist in my data analysis, I built an advertising analytics dashboard using R Shiny, which provided me with a great starting point to examine the data. I then built a regression model to evaluate how the different devices the ads ran on impacted conversions. My recommendations and observations are based on a combination of the dashboard and regression results. 

sql.ipynb - sql queries that were used to create the data tables used in the advertising analytics dashboard
advertising_regression.ipynb - regression results
advertising_analytics_shiny_app - folder that contains the contents of R Shiny app

## Recommendations

### 1. Desktop ads
Desktop ads performed well according to several metrics. The advertising analytics dashboard shows that Desktop ads consistently had higher conversion value per mille scores than other devices, meaning that they produce more value to the advertiser per 1000 impressions. Additionally, my regression results found that Desktop impressions had the greatest impact on increasing daily conversions compared to other devices. My hypothesis for why Desktop ads are better for generating conversions is that it is easier to buy items on a computer compared to a phone or tablet. More knowledge about the product would likely reinforce this hypothesis. Overall, I would recommend publishing more Desktop ads in the future.

### 2. Creative Ids: 13, 55, 16, 15, 54
The advertising analytics dashboard shows that these are the best performing creative ids in terms of conversion value per mille. Without knowing more about these creative ids, it is hard to explain why they were successful. I would recommend publishing more ads with these creative ids in the future.

### 3. Ad Unit Id: 532
Ad unit id 532 had a shockingly high conversion value per mille value of $400, which made it a successful outlier. I looked deeper into that specific ad unit and found that it ran on 1/30 and 1/31 and had only 2 total conversions and 325 impressions. Additionally, I noticed that ad unit id 532 was expensive. I calculated the ratio of impressions over publisher split to give an indication of how many impressions the ad got per $1 paid to the publisher. On average, ad unit id 532 had a ratio of 97, which was significantly less than the average of the complete dataset, which was 1,066. My hypothesis is that this was a high quality ad unit, which explains why it had a high conversion value per mille value. I would recommend using this ad unit in the future.

## Observations

### Desktop ads cost more than other devices
This didn't surprise me given that Desktop ads deliver more conversion value per mille.

### Ad spending increased in January
I observed a sharp increase in daily impressions and publisher split costs in mid to late January.

### Local peak in daily conversions around black friday (11/26 - 11/29)
This is expected because the advertised product was likely hosting sales around that time
