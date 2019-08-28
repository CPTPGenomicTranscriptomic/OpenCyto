options(warn=-1)

if (!require("shiny"))
    install.packages("shiny")  

if (!require("shinyFiles"))
    install.packages('shinyFiles')

if (!require("xtable"))
    install.packages("xtable")

if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

if (!require("openCyto"))
BiocManager::install("openCyto")

library(shiny)
library(shinyFiles)
library(openCyto)
library(xtable)
print(sessionInfo())

ui <- fluidPage(
  br(),
  tags$head(
    tags$style(".title {margin: auto; width: 800px; font-size-adjust: 1.3}")
  ),
  tags$div(class="title", titlePanel("Shiny OpenCyto")),
br(),
  headerPanel(
    list(HTML('<img src="Logo_cptp.png"/>'), HTML('<a href="https://www.cptp.inserm.fr/en/technical-platforms/genomic-and-transcriptomic/">Genomic and transcriptomic platform</a>'), HTML('<img src="Logo_inserm.png"/>')),
    windowTitle="My Title"
  ),
br(),

  sidebarLayout(
    sidebarPanel(
      h3("Please choose your output directory:"),
      shinyDirButton("dir", "Choose output directory", "Select output directory"),
      h3("Please upload your *.fcs files:"),
      fileInput(inputId = "Files", label = "Select Samples", multiple = TRUE, accept = ".fcs"),
      h3("Please upload your *.wsp files:"),
      fileInput(inputId = "workspace", label = "FlowJO workspace", multiple = TRUE, accept = ".wsp"),
      h3("Please choose your output options:"),
      fileInput(inputId = "gatingstrategy", label = "Gating strategy", multiple = FALSE, accept = c("text/csv", "text/comma-separated-values, text/plain", ".csv"))
  ),
    
    mainPanel(
      h4("flowAI is able to perform an automatic or interactive quality control on FCS data acquired using flow cytometry instruments. By evaluating three different properties: 1) flow rate, 2) signal acquisition, 3) dynamic range, the quality control enables the detection and removal of anomalies."),
      HTML('<a href="https://academic.oup.com/bioinformatics/article/32/16/2473/2240408">FlowAI publication</a>'), citation("flowAI"), br(),
      titlePanel("The results will be print here:"),br(),
      #textOutput("inputFiles"),
      h4("Remember your input FCS files were:"),
      verbatimTextOutput("inputFiles"), br(),
      h4("Remember your input workspace was:"),
      verbatimTextOutput("inputWorkspace"), br(),
       h4("Remember your input gating strategy was:"),
      verbatimTextOutput("inputGatingStrategy"), br(),
      h4("Remember your output directory was:"),
      verbatimTextOutput("dir2"), br(),
      h4("If the next line is in red ... it's your problem... not mine, YOUR'S... Good luck!"),
      verbatimTextOutput("Samples")
    )
  )
)
