# set a date ----
today <- as.character(lubridate::today())

# set report path ----
file_path <- './tutorial_autoreport/autoreport_covid_demo/'

file_output_name <- glue::glue('report_demo_auto_', today, '.docx')
file_output_name

file_rmd <- paste0(file_path, 'report_demo_auto.Rmd')
file_docx <- paste0(file_path, file_output_name)



# figure path ---- # 
# here it is the same as file path
# figure_path <- file_path
# figure <- paste0(figure_path, 'map_covid_demo.png')
# figlist <- list(figure = figure)

# make a table ----

tab_1 <- function() {
  
  # correct order
  d_values <- rbind(
    data.table(
      `Indikator` = "Antall nye tilfeller per 14 dager per 100 000 innbyggere",
      `Formål` = "Måler hyppighet av påviste tilfeller",
      `Risikonivå \n1` = "Under 50",
      `Risikonivå \n2` = "50-99",
      `Risikonivå \n3` = "100-199",
      `Risikonivå \n4` = "200-399",
      `Risikonivå \n5` = "400 eller høyere",
      `Tilgjengelighet av data` = "Kommune, BA-region og fylke"
    )
  )
  
  
  ft <- flextable::flextable(d_values)
  ft <- flextable::autofit(ft)
  ft <- flextable::width(ft, j = 1, width = 2)
  ft <- flextable::width(ft, j = 2, width = 2)
  ft <- flextable::width(ft, j = 8, width = 2)
  ft <- table_fit_page(ft, pgwidth = 6.5)
  
  
  # border
  ft <- flextable::border(ft, i = nrow(d_values), border.top = officer::fp_border(width = 1))
  ft <- flextable::vline(ft, border = officer::fp_border(width = 0.5))
  ft <- flextable::vline_left(ft, border = officer::fp_border(width = 0.5))
  
  # font
  ft <- flextable::fontsize(ft, size = 10, part = "all")
  ft <- flextable::font(ft, fontname = "calibri", part = "all")
  ft <- flextable::align_text_col(ft, align = "right")
  ft <- flextable::align(ft, j = 1, align = "left", part = "all")
  # fill colors
  ft <- flextable::bg(ft, bg = "lightgrey", part = "header")
  
  ft <- flextable::bg(ft, i = 1, j = 3, bg = risk_color(1), part = "body")
  ft <- flextable::bg(ft, i = 1, j = 4, bg = risk_color(2), part = "body")
  ft <- flextable::bg(ft, i = 1, j = 5, bg = risk_color(3), part = "body")
  ft <- flextable::bg(ft, i = 1, j = 6, bg = risk_color(4), part = "body")
  ft <- flextable::bg(ft, i = 1, j = 7, bg = risk_color(5), part = "body")
  # text color for higher than level 3
  ft <- flextable::color(ft, i = 1, j = 6, color = "white", part = "body")
  ft <- flextable::color(ft, i = 1, j = 7, color = "white", part = "body")
  
  ft
}




# render report ----
rmarkdown::render(
  input = file_rmd,
  output_dir = file_path,
  output_file = file_output_name
)




# functions -----
risk_color <- function(risklevel) {
  fhiplot::fhi_pal("map_seq_complete", direction = -1)(5)[risklevel]
}


table_fit_page <- function(ft, pgwidth) {
  ft_out <- flextable::width(ft, width = dim(ft)$widths * pgwidth / (flextable::flextable_dim(ft)$widths))
  return(ft_out)
}



make_color_coord <- function(ft, ij, bg_or_text, color) {
  if (nrow(ij) != 0) {
    for (k in 1:nrow(ij)) {
      if (bg_or_text == "bg") {
        ft <- flextable::bg(ft, i = ij[k, 1], j = ij[k, 2], bg = color, part = "body")
      } else {
        ft <- flextable::color(ft, i = ij[k, 1], j = ij[k, 2], color = color, part = "body")
      }
    }
  } else {
    ft <- ft
  }
  return(ft)
}
