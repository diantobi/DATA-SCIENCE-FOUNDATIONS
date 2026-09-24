DISSERTAION RECOVER FROM STATA

install.packages("haven")

library(haven)

install.packages(c("lmtest", "sandwich")) 
install.packages(c("pdynmc", "psych"))
library(plm)
library(lmtest)
library(sandwich)
library(pdynmc)
library(psych)


disdata <- read_dta("RESEARCHDATA3EXTENDED.dta")

list.files()

# 1. xtset COUNTRYCODE YEAR & gen mobint_low = MOBINT * LOWIN
# explicitly build the interaction and define the panel structures.
disdata$mobint_low <- disdata$MOBINT * disdata$LOWIN

# 2. OLS Regressions (reg GGDP MOBINT mobint_low REGQ INFL)
# (Note: standard 'reg' in Stata treats this as pooled OLS)
ols_ggdp <- lm(GGDP ~ MOBINT + mobint_low + REGQ + INFL, data = disdata)
ols_unpr <- lm(UNPR ~ MOBINT + mobint_low + REGQ + INFL, data = disdata)
ols_pcred <- lm(PCRED ~ MOBINT + mobint_low + REGQ + INFL, data = disdata)

summary(ols_ggdp)
summary(ols_unpr)
summary(ols_pcred)

# 3. summarize GGDP UNPR PCRED MOBINT REGQ INFL, detail
# The 'psych' package provides detailed summary stats (skew, kurtosis, percentiles)
describe(disdata[, c("GGDP", "UNPR", "PCRED", "MOBINT", "REGQ", "INFL")], fast = FALSE)

# 4. pwcorr with significance stars
# This replicates the pairwise correlation matrix with significance levels
corr.test(disdata[, c("PCRED", "MOBINT", "REGQ", "INFL")], method = "pearson")
corr.test(disdata[, c("GGDP", "MOBINT", "REGQ", "INFL")], method = "pearson")
corr.test(disdata[, c("UNPR", "MOBINT", "REGQ", "INFL")], method = "pearson")

# --- 1. Fit the OLS Models on 'disdata' ---
ols_ggdp  <- lm(GGDP ~ MOBINT + mobint_low + REGQ + INFL, data = disdata)
ols_unpr  <- lm(UNPR ~ MOBINT + mobint_low + REGQ + INFL, data = disdata)
ols_pcred <- lm(PCRED ~ MOBINT + mobint_low + REGQ + INFL, data = disdata)

# --- 2. Homoskedasticity Test (Breusch-Pagan) ---
# H0: Homoskedasticity (constant variance). If p-value < 0.05, it has heteroskedasticity.
bptest(ols_ggdp)
bptest(ols_unpr)
bptest(ols_pcred)

# --- 3. Autocorrelation Test (Breusch-Godfrey) ---
# H0: No serial correlation. If p-value < 0.05, errors are correlated over time.
# order = 1 checks for first-order autocorrelation (lag 1)
bgtest(ols_ggdp, order = 1)
bgtest(ols_unpr, order = 1)
bgtest(ols_pcred, order = 1)

#####GMM ESTIMATION PCRED
gmm_pcred <- pdynmc(
  dat        = disdata,
  varname.i  = "COUNTRYCODE", 
  varname.t  = "YEAR",
  
  # Dependent variable specification
  include.y  = TRUE,
  varname.y  = "PCRED",
  lagTerms.y = 1,          # Matches L.PCRED
  
  # Explanatory variables (Further Covariates)
  fur.con          = TRUE,
  fur.con.diff     = TRUE, # FIX: Include covariates in difference equations
  fur.con.lev      = TRUE, # FIX: Include covariates in level equations
  varname.reg.fur  = c("MOBINT", "mobint_low", "INFL", "REGQ"),
  lagTerms.reg.fur = c(0, 0, 0, 0), 
  
  # Instrument configurations mirroring the Stata xtabond2 setup
  use.mc.diff   = TRUE,    # Matches gmm(..., eq(diff))
  use.mc.lev    = TRUE,    # Matches gmm(..., eq(level))
  use.mc.nonlin = FALSE,   
  inst.stata    = TRUE,    # Makes R to calculate internal logic like Stata
  inst.collapse = TRUE,    # Matches 'collapse' parameter
  
  # Estimation settings
  estimation  = "twostep",   # Matches 'twostep'
  std.err     = "corrected", # Matches 'robust' (Windmeijer small sample adjustment)
  include.dum = TRUE,       # Replicates time fixed effects
  dum.diff    = TRUE,       # FIX: Include time dummies in differences
  dum.lev     = TRUE,       # FIX: Include time dummies in levels
  varname.dum = "YEAR"
)

