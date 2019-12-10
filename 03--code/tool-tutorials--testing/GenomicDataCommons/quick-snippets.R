default_fields("files")
grep(pattern = "id", x = available_fields("files"), value = T)
available_values(entity = "files", field = "analysis.workflow_type")

files() %>% 
	filter(~ program.name == "TCGA" & 
		   	summary.experimental_strategies.experimental_strategy == "WXS") %>% 
	results()


cases() %>% 
	select(c("submitter_id", "submitter_sample_ids", "samples.sample_id")) %>% 
	results()

