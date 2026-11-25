library(haven)
library(dplyr)

# folder for the data files, inside your project
dir.create("data", showWarnings = FALSE)

# download the three NHANES 2017-2018 files from the CDC
base <- "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2017/DataFiles/"
for (f in c("DEMO_J", "BMX_J", "PAQ_J")) {
  download.file(paste0(base, f, ".xpt"),
                destfile = file.path("data", paste0(f, ".xpt")),
                mode = "wb")
}

# read them into R
demo <- read_xpt("data/DEMO_J.xpt")   # age, sex
bmx  <- read_xpt("data/BMX_J.xpt")    # body measures, BMI
paq  <- read_xpt("data/PAQ_J.xpt")    # physical activity

# check they loaded
dim(demo)
head(demo)