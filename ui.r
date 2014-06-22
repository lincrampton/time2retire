library(shiny)
# Define UI for application that plots random distributions 
shinyUI(fluidPage( #have two open parens
  # Application title
  titlePanel("Will I Go Broke During Retirement?"), #complete
sidebarLayout(position="right",
	sidebarPanel(
		helpText('(adjust slider bars to simulate a retirement scenario)\n'),
		#helpText('......      projecting retirement assets over time ......\n'),
		sliderInput("age.now", "Current Age:", min = 55, max = 110, value = 59),
		sliderInput("years.wait", "Years Until Retirement:", min = 0, max = 40, value = 0),
		sliderInput("n.obs", "Length of Projection (years):", min = 0, max = 40, value = 20),
		sliderInput("social.security", "Social Security Payment:", min = 0, max = 50000, value = 1000, step = 100, format="$#,##0", locale="us",),
		sliderInput("social.security.start", "Social Security Start Age:", min = 67.5, max = 72.0, value = 67.5, step = 0.5),
		sliderInput("liquid.n401Ks", "Liquid Assets and 401Ks:", min =   000000, max =   3000000, value = 500000, step =  10000, format="$#,##0", locale="us"),
		sliderInput("total.pension", "Pension Lump Sum:", min = 1000000, max = 3500000, value = 2000000, step = 100000, format="$#,##0", locale="us"),
		sliderInput("number.increments", "Pension Amortized Over (# payments):", min = 1, max = 10, value = 1),
		sliderInput("capital.contribs", "Continuing Capital Contributions (annual):", min = 0.0, max = 50000.0, value = 1000.0, step = 1000, format="$#,##0", locale="us"),
		sliderInput("years.contributing", "Years Continuing to Contribute to Capital:", min = 0, max = 20.0, value = 2.0, step = 1),
		sliderInput("annual.mean.return", "Investment Return (annual %):", min = 0.0, max = 30.0, value = 5.0, step = 0.5),
		sliderInput("annual.ret.std.dev", "Investment Volatility (annual %):", min = 0.0, max = 25.0, value = 7.0, step = 0.1), 
		sliderInput("annual.inflation", "Inflation (annual %):", min = 0, max = 20, value = 2.5, step = 0.1),
		sliderInput("annual.inf.std.dev", "Inflation Volatility (annual %):", min = 0.0, max = 5.0, value = 1.5, step = 0.05),
		sliderInput("monthly.withdrawals", "Monthly Capital Withdrawals:", min = 0, max = 100000, value = 10000, step = 1000, format="$#,##0", locale="us",),
		sliderInput("n.sim", "Number of Simulations:", min = 0, max = 2000, value = 200),
		helpText("Idea and original code by Pierre Chretien, updated by Michael Kapler, and then Lin Crampton. Source at https://github.com/lincrampton/time2retire. Comments/complaints to lin.crampton@gmail.com") 
	), #sidebarPanel

	mainPanel( 
		textOutput('documentationText'),
		plotOutput("distPlot", height = "2200px")
		) #mainPanel
) #sidebarLayout
) #fluidPage
) #shinyUI
