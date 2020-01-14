# snippets for GenomicDataCommons R package

default_fields("files")
default_fields("cases")
default_fields("projects")
default_fields("annotations")

available_fields("files")
available_fields("cases")
available_fields("projects")
available_fields("annotations")

grep(pattern = "analysis", x = available_fields("files"), value = T) # projects, cases, files, annotations

available_values(entity = "files", field = "analysis.analysis_type")

files() %>% 
	filter(~ program.name == "TCGA" & 
		   	summary.experimental_strategies.experimental_strategy == "WXS") %>% 
	results()


cases() %>% 
	select(c("submitter_id", "submitter_sample_ids", "samples.sample_id")) %>% 
	results()

fileID_caseID_table = tibble(file_UUID = NA, 
							 TCGA_case_ID = NA)
for (i in 1:length(q_files_uuid$cases)) {
	print(q_files_uuid$file_id[i])
	print(q_files_uuid$cases[[i]])
	
	fileID_caseID_table[i, "file_UUID"] = q_files_uuid$file_id[i]
	fileID_caseID_table[i, "TCGA_case_ID"] = q_files_uuid$cases[[i]][[1]]
}
