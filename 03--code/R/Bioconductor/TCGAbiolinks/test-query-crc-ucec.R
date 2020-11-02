# Doesn't return primary site

q_crc_ucec = GDCquery(project = c("TCGA-COAD", 
								  "TCGA-READ", 
								  "TCGA-UCEC"), 
					  data.category = "Biospecimen")

q_crc_ucec_res = getResults(q_crc_ucec)
