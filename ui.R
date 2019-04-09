options(warn=-1)

library(shiny)
library(openCyto)
library(xtable)

shinyUI(
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        titlePanel("Please upload your *.fcs files:"),
        fileInput(inputId = "Files", label = "Select Samples", multiple = TRUE, accept = ".fcs"),
        titlePanel("Please choose your output files:"),
        checkboxInput("output_hQC", "Write file with high quality events only (\"_hQC.fcs\")", value = TRUE),
        checkboxInput("output_lQC", "Write file with low quality events only (\"_lQC.fcs\")", value = TRUE),
        checkboxInput("output_QC", "Write file with both low (remove_from_all/QC < 10,000) and high (remove_from_all/QC > 10,000) quality events (\"_QC.fcs\")", value = TRUE)
        #shinyDirButton("output_dir", "Choose directory", "Upload")
        ),

      mainPanel(
        titlePanel("The results will be print here:"),
        textOutput("inputFiles"),
        textOutput("Samples")
        #verbatimTextOutput("dir"), br()
        #tableOutput("flowAI")
        #tableOutput("exprs")
      )
    )
  )
)
