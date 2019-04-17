#Increase size of upload files to 500 Mo
options(shiny.maxRequestSize=500*1024^2)
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
library(shinyFiles)
library(openCyto)
library(xtable)
source("flowAIallshinyfunctions.R")
print(sessionInfo())


server <- function(input, output) {
  source("flowAIallshinyfunctions.R")
  
  #Print input filenames
  output$inputFiles <- renderText({
    req(input$Files)
    print(input$Files$name)
  })
  
  #Choose output directory
  shinyDirChoose(input, 'dir', roots = c(rootWindows="C:/",currentDirectory='./',rootMAC="/", home="~/", workingDirectory=getwd()))
  dir <- reactive(input$dir)

  #Print output directory
  output$dir2 <- renderPrint({
    req(input$dir)
    if(input$dir$root[1] == "currentDirectory" || input$dir$root[1] == "workingDirectory"){
      firstBox="."
    }
    if(input$dir$root[1] == "rootMAC"){
      firstBox=""
    }
    if(input$dir$root[1] == "rootWindows"){
      firstBox="C:"
    }
    if(input$dir$root[1] == "home"){
      firstBox="~"
    }
    print(paste0(firstBox,paste0(input$dir$path,collapse="/")))
  })
  
  #Real processing
  output$Samples <- renderText({
    req(input$Files)
    req(input$dir)
    withProgress(message = 'Data cleaning in progress:', value = 0, {
      i=1
      #Output directory
      if(input$dir$root[1] == "currentDirectory" || input$dir$root[1] == "workingDirectory"){
        firstBox="."
      }
      if(input$dir$root[1] == "rootMAC"){
        firstBox=""
      }
      if(input$dir$root[1] == "rootWindows"){
        firstBox="C:"
      }
      if(input$dir$root[1] == "home"){
        firstBox="~"
      }
      saveddirname=paste0(firstBox,paste0(input$dir$path,collapse="/"))
      print(paste0("The output directory is:",saveddirname))
      
      #Save current directory and change to output directory
      savedcurrentdirectory = getwd()
      setwd(saveddirname)
      print(paste0("Change current to output directory:",saveddirname))

      #Foreach of the input FCS file
      for (fcs in input$Files$datapath) {
        #run FlowAI
        if(input$output_QC & input$output_hQC & input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_highQ="_hQC", fcs_lowQ="_lQC", fcs_QC="_QC", folder_results="resultsQC")
        }
        if(input$output_QC & !input$output_hQC & !input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_QC="_QC", folder_results="resultsQC")
        }
        if( !input$output_QC & !input$output_hQC & input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_lowQ="_lQC", folder_results="resultsQC")
        }
        if( !input$output_QC & input$output_hQC & !input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_highQ="_hQC", folder_results="resultsQC")
        }
        if( !input$output_QC & input$output_hQC & input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_highQ="_hQC", fcs_lowQ="_lQC", folder_results="resultsQC")
        }
        if(input$output_QC & input$output_hQC & !input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_highQ="_hQC", fcs_QC="_QC", folder_results="resultsQC")
        }
        if(input$output_QC & !input$output_hQC & input$output_lQC){
          flow_auto_qc_last(fcsfiles=fcs, given_filename=input$Files$name[i], fcs_lowQ="_lQC", fcs_QC="_QC", folder_results="resultsQC")
        }
        
        # Increment the progress bar, and update the detail text.
        incProgress(1/(length(input$Files$name)), detail = paste("Working on the file:", input$Files$name[i]))
        i=i+1
      }
    setwd(savedcurrentdirectory)
    print("If this message appears the program have reach the end!")
    print("You can look at \"resultsQC\" directory to see the results!")
    })
  })
}