summary(gmm_pcred1)


###GMM ESTIMATION GGDP
gmm_pcred1 <- pdynmc(
  dat        = disdata,
  varname.i  = "COUNTRYCODE", 
  varname.t  = "YEAR",
  
  # Dependent variable specification
  include.y  = TRUE,
  varname.y  = "GGDP",
  lagTerms.y = 1,          # Matches L.PCRED
  
  # Explanatory variables (Further Covariates)
  fur.con          = TRUE,
  fur.con.diff     = TRUE, # FIX: Include covariates in difference equations
  fur.con.lev      = TRUE, # FIX: Include covariates in level equations
  varname.reg.fur  = c("MOBINT", "mobint_low", "INFL", "REGQ"),
  lagTerms.reg.fur = c(0, 0, 0, 0), 
  
  # Instrument configurations mirroring the Stata xtabond2 setup
  use.mc.diff   = TRUE,    # Matches gmm(..., eq(diff))
  use.mc.lev    = TRUE,    # Matches gmm(..., eq(level))
  use.mc.nonlin = FALSE,   
  inst.stata    = TRUE,    # Makes R to calculate internal logic like Stata
  inst.collapse = TRUE,    # Matches 'collapse' parameter
  
  # Estimation settings
  estimation  = "twostep",   # Matches 'twostep'
  std.err     = "corrected", # Matches 'robust' (Windmeijer small sample adjustment)
  include.dum = TRUE,       # Replicates time fixed effects
  dum.diff    = TRUE,       # FIX: Include time dummies in differences
  dum.lev     = TRUE,       # FIX: Include time dummies in levels
  varname.dum = "YEAR"
)

summary(gmm_pcred1)

###GMM ESTIMATION UNPR
gmm_pcred2 <- pdynmc(
  dat        = disdata,
  varname.i  = "COUNTRYCODE", 
  varname.t  = "YEAR",
  
  # Dependent variable specification
  include.y  = TRUE,
  varname.y  = "UNPR",
  lagTerms.y = 1,          # Matches L.PCRED
  
  # Explanatory variables (Further Covariates)
  fur.con          = TRUE,
  fur.con.diff     = TRUE, # FIX: Include covariates in difference equations
  fur.con.lev      = TRUE, # FIX: Include covariates in level equations
  varname.reg.fur  = c("MOBINT", "mobint_low", "INFL", "REGQ"),
  lagTerms.reg.fur = c(0, 0, 0, 0), 
  
  # Instrument configurations mirroring the Stata xtabond2 setup
  use.mc.diff   = TRUE,    # Matches gmm(..., eq(diff))
  use.mc.lev    = TRUE,    # Matches gmm(..., eq(level))
  use.mc.nonlin = FALSE,   
  inst.stata    = TRUE,    # Makes R to calculate internal logic like Stata
  inst.collapse = TRUE,    # Matches 'collapse' parameter
  
  # Estimation settings
  estimation  = "twostep",   # Matches 'twostep'
  std.err     = "corrected", # Matches 'robust' (Windmeijer small sample adjustment)
  include.dum = TRUE,       # Replicates time fixed effects
  dum.diff    = TRUE,       # FIX: Include time dummies in differences
  dum.lev     = TRUE,       # FIX: Include time dummies in levels
  varname.dum = "YEAR"
)

summary(gmm_pcred2)
