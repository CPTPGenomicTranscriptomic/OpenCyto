OpenCyto
========
Automated gating data using OpenCyto R package through a new Rshiny interface.

*****

Launch OpenCyto directly from R and GitHub (preferred approach)

User can choose to run FlowAIAll installed locally for a more preferable experience.

**Step 1: Install R and RStudio**

Before running the app you will need to have R and RStudio installed (tested with R 3.5.3 and RStudio 1.1.463).  
Please check CRAN (<a href="https://cran.r-project.org/" target="_blank">https://cran.r-project.org/</a>) for the installation of R.  
Please check <a href="https://www.rstudio.com/" target="_blank">https://www.rstudio.com/</a> for the installation of RStudio.  

**Step 2: Install the R Shiny package and other packages required by FlowAIAll**

Start an R session using RStudio and run this line:  
```
if (!require("shiny")){install.packages("shiny")}  
```

Rstudio (in the console) can ask about updates.

If a message like: "Update all/some/none?" appears in the Rstudio console just press "n" and enter.


**Step 3: Start the app**  

Start an R session using RStudio and run this line:  
```
shiny::runGitHub("OpenCyto", "CPTPGenomicTranscriptomic")
```

Rstudio (in the console) can ask about updates.

If a message like: "Update all/some/none?" appears in the Rstudio console just press "n" and enter (can happen several times).

This command will download the code of FlowAIAll from GitHub to a temporary directory of your computer and then launch the FlowAIAll app in the web browser. Once the web browser was closed, the downloaded code of FlowAIAll would be deleted from your computer. Next time when you run this command in RStudio, it will download the source code of FlowAIAll from GitHub to a temporary directory again. 


## Step 4: Choose your analysis set up  

**1. Choose your output directory:**

Choose the operating system (Windows pr MAC) in the top rigth corner.

The from root select the output directory.

The application can crash (everything in grey, no interactivity) if you choose the wrong operating system, if you choose a directory where you haven't some rigths and others...

Experts can try others Volumes (as currentDirectory, home, etc...) but they have to use the application on local.


**2. Choose your fcs files:**

You can upload from one to multiple \*.fcs files.

The files must have the .fcs extension to appear in the selection browser.

No matter if there is no time/Time/TIME parameter.

Be aware that The application is limited to 500Mo of RAM.

The blue progress bar should move until the message \"upload complete\" appears.

These files must be all present in the same workspace.

**3. Upload your workspace file:**

You can upload one \*.wsp file.

The files must have the .wsp extension to appear in the selection browser.

The blue progress bar should move until the message \"upload complete\" appears.

**3. Upload your gating strategy:**

You can upload one gating strategy file.

The files must have the text/csv, text/comma-separated-values, text/plain or .csv extension to appear in the selection browser.

The content of the gating strategy file is describe here:
https://bioconductor.org/packages/release/bioc/vignettes/openCyto/inst/doc/HowToWriteCSVTemplate.html
https://bioconductor.org/packages/release/bioc/vignettes/openCyto/inst/doc/HowToAutoGating.html

The blue progress bar should move until the message \"upload complete\" appears.


**4. Wait for the computation:**

Once the uploads completed a progress boxe should appears in the rigth-bottom corner. It indicates that the application is running and which input file is processed.


**5. The results:**

Once the progress box has disappeared.

The inputs files should be listed below \"Remember your input FCS files were:\".

The inputs files should be listed below \"Remember your input workspace was:\".

The inputs files should be listed below \"Remember your input gating strategy was:\".

The ouput directory should appears below \"Remember your output directory was\".

This message \"You can look at "resultsQC" directory to see the results!\" should be print below \"If the next line is in red ... it's your problem... not mine, YOUR'S... Good luck!\".

If any Red word or line appears the apllication has encountered an error. Don't hesitate to look at the Rstudio console to track the problem.

The results should be located at the output directory.

The webpage should look like this!

![alt text](https://github.com/CPTPGenomicTranscriptomic/OpenCyto/blob/master/Opencyto_interface.png)


