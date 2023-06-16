library('remotes')
library("h2o")
library("remotes")
## A) Install the latest stable version from CRAN:
library(Robyn)
packageVersion("Robyn")

## Force multi-core use when running RStudio
Sys.setenv(R_FUTURE_FORK_ENABLE = "true")
options(future.fork.enable = TRUE)

# Set to FALSE to avoid the creation of files locally
create_files <- TRUE

#install python library Nevergrad
##install reticuate package and load it 
library(reticulate)

#using PIP, install Nevergrad
virtualenv_create("r-reticulate")
py_install("nevergrad", pip = TRUE)
use_virtualenv("r-reticulate", required = TRUE)


## Force multi-core use when running RStudio
Sys.setenv(R_FUTURE_FORK_ENABLE = "true")
options(future.fork.enable = TRUE)

# Set to FALSE to avoid the creation of files locally
create_files <- TRUE


## Check simulated dataset or load your own dataset
library(readr)

data("dt_prophet_holidays")
dt_MMM<-dt_all

## Check holidays from Prophet
# 59 countries included. If your country is not included, please manually add it.
# Tipp: any events can be added into this table, school break, events etc.

# Directory where you want to export results to (will create new folders)
robyn_directory <- "~/MMM"

## Check simulated dataset or load your own dataset
library(readr)

data("dt_prophet_holidays")
dt_MMM<-dt_all

## Check holidays from Prophet
# 59 countries included. If your country is not included, please manually add it.
# Tipp: any events can be added into this table, school break, events etc.

# Directory where you want to export results to (will create new folders)
robyn_directory <- "~/MMM"

### DEPRECATED: It must have extension .RDS. The object name can be different than Robyn:
# robyn_object <- "~/Desktop/MyRobyn.RDS

InputCollect <- robyn_inputs(
  dt_input = dt_MMM,
  dt_holidays = dt_prophet_holidays,
  date_var = "Date", # date format must be "2020-01-01"
  dep_var = "Sales", # there should be only one dependent variable
  dep_var_type = "revenue", # "revenue" (ROI) or "conversion" (CPA)
  prophet_vars = c("trend", "season", "holiday"), # "trend","season", "weekday" & "holiday"
  prophet_country = "NL", # input one country. dt_prophet_holidays includes 59 countries by default
  context_vars = c("Price", "TDP", "Events","lockdown"), # e.g. competitors, discount, unemployment etc
  paid_media_spends = c(TrdAcosts, TrdBcost, DgtAcosts, DgtBcosts, DgtCcosts, DgtDcosts, PDgtAcosts, PDgtBcosts), # mandatory input
  paid_media_vars =   c(TrdAcosts, TrdBcost, DgtAcosts, DgtBcosts, DgtCcosts, DgtDcosts, PDgtAcosts, PDgtBcosts),
  factor_vars = c("Events"), # force variables in context_vars or organic_vars to be categorical
  window_start = "2019-12-30",
  window_end = "2023-03-06",
  adstock = "geometric" 
)
print(InputCollect)

## hyperparameter names are based on paid_media_spends names too. See right hyperparameter names:
hyper_names(adstock = InputCollect$adstock, all_media = InputCollect$all_media)

# Example hyperparameters ranges for Geometric adstock + Hill function
#values are set to close to the minimum and maximum value for nevergrad function to find the best model
hyperparameters <- list(
  PDgtBcosts_alphas = c(0.5, 5),
  PDgtBcosts_gammas = c(0.2, 1),
  PDgtBcosts_thetas = c(0, 0.95),
  # PDgtBcosts_shapes = c(0.0001,2),
  # PDgtBcosts_scales = c(0,0.1),
  DgtAcosts_alphas = c(0.5, 5),
  DgtAcosts_gammas = c(0.2, 1),
  DgtAcosts_thetas = c(0, 0.95),
  # DgtAcosts_shapes = c(0.0001,2),
  # DgtAcosts_scales = c(0,0.1),
  DgtBcosts_alphas = c(0.5, 5),
  DgtBcosts_gammas = c(0.2, 1),
  DgtBcosts_thetas =c(0, 0.95),
  # DgtBcosts_shapes = c(0.0001,2),
  # DgtBcosts_scales = c(0,0.1),
  TrdAcosts_alphas = c(0.5, 5),
  TrdAcosts_gammas = c(0.2, 1),
  TrdAcosts_thetas = c(0, 0.95),
  TrdBcosts_alphas = c(0.5, 5),
  TrdBcosts_gammas = c(0.2, 1),
  TrdBcosts_thetas = c(0, 0.95),
  PDgtAcosts_alphas = c(0.5, 5),
  PDgtAcosts_gammas = c(0.2, 1),
  PDgtAcosts_thetas = c(0, 0.95),
  DgtCcosts_alphas = c(0.5, 5),
  DgtCcosts_gammas = c(0.2, 1),
  DgtDcosts_thetas =c(0, 0.95),
  DgtDcosts_alphas = c(0.5, 5),
  DgtDcosts_gammas = c(0.2, 1),
  DgtDcosts_thetas =c(0, 0.95),
  train_size = 0.8
)

