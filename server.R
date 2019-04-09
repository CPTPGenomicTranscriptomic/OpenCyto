#Increase size of upload files to 500 Mo
options(shiny.maxRequestSize=500*1024^2)
options(warn=-1)

library(shiny)
library(openCyto)
library(xtable)
source("flowAIallshinyfunctions.R")
print(sessionInfo())


server <- function(input, output) {
  source("flowAIallshinyfunctions.R")
  

  
  #data <- reactive({
  #  read.flowSet(files = input$Files$datapath)
  #})
  
  #output$names <- renderText({
  #  req(input$Files)
  #  print(class(data()))
  #})
  
  output$inputFiles <- renderText({
    req(input$Files)
    print(input$Files$name)
  })
  
  output$Samples <- renderText({
    req(input$Files)
    withProgress(message = 'Data cleaning in progress:', value = 0, {
      i=1
      for (fcs in input$Files$datapath) {
        #flowautoQC
        #print(sampleNames(data()))
        #print(i)
        #print("11111")
        #print(input$Files)
        #print("22222")
        #print(input$Files$name)
        #print("33333")
        #print(length(input$Files$name))
        #print("44444")
        #print(class(input$Files$name))
        #print(input$Files$name[i])
        #print("66666")
        #print(sub('\\.fcs$', '', input$Files$name[i]))
        #print("55555")
        #print (fcs)
        
        #Change dir
        #if (file.exists(sub('\\.fcs$', '', input$Files$name[i]))){
        #  setwd(sub('\\.fcs$', '', input$Files$name[i]))
        #} else {
        #  dir.create(sub('\\.fcs$', '', input$Files$name[i]))
        #  setwd(sub('\\.fcs$', '', input$Files$name[i]))
        #}
        
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
        
        #I will be back
        #print(logFlowAI)
        #setwd("../")
        
        # Increment the progress bar, and update the detail text.
        incProgress(1/(length(input$Files$name)), detail = paste("Working on the file:", input$Files$name[i]))
        i=i+1
      }
    print("If this message appears the program have reach the end!")
    print("You can look at \"resultsQC\" directory to see the results!")
    #shinyDirChoose(input, 'outputdir', roots = getVolumes())
    #dir <- reactive(input$outputdir)
    #output$dir <- renderPrint(dir())
    })
  })
  #  output$exprs <- renderTable({
  #    req(input$Files)
  #    DT::renderDataTable(exprs(data())) # Not sure how to subset data()
  #  })
}



