# Autoreport 102

This is the 2nd tutorial on autoreport. In the previous tutorial, I have shown how to make a `.docx` report in Rmarkdown, using MS office. 

In this tutorial we move one step further to automation: we make the previous Rmarkdown report reference **R objects** such as data (date, numbers, strings) such that a new report can have updated data automatically. 

## Goal

In this minimal example, we make the **date** change to today's date. 

# Step 1. Create a functional `Rmd/docx` report 

You can follow the example as in `autoreport_101`. In this example, we call it `report_demo_auto.Rmd`. This produces a Word report called `report_demo_auto.docx`.

![fig_12](/Users/andrea/Documents/GitHub/resources/tutorial_autoreport/fig_tutorial_autoreport/fig_12.png)

Make sure that you source the **style file** in the header of `Rmd` file: in the automation process, we do NOT use the style file. 

Take a note on the **file path**, as we will need them later.



# Step 2. Create an R script 

In this R script `run_autoreport.R`, we try to do the following: 

- create a date object, `today`. This changes everytime you call it.
- specify the path for the `Rmd` document: this is the input. 
- specify the path for the `docx` document, this is the output. It is recommended that you specify the **date and time** when this report is generated, so that later you can find different versions easily.



![fig_9](/Users/andrea/Documents/GitHub/resources/tutorial_autoreport/fig_tutorial_autoreport/fig_9.png)

# Step 3. Reference R object in `Rmd` report

R objects can be called like this `r R_object`. More advanced uses please refer to Rmarkdown documents.



![fig_8](/Users/andrea/Documents/GitHub/resources/tutorial_autoreport/fig_tutorial_autoreport/fig_8.png)

# Step 4. Render report in `R`

After these steps, we write the following (either run directly in the console, or in a script): 

```{r}
rmarkdown::rennder(
	input = file_rmd, 
	output_dir = file_path, 
	output_file = file_docx
)
```

When you run this chunk in R console, it is doing the similar thing as Knit Rmarkdown. 

Check your newly generated `docx` report, it should contain the date "today". 



## Output 

Note that the title is changed too. 

![fig_11](/Users/andrea/Documents/GitHub/resources/tutorial_autoreport/fig_tutorial_autoreport/fig_11.png)



