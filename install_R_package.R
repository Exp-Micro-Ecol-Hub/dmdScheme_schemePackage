devtools::install_github(
  repo = "Exp-Micro-Ecol-Hub/dmdScheme",
  ref = "master",
  force = TRUE,
  upgrade = "never"
)

rold <- getOption("repos")
r <- rold

r["CRAN"] <-  "http://cran.us.r-project.org"
r["dmdScheme"] <- "https://exp-micro-ecol-hub.github.io/dmdSchemeRMaster/"

options(repos = r)

install.packages("dmdScheme")

options(repos = rold)
