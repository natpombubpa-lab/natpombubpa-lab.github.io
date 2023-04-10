#loading package
library(shiny)
library(shinythemes)
library(ape)
library(vegan)
library(plyr)
library(dplyr)
library(scales)
library(grid)
library(reshape2)
library(phyloseq)
library(magrittr)
library(ggplot2)
library(ggpubr)
library(BiocManager)
library(Biobase)
options(repos = BiocManager::repositories())
#UI
options(shiny.maxRequestSize=150*1024^2)
shinyApp(
  ui = fluidPage(
    navbarPage(
      theme = shinytheme("flatly"),
      "FGanalyst",
      tabPanel("Import Data",
               sidebarPanel(
                 fileInput("file1", "FunGuilds table:"),
                 fileInput("file2", "Mapping File:"),
                 uiOutput("text"),
                 img(src = "https://lh3.googleusercontent.com/EqddQu6ajHCvOLy5Dr_r1AaWJfJCO2ONGHBx-2rGorBX-FU4QehX3s5H7yvPi4rFPN-blb5H6HDkRfaDUkARmLAMmJZdmQyscLUp1eY31w", height = 'auto', width = '100%'),
                
                 mainPanel(uiOutput("Example")
                          ))
               ,mainPanel(
                 tabsetPanel(
                   tabPanel("FunGuilds OTU table",
                            DT::dataTableOutput("otutable")
                   ),
                   tabPanel("Mapping File",
                            DT::dataTableOutput("mapping")
                   ),
                   tabPanel("FunGuilds TAX table",
                            DT::dataTableOutput("taxtable"))
                 )
               )
      ),
      tabPanel("Ploting",
               sidebarLayout(
                 fluidRow(
                   column(width = 2, uiOutput("metachoices")),
                   column(width = 2, offset = 0.6, uiOutput("guildchoices"))
                 #sidebarPanel(
                   #div(style = "display: inline-block;", uiOutput("metachoices")),
                   #div(style = "display: inline-block;", uiOutput("guildchoices"))
                 ),
                 mainPanel(
                   tabsetPanel(
                     tabPanel("FunGuilds-barplot",
                              sidebarPanel(
                                radioButtons("ftype", "Select the file type", c("pdf", "png", "jpeg")),
                                downloadButton('dwd','Download graph')),
                              mainPanel(plotOutput("fgps",height = "720px", width = "720px"))
                     ),
                     tabPanel("Richness plot",
                              sidebarPanel(
                                radioButtons("rtype", "Select the file type", c("pdf", "png", "jpeg")),
                                downloadButton('dwdrn','Download graph')),
                              mainPanel(plotOutput("rn",height = "720px", width = "720px"))
                     ),
                     tabPanel("Ordination plot",
                              sidebarPanel(
                                radioButtons("otype", "Select the file type", c("pdf", "png", "jpeg")),
                                downloadButton('dwdod','Download graph')),
                              mainPanel(plotOutput("od",height = "720px", width = "720px"))
                              
                     ),    
                     tabPanel("Heatmap plot",
                              sidebarPanel(
                                radioButtons("htype", "Select the file type", c("pdf", "png", "jpeg")),
                                downloadButton('dwdhm','Download graph')),
                              mainPanel(plotOutput("hm",height = "720px", width = "720px"))

                     ))
                   
                 ))) ,tabPanel("About",
                               mainPanel(h1("Background")),
                               mainPanel(textOutput("about")),
                               mainPanel(h1("Author"), position = "right"),
                               mainPanel(p('Pudit Palasak Department of Microbiology, Faculty of Science, Chulalongkorn University, Bangkok')),
                               mainPanel(h1("Advisor"), position = "right"),
                               mainPanel(p('Nuttapon Pombubpa Ph.D Department of Microbiology, Faculty of Science, Chulalongkorn University, Bangkok')))
    )),
  server = function(input, output) {
    #User guide
    
    url <- a("Download", href="https://drive.google.com/drive/folders/1shKSl1vuNCosuFu_hF5yUW7yj40Mj6TY?usp=share_link", target = "_blank")
    output$Example <- renderUI({
      tagList("Example Files", url)})
    
    output$text <- renderUI({
      text <- "User required to up load FunGuilds table file and Mapping file !! FunGuilds table file cannot have # or number in the begining of it header otherwise it cannot be read and cause errors"
      tags$div(
        style = "color: red;", # Apply red color style to the div
        renderText(text)
      )})
    output$about <- renderText('FUNGuild Analyst is a user-friendly web tool for analyzing and visualizing functional guilds of fungi. It uses the comprehensive FUNGuild database that includes guilds from different ecosystems. The tool is built on R Shiny, which enables users to create interactive plots and analyze their data easily. It helps users to gain insights into the functional diversity of fungi and their contributions to ecosystem services.')

    #File name
    file_name <- reactive({
      inFile <- input$file1
      
      if (is.null(inFile))
        return(NULL)
      
      return (stringi::stri_extract_first(str = inFile$name, regex = ".*(?=\\.)"))
    })

    #user metadata input
    dfmeta <- reactive({
      FGmeta <- read.table(input$file2$datapath, header=T,row.names=1, sep="\t")
    })
    
    output$metachoices <- renderUI({
      if (is.null(input$file2)){return()}
      dfmeta <- dfmeta()
      selectInput("meta", "Choose metadata", as.list(colnames(dfmeta)))
    })
    
    #user guilds input
    dffg <- reactive({
      FG <- read.table(input$file1$datapath,header=T,sep="\t",row.names=1)
      x <- select(FG, Trophic.Mode, Guild, Growth.Morphology)
      
    })
    
    output$guildchoices <- renderUI({
      if (is.null(input$file1)){return()}
      dffg <- dffg()
      selectInput("guild", "Choose guilds", as.list(colnames(dffg)))
    })
    
    
    #FunGuilds OTU table output
    output$otutable <- DT::renderDataTable({
      if (is.null(input$file1)){return()}
      
      FG <- read.table(input$file1$datapath,header=T,sep="\t",row.names=1)
      FGotus <- select(FG, -(Taxonomy:Citation.Source))
      FGotumat <- as(as.matrix(FGotus), "matrix")
      FGOTU = otu_table(FGotumat, taxa_are_rows = TRUE)
      DT::datatable(FGOTU, options = list(scrollX = T,pageLength = 25), )
    })
    
    #Mapping File output
    output$mapping <- DT::renderDataTable({
      if (is.null(input$file2)){return()}
      
      readmapping <- read.table(input$file2$datapath, header=TRUE,row.names=1, sep="\t")
      sampleData <- sample_data(readmapping)
      DT::datatable(sampleData, options = list(scrollX = T,pageLength = 25))
    })
    
    
    #FunGuilds TAX table output
    output$taxtable <- DT::renderDataTable({
      if (is.null(input$file1)){return()}
      FG <- read.table(input$file1$datapath,header=T,sep="\t",row.names=1)
      FGtaxmat <- select(FG, Trophic.Mode, Guild, Growth.Morphology)
      FGtaxmat <- as(as.matrix(FGtaxmat),"matrix")
      FGTAX = tax_table(FGtaxmat)
      DT::datatable(FGTAX, options = list(scrollX = T,pageLength = 25))
    })
    
    
    #Construct FunGuilds-Phyloseq object
    output$fgps <-renderPlot({
      if (is.null(input$file1)){return()}
      
      FG <- read.table(input$file1$datapath,header=T,sep="\t",row.names=1)
      FGotus <- select(FG, -(Taxonomy:Citation.Source))
      FGotumat <- as(as.matrix(FGotus), "matrix")
      FGOTU <<- otu_table(FGotumat, taxa_are_rows = TRUE)
      
      readmapping <<- read.table(input$file2$datapath, header=TRUE,row.names=1, sep="\t")
      #readmappingfg <- select(readmapping, input$meta)
      sampleData <- sample_data(readmapping)
      
      FGtaxmat <- select(FG, Trophic.Mode, Guild, Growth.Morphology)
      FGtaxmat <- as(as.matrix(FGtaxmat),"matrix")
      FGTAX <<- tax_table(FGtaxmat)
      
      fgps <- phyloseq(FGOTU,FGTAX,sampleData)
      
      fgps.prune <<- prune_taxa(taxa_sums(fgps) > 1, fgps)
      
      fgps.prune.no.na <<- subset_taxa(fgps.prune, Trophic.Mode!="-")
      
      fgps_plot <<- ggplot(data = psmelt(fgps.prune.no.na), mapping = aes_string(x = input$meta ,y = "Abundance", fill = input$guild )) + geom_bar(stat="identity", position="fill") + 
        scale_fill_manual(values=c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#999999", "#E69F00", 
                                   "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7","#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#00FFFF",
                                   "#FF00FF", "#800000", "#008000", "#000080", "#808000","#008080", "#800080", "#FFA500", "#00FF7F", "#7B68EE",
                                   "#FF69B4", "#6495ED", "#DC143C", "#00FA9A", "#9400D3")) +
        ggtitle("Bar plot") +  
        theme(plot.title = element_text(hjust = 0.5)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
        
      fgps_plot
    }, height = 800)
    
    #Richness plot
    output$rn <- renderPlot({
      if (is.null(input$file1)){return()}
      rn_plot <<- plot_richness(fgps.prune , x = input$meta, color = input$meta, measures=c("Chao1") ) + geom_boxplot() + theme_bw() + ggtitle("Richness plot") + 
        theme(plot.title = element_text(hjust = 0.5)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
      rn_plot})
    
    #Ordination plot
    output$od <- renderPlot({
      if (is.null(input$file1)){return()}
      fgps.prune.ord <- ordinate(fgps.prune, "DCA", "unifrac")
      od_plot <<- plot_ordination(fgps.prune, fgps.prune.ord, type = input$meta, color = input$meta) + theme_bw() + ggtitle("Ordination plot") +  
        theme(plot.title = element_text(hjust = 0.5)) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1))
      od_plot})
    
    #Heatmap plot
    output$hm <- renderPlot({
      if (is.null(input$file1)){return()}
      physeq = phyloseq(FGOTU, FGTAX)
      random_tree = rtree(ntaxa(physeq), rooted=TRUE, tip.label=taxa_names(physeq))
      physeq1 <<- merge_phyloseq(physeq, random_tree)
      plot_heatmap(physeq1, sample_data  = input$meta )})
    
    
    #Download files
    
    output$dwd <- downloadHandler(
      filename = function(){
        paste(file_name(),"barplot", input$ftype, sep = ".")
      },
      content = function(file){
        if(input$ftype=="pdf"){pdf(file)}
        if(input$ftype=="png"){png(file)}
        if(input$ftype=="jpeg"){jpeg(file)}
        plot(fgps_plot)
        dev.off()
      })
    
    output$dwdrn <- downloadHandler(
      filename = function(){
        paste(file_name(),"Richness plot", input$rtype, sep = ".")
      },
      content = function(file){
        if(input$rtype=="pdf"){pdf(file)}
        if(input$rtype=="png"){png(file)}
        if(input$rtype=="jpeg"){jpeg(file)}
        plot(rn_plot)
        dev.off()
      })

    output$dwdod <- downloadHandler(
      filename = function(){
        paste(file_name(),"Ordination plot", input$otype, sep = ".")
      },
      content = function(file){
        if(input$otype=="pdf"){pdf(file)}
        if(input$otype=="png"){png(file)}
        if(input$otype=="jpeg"){jpeg(file)}
        plot(od_plot)
        dev.off()
      })
    
    output$dwdhm <- downloadHandler(
      filename = function(){
        paste(file_name(),"Heatmap plot", input$htype, sep = ".")
      },
      content = function(file){
        if(input$htype=="pdf"){pdf(file)}
        if(input$htype=="png"){png(file)}
        if(input$htype=="jpeg"){jpeg(file)}
        plot(plot_heatmap(physeq1))
        dev.off()
      })
    
  }
)