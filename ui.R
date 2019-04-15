options(warn=-1)

if (!require("shiny"))
    install.packages("shiny")  

if (!require("shinyFiles"))
    install.packages('shinyFiles')

if (!require("xtable"))
    install.packages("xtable")

if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

#if (!require("flowAI"))
#BiocManager::install("flowAI", version = "3.8")

if (!require("openCyto"))
BiocManager::install("openCyto")

library(shiny)
library(openCyto)
library(xtable)

ui <- fluidPage(
  br(),
  tags$head(
    tags$style(".title {margin: auto; width: 800px; font-size-adjust: 1.3}")
  ),
  tags$div(class="title", titlePanel("Shiny FlowAI")),
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
      h3("Please choose your output options:"),
      checkboxInput("output_hQC", "Write file with high quality events only (\"_hQC.fcs\")", value = TRUE),
      checkboxInput("output_lQC", "Write file with low quality events only (\"_lQC.fcs\")", value = FALSE),
      checkboxInput("output_QC", "Write file with both low (remove_from_all/QC < 10,000) and high (remove_from_all/QC > 10,000) quality events (\"_QC.fcs\")", value = TRUE)    ),
    
    mainPanel(
      h4("flowAI is able to perform an automatic or interactive quality control on FCS data acquired using flow cytometry instruments. By evaluating three different properties: 1) flow rate, 2) signal acquisition, 3) dynamic range, the quality control enables the detection and removal of anomalies."),
      HTML('<a href="https://academic.oup.com/bioinformatics/article/32/16/2473/2240408">FlowAI publication</a>'), citation("flowAI"), br(),
      titlePanel("The results will be print here:"),br(),
      #textOutput("inputFiles"),
      h4("Remember your input files were:"),
      verbatimTextOutput("inputFiles"), br(),
      h4("Remember your output directory was:"),
      verbatimTextOutput("dir2"), br(),
      h4("If the next line is in red ... it's your problem... not mine, YOUR'S... Good luck!"),
      verbatimTextOutput("Samples")
    )
  )
)
