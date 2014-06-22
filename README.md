# Shiny app simulating retirement cash-flow scenarios

For a direct access to this Shiny application, click [here](http://lincrampton.shinyapps.io/time2retire/)

This README file is the supporting documentation accompagning this Shiny application. It includes three parts: 

1. Instructions given for this project
2. Description of this Shiny application
3. Directives on how to visualize this Shiny application

### 1. Instructions given for this project

1. Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application. 
2. Deploy the application on Rstudio's shiny server.
3. Share the application link by pasting it into the text box below. 
4. Share your server.R and ui.R code on github. 

The application must include the following:

1. Some form of input (widget: textbox, radio button, checkbox, ...).
2. Some operation on the ui input in sever.R.
3. Some reactive output displayed as a result of server calculations.
4. You must also include enough documentation so that a novice user could use your application.
5. The documentation should be at the Shiny website itself. Do not post to an external link.

The Shiny application in question is entirely up to you. However, if you're having trouble coming up with ideas, you could start from the simple prediction algorithm done in class and build a new algorithm on one of the R datasets packages. Please make the package simple for the end user, so that they don't need a lot of your prerequisite knowledge to evaluate your application. You should emphasize a simple project given the short time frame.  

### 2. Description of this Shiny application

This Shiny application ('time2retire') acquires input values from the user to calculate simulations for a variety of retirement scenarios.   My motivation to work on this app was a visit to a financial planner, who, based on a number of inputs came up with a single curve on a graph representing resources during retirement.  With these same inputs, time2retire outputs a number of linegraphs representing scenarios impacted by random fluctuations in interest rate, inflation rate, volatility.  Try the app and you can see that the same inputs can result in a vastly different scenarios over time.  

time2retire contains 18 sliders controlling the values:
  age.now             current age in years
  years.wait          number of years before beginning retirement
  n.obs               length of projection (time period observing)
  n.sims              number of simulations
  social.security     monthly social security income
  ss.start            age to start collecting social security payments
  annual.inflation    impact of inflation
  annual.inf.std.dev  fluctuations in inflation
  liquid.n401Ks       assets available
  total.pension       pension lump sum distribution
  number.increments   number of pension distributions
  capital.contribs    annual pre-retirement contributions to pot of money 
  years.contributing  number of years adding to the pot
  annual.mean.return  investment return percentage
  annual.ret.std.dev  volatility in investment return percentage 
  annual.inflation    projected inflation
  annual.inf.std.dev  volatiity in projected inflation
  monthly.withdrawals capital withdrawals, dollars per month 


DISCLAIMER:  I did not write the original app.  The idea and original code is by Pierre Chretien, updated by Michael Kapler.  I expanded their concept of using matrices populated with random numbers to generate multiple simulations comprising capital inputs/outputs, and random fluctuations in inflation, interest, etc.   
DISCLAIMER:  I am not a financial planner, financial adivsor, or financial wizard.  Do not make financial decisions based on the information provided by this app.


This Shiny application displays a series of line graphs illustrating various financial scenarios for retirement, based on capital assets and expenditures, impact of projected inflation/interest and fluctuations thereof.  It might be nice to expand this program so that it is responsive in the graphing area, to be able to add points of capital outlays/inputs by clicking on the plot of linegraphs


### 3. Directives on how to visualize this Shiny application

Option 1: Direct link: click [here](http://lincrampton.shinyapps.io/time2retire/)

Option 2: Download the `server.R` and `ui.R` files and place them in a directory named 'time2retire'. Open an R session and set the working directory to the folder that contains the directory 'time2retire'. Then run the following commands:

```
library(shiny)
runApp('time2retire')
```
