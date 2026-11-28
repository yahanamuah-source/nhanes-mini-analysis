library(tidyverse)
library(haven)
dir.create("data", showWarnings = FALSE)

cdc_url <- "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/"
for (f in c("DEMO_J", "BMX_J", "PAQ_J")) {
  download.file(paste0(cdc_url, f, ".xpt"),
                destfile = file.path("data", paste0(f, ".xpt")),
                mode = "wb")
}

list.files("data")
demo <- read_xpt("data/DEMO_J.xpt")
bmx  <- read_xpt("data/BMX_J.xpt")
paq  <- read_xpt("data/PAQ_J.xpt")
dim(demo); dim(bmx); dim(paq)

# Selecting the appropriate columns
demo_small <- demo |> 
  select(SEQN, RIDAGEYR, RIAGENDR)
bmx_small  <- bmx  |> 
  select(SEQN, BMXBMI)
paq_small  <- paq  |> 
  select(SEQN, PAQ605)

# Combining to one table
Working_data <- demo_small |>
  inner_join(bmx_small, by = "SEQN") |>
  inner_join(paq_small, by = "SEQN")
head(Working_data)
View(Working_data)

# Rename, filter and create variables
Working_data1 <- Working_data |> 
  rename(ID_NUMBER = SEQN,
         AGE_IN_YEARS = RIDAGEYR,
         GENDER = RIAGENDR,
         BMI = BMXBMI,
         VIGOROUS_WORK_ACTIVITY = PAQ605) |> 
  filter(AGE_IN_YEARS >= 20,
         !is.na(BMI),
         VIGOROUS_WORK_ACTIVITY <= 2) |> 
  mutate(OBESE = if_else(BMI >= 30, 1, 0),
         VIGOROUS_WORK = if_else(VIGOROUS_WORK_ACTIVITY == 1, "YES", "NO"),
         SEX = if_else(GENDER == 1, "MALE", "FEMALE"))
  
#Summary table  
Working_data2 <- Working_data1 |> 
  group_by(VIGOROUS_WORK, SEX) |> 
  summarise(MEAN_BMI = mean(BMI),
            obesity_pct = 100 * mean(OBESE),
            .groups = "drop")
head(Working_data2)
View(Working_data2)

# Logistic regression: vigorous work activity and obesity
model <- glm(OBESE ~ VIGOROUS_WORK + AGE_IN_YEARS + SEX,
             data = Working_data1, family = binomial)
exp(cbind(OR = coef(model), confint(model)))
            
  

