library(RQuantLib)

params <- list(
  tradeDate = as.Date("2004-09-20"),
  settleDate = as.Date("2004-09-22"),
  dt = .25,
  interpWhat = "discount",
  interpHow = "loglinear"
)
setEvaluationDate(as.Date("2004-09-20"))

tsQuotes <- list(
  d1w = 0.0382,
  d1m = 0.0372,
  fut1 = 96.2875,
  fut2 = 96.7875,
  fut3 = 96.9875,
  fut4 = 96.6875,
  fut5 = 96.4875,
  fut6 = 96.3875,
  fut7 = 96.2875,
  fut8 = 96.0875,
  s3y = 0.0398,
  s5y = 0.0443,
  s10y = 0.05165,
  s15y = 0.055175
)
times <- seq(0, 10, .1)

setEvaluationDate(params$tradeDate)
discountCurve <- DiscountCurve(params, tsQuotes, times)

bondparams <- list(
  faceAmount = 100, 
  issueDate = as.Date("2004-11-30"),
  maturityDate = as.Date("2008-11-30"),
  redemption = 100
)
dateparams <- list(
  settlementDays = 1,
  calendar = "UnitedStates/GovernmentBond",
  businessDayConvention = 4
)
ZeroCouponBond(bondparams, discountCurve, dateparams)

bond <- list(
  settlementDays = 1,
  issue.Date = as.Date("2004-11-30"),
  faceAmount = 100,
  dayCounter = "Thirty360",
  paymentConvention = "Unadjusted"
)
schedule <- list(
  effectiveDate = as.Date("2004-11-30"),
  maturityDate = as.Date("2008-11-30"),
  period = "Semiannual",
  calendar = "UnitedStates/GovernmentBond",
  businessDayConvention = "Unadjusted",
  dateGeneration = "Forward",
  endOfMonth = 1
)
calc <- list(
  dayCounter = "Actual360",
  compounding = "Compounded",
  freq = "Annual",
  durationType = "Modified"
)
rates <- c(0.02875)
FixedRateBond(bond, rates, schedule, calc, discountCurve = discountCurve)

yield <- 0.050517
FixedRateBond(bond, rates, schedule, calc, yield = yield)

price <- 92.167
FixedRateBond(bond, rates, schedule, calc, price = price)

bondparams <- list(
  faceAmount = 100, 
  issueDate = as.Date("2004-11-30"),
  maturityDate = as.Date("2008-11-30"),
  redemption = 100,
  effectiveDate = as.Date("2004-12-01")
)
dateparams <- list(
  settlementDays = 1,
  calendar = "UnitedStates/GovernmentBond",
  dayCounter = 1,
  period = 3,
  businessDayConvention = 1,
  terminationDateConvention = 1,
  dateGeneration = 0,
  endOfMonth = 0,
  fixingDays = 1
)

gearings <- spreads <- caps <- floors <- vector()

iborCurve <- DiscountCurve(
  params,
  list(flat = 0.05),
  times
)
ibor <- list(
  type = "USDLibor",
  lenght = 6,
  inTermOf = "Month",
  term = iborCurve
)
FloatingRateBond(
  bondparams,
  gearings,
  spreads,
  caps,
  floors,
  ibor,
  discountCurve,
  dateparams
)