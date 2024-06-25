#!/usr/bin/Rscript

# ref: https://cran.r-project.org/web/packages/geojsonR/vignettes/the_geojsonR_package.html
# install R library rgdal
# install.packages("rgrass")
# install.packages("jsonlite")
# install.packages("geojsonR")
# install.packages("glue")

library(glue)
library(geojsonR)

#  create function file to dataframe
get_datatable <- function(path) {
    
    file_js = FROM_GeoJson(url_file_string = path)

    first_feature = file_js$features[[1]]
    keys = names(first_feature$properties)  #  keys from first_feature#properties


    df = data.frame(matrix(ncol = length(keys), nrow = 0))  #  create datarame with keys as columns
    colnames(df) = keys  # set column names

    # loop through features
    for (feature in file_js$features) {
        # print(feature$properties$REG_NAME_7)
        row = c()
        for (key in keys) {
            value = feature$properties[[key]]
            if (is.null(value)) { value = NA }
            row = c(row, value)
        }
        # create a single row df with the same keys 
        df1 = data.frame(t(row))  
        colnames(df1) = keys  
        df = rbind(df, df1) # append row to dataframe

    }

    #  update datatypes of columns
    df <- type.convert(df, as.is = TRUE)

    return(df)
}

geojson_file <- "data/regions_simple.geojson"

df = get_datatable(geojson_file)

print(df)

#  get stats of df
print(summary(df))





