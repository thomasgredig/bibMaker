##########################
# Author: Thomas Gredig
# Date: 2021-Feb-02
#
# Go to Web of Science and
# make a search, then Export
# "Full Record" to Excel,
# save as CSV file, this will
# generate the bibTeX file.
##########################

# Configuration
# ============
filename.input = 'cemAll.csv'
filename.output = 'output.bib'

# load the citations
# ==================
d = read.csv(filename.input)

# create the file entries
# =======================
q=c()
for(cnt in 1:nrow(d)) {
  pg = d$Start.Page[cnt]
  if (is.na(pg)) { pg = d$Article.Number[cnt] }
  q = c(q,
        paste0("@article{bib",cnt,","),
        paste0(" title   = {{",d$Article.Title[cnt],"}},"),
        paste0(" author  = {{",d$Author.Full.Names[cnt],"}},"),
        paste0(" journal = {",d$Journal.ISO.Abbreviation[cnt],"},"),
        paste0(" year    = {",d$Publication.Year[cnt],"},"),
        paste0(" number  = {",d$Issue[cnt],"},"),
        paste0(" pages   = {{",pg,"}},"),
        paste0(" volume  = {",d$Volume[cnt],"}"),
        paste("}"))
}

# save the citations
# ==================
fileConn<-file(filename.output)
writeLines(q, fileConn)
close(fileConn)