#add hyperparameters into robyn_inputs
InputCollect <- robyn_inputs(InputCollect = InputCollect, hyperparameters = hyperparameters)
print(InputCollect)

InputCollect <- robyn_inputs(
  dt_input = dt_MMM,
  dt_holidays = dt_prophet_holidays,
  date_var = "Date", # date format must be "2020-01-01"
  dep_var = "Sales", # there should be only one dependent variable
  dep_var_type = "revenue", # "revenue" (ROI) or "conversion" (CPA)
  prophet_vars = c("trend", "season", "holiday"), # "trend","season", "weekday" & "holiday"
  prophet_country = "NL", # input one country. dt_prophet_holidays includes 59 countries by default
  context_vars = c("Price", "TDP", "Events","lockdown"), # e.g. competitors, discount, unemployment etc
  paid_media_spends = c(TrdAcosts, TrdBcost, DgtAcosts, DgtBcosts, DgtCcosts, DgtDcosts, PDgtAcosts, PDgtBcosts), # mandatory input
  paid_media_vars =   c(TrdAcosts, TrdBcost, DgtAcosts, DgtBcosts, DgtCcosts, DgtDcosts, PDgtAcosts, PDgtBcosts),
  factor_vars = c("Events"), # force variables in context_vars or organic_vars to be categorical
  window_start = "2019-12-30",
  window_end = "2023-03-10",
  adstock = "geometric",
  hyperparameters = hyperparameters
)

##Build initial model
OutputModels <- robyn_run(
  InputCollect = InputCollect, # feed in all model specification
  cores = NULL, # NULL defaults to max available - 1
  iterations = 5500 , # 2000 recommended for the dummy dataset with no calibration
  trials = 5, # 5 recommended for the dummy dataset
  ts_validation = TRUE, # 3-way-split time series for NRMSE validation.
  add_penalty_factor = TRUE, # Experimental feature. Use with caution.
)
print(OutputModels)

## Check MOO (multi-objective optimization) convergence plots
# Read more about convergence rules: ?robyn_converge
OutputModels$convergence$moo_distrb_plot
OutputModels$convergence$moo_cloud_plot

## Check time-series validation plot (when ts_validation == TRUE)
# Read more and replicate results: ?ts_validation
if (OutputModels$ts_validation) OutputModels$ts_validation_plot

## Calculate Pareto fronts, cluster and export results and plots. See ?robyn_outputs
OutputCollect <- robyn_outputs(
  InputCollect, OutputModels,
  pareto_fronts = "auto", # automatically pick how many pareto-fronts to fill min_candidates (100)
  min_candidates = 100, # top pareto models for clustering. Default to 100
  # calibration_constraint = 0.1, # range c(0.01, 0.1) & default at 0.1
  csv_out = "pareto", # "pareto", "all", or NULL (for none)
  clusters = TRUE, # Set to TRUE to cluster similar models by ROAS. See ?robyn_clusters
  export = create_files, # this will create files locally
  plot_folder = robyn_directory, # path for plots exports and files creation
  plot_pareto = create_files # Set to FALSE to deactivate plotting and saving model one-pagers
)
print(OutputCollect)

print(OutputCollect)
select_model <- "2_779_2" # Pick one of the models from OutputCollect to proceed

