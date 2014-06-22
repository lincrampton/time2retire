library(shiny)
#
# Idea and original code by Pierre Chretien
# Small updates by Michael Kapler 
# More mods by Lin Crampton
#

shinyServer(function(input, output) {
  projectRetirement <- reactive({ 
	yearsObserving = input$n.obs # what period of time do we want to look at?
	monthsObserving = 12 * yearsObserving

	ageNow = input$age.now
	delayYears = input$years.wait
	retireAgeYears = ageNow + delayYears
	ageMonths= ageNow * 12
	retireAgeMonths = retireAgeYears * 12

	numSims = input$n.sim # how many simulations do we want to perform?

	liquidN401Ks = input$liquid.n401Ks

	totalPension = input$total.pension
	numPensionPayouts = input$number.increments
	pensionPayout = totalPension/numPensionPayouts

	# PENSION MATRIX
	if ( (numPensionPayouts > 0) & (totalPension > 0) ) {
		pensionMatrix = matrix(0,1,numSims) #matrix w bogus row1
		for (j in 1:numPensionPayouts) {
			pensionMatrixTmp = matrix(j*pensionPayout, monthsObserving/numPensionPayouts, numSims) 
			pensionMatrix = rbind(pensionMatrix,pensionMatrixTmp)
		}
		if (monthsObserving %% numPensionPayouts != 0) { #to avoid having pension drop out at end due to modulo
			pensionMatrixTmp = matrix(numPensionPayouts*pensionPayout, monthsObserving %% numPensionPayouts, numSims)
			pensionMatrix = rbind(pensionMatrix, pensionMatrixTmp)
		} 
		pensionMatrix = pensionMatrix[-(1),]  #remove bogus row1
	}	else { # no pension
			pensionMatrix = matrix(0,monthsObserving, numSims)
	}
	
	monthlyWithdrawals = input$monthly.withdrawals
	
	ageSeq = seq(from=ageMonths, by=1, length.out=monthsObserving)
	ageVec = matrix(ageSeq)
	ageVecYears = ageVec/12

	ssAmount = input$social.security
	ssStartYear = input$social.security.start
	ssStartMonth = ssStartYear * 12
	ssStartDelta =  ssStartMonth - ageMonths
	if (ssStartDelta < 0 ) { ssStartDelta = 0 } # not dealing with negative time
	ssMatrixA = matrix(0, ssStartDelta, numSims)  # two matrices - one before SS starts
	ssMatrixB = matrix(ssAmount, (monthsObserving-ssStartDelta), numSims)  # one matrix for social security time
	ssMatrix = rbind(ssMatrixA, ssMatrixB)

	yearlyCapitalContribs = input$capital.contribs
	yearsContributing2capital = input$years.contributing

	if ( (yearlyCapitalContribs > 0) & (yearsContributing2capital > 0) ) { #assuming that capital contribution time finite
		monthlyCapitalContribs = yearlyCapitalContribs / 12
		monthsContributing2capital = yearsContributing2capital * 12
		capitalContribMatrixA = matrix(monthlyCapitalContribs, monthsContributing2capital, numSims) 
		capitalContribMatrixB = matrix(0, (monthsObserving-monthsContributing2capital), numSims) 
		capitalContribMatrix = rbind(capitalContribMatrixA, capitalContribMatrixB)
	} else {
		capitalContribMatrix = matrix(0, monthsObserving, numSims)
	}

	startCapital = pensionMatrix + liquidN401Ks + ssMatrix + capitalContribMatrix

	# monthly Investment and Inflation assumptions
	annualMeanReturn = input$annual.mean.return/100
	monthlyReturnMean = annualMeanReturn / 12
	annualReturnStdDev = input$annual.ret.std.dev/100
	monthlyReturnStdDev = annualReturnStdDev / sqrt(12)
	# simulate Returns
	investReturnsMatrix = matrix(0, monthsObserving, numSims)
	investReturnsMatrix[] = rnorm(monthsObserving * numSims, mean = monthlyReturnMean, sd = monthlyReturnStdDev)
	
	annualInflation = input$annual.inflation/100
	monthlyInflation = annualInflation / 12
	annualInflationStdDev = input$annual.inf.std.dev/100
	monthlyInflationStdDev = annualInflationStdDev / sqrt(12)
	# simulate effect of inflation
	inflationMatrix = matrix(0, monthsObserving, numSims)
	inflationMatrix[] = rnorm(monthsObserving * numSims, mean = monthlyInflation, sd = monthlyInflationStdDev)

	nav = startCapital
	
	for (j in 1:(monthsObserving-1)) {
		startCapital[j + 1, ] = startCapital[j, ] * (1 + investReturnsMatrix[j, ] - inflationMatrix[j, ]) - monthlyWithdrawals
		#nav[j , ] = nav[j , ] + startCapital/input$number.increments 
	}	
	#nav = nav[-(monthsObserving+1) , ] # remove that last row we added in
	#for (j in 1:input$number.increments*12) {
		#if (j %% 12 == 0) {
		#}
	#}	
	
	startCapital[ startCapital < 0 ] = NA # once nav is below 0 => run out of money
	Retirement = startCapital / 1000000 # convert to millions
	Retirement=cbind(ageVecYears,Retirement)
	#output$documentationText = renderText({"Adjust the slider bars to reflect the retirement scenario you wish to simulate."})
	output$documentationText = renderText({'... projecting retirement assets over time ...\n'})
	output$sourceText = renderText({"Idea and original code by Pierre Chretien, updated by Michael Kapler, and then Lin Crampton. Source at https://github.com/lincrampton/time2retire. Comments/complaints to lin.crampton@gmail.com"})
	return(Retirement)
  })
  
  output$distPlot <- renderPlot({
	Retirement = projectRetirement()
	layout(matrix(c(1,2,1,3),2,2))
	matplot(Retirement[ , 1], Retirement[ , -1 ], type = 'l', las = 1, ylab='Millions', xlab='Age')
  })
		
})