#### Version >=3.7.1: JSON export and import (faster and lighter than RDS files)
ExportedModel <- robyn_write(InputCollect, OutputCollect, select_model, export = create_files)
print(ExportedModel)

# Get budget allocation based on the selected model above
# Run the "max_historical_response" scenario: "What's the revenue lift potential with the
# same historical spend level and what is the spend mix?"
AllocatorCollect2 <- robyn_allocator(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  date_range = "last_10", # Default last month as initial period
  total_budget = NULL, # When NULL, default is total spend in date_range
  channel_constr_low = 0.7,
  channel_constr_up = c(1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2),
  # channel_constr_multiplier = 3,
  scenario = "max_response",
  export = create_files
)

print(AllocatorCollect1)
plot(AllocatorCollect1)

#ROI, response
table_spendshare <-data.frame(selected_coef$rn, selected_coef$spend_share, selected_coef$effect_share,selected_coef$mean_spend, selected_coef$mean_response, selected_coef$roi_total, selected_coef$roi_mean)


##Section 3 : get marginal returns

#########################################################TrdA Identified ##########################################################

Spend1 <-XXXXXXXXX


Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "TrdAcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_t <-Spend2/XXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "TrdAcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_t<-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)

#########################################################TrdB Identified ##########################################################

Spend1 <-XXXXXXXXX

Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "TrdBcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_o <-Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "TrdBcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_o<-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)

#########################################################DgtA Identified ##########################################################

Spend1 <-XXXXXXXXXX

Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtAcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_f <-Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtAcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_f<-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)

#########################################################DgtB Identified ##########################################################

Spend1 <-XXXXXXXXXX

Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtBcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_i <-Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtBcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_i<-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)

############################################################DgtC identified ###################################

Spend1 <-XXXXXXXXXX

Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtCcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_p <- Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtCcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_p<-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)

###############################################################DgtD identified ###################################

Spend1 <-XXXXXXXXXX
Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtDcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_a <- Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "DgtDcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_a<-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)


################################################################# PDgtA identified ####################
Spend1 <-XXXXXXXXX

Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "PDgtAcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_x <-Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "PDgtAcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_x <-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)

################################################################# PDgtB identified ####################
Spend1 <-XXXXXXXXXx

Response1 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "PDgtBcosts",
  metric_value = Spend1, # total budget for date_range
  date_range = "last_1" # last two periods
)
Response1$plot

Spend2 <- Spend1 + 1
percentage_d <-Spend2/XXXXXXXXX
Response2 <- robyn_response(
  InputCollect = InputCollect,
  OutputCollect = OutputCollect,
  select_model = select_model,
  metric_name = "PDgtBcosts",
  metric_value = Spend2,
  date_range = "last_1"
)

Response2$plot
# ROAS for the 100$ from Spend1 level
roas_d <-(Response2$response_total - Response1$response_total) / (Spend2 - Spend1)


#MAPE
library(MLmetrics)
robyndecomp <- pareto_alldecomp_matrix
selected_decomp<-subset(robyndecomp, robyndecomp$solID =='2_779_2')
Maperobyn <-MAPE(selected_decomp$depVarHat, selected_decomp$dep_var)

nrobyn <- nrow(selected_decomp) # Calculate the total number of elements in your data
trainnrow_r <- floor(nrobyn * 0.8)
MMM_train_r <- slice(selected_decomp,1:trainnrow_r)

valrow_r <- floor(nrobyn* 0.1)
MMM_val_r <- slice(selected_decomp, (nrow(MMM_train_r) + 1):(nrow(MMM_train_r) + valrow_r))

testrow_r <- floor(nrobyn* 0.1)
MMM_test_r <- slice(selected_decomp, (nrow(MMM_train_r) + nrow(MMM_val_r) + 1):(nrow(MMM_train_r) + nrow(MMM_val_r) + testrow_r))


##mape
library(MLmetrics)
Maperobyn <-MAPE(MMM_test_r$depVarHat, MMM_test_r$dep_var)

##rsquare
true <-  MMM_test_r$dep_var
predicted <-MMM_test_r$depVarHat
ssr <- sum((predicted - mean(true))^2)
sst <- sum((true - mean(true))^2)
rsquared_robyn <- 1 - (ssr/sst)
adjusted_robyn <- 1-(1-rsquared_robyn)*(16-1)/(16-15-1)

