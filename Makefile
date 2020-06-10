SCHEMENAMEFILE := ./scheme.name

REPO := ./../../dmdSchemeRepository/

SCHEMEMAKE := library(dmdScheme); \
	scheme <- scheme_make( \
		schemeDefinition = 'dmdScheme.xlsx', \
		examples = list.dirs('examples/', recursive = FALSE), \
		install_R_package = 'install_R_package.R', \
		path = '.', \
		overwrite = TRUE, \
		index_template = 'index.md' \
	); \
		writeLines(scheme, '$(SCHEMENAMEFILE)') \


########### scheme package ###########

scheme:
	Rscript -e "$(SCHEMEMAKE)"

update_repo:
	cp $(shell cat ${SCHEMENAMEFILE}) $(REPO)/schemes/
	@echo
	@echo "##############################################################"
	@echo "## Make sure to update the index at"
	@echo "## $(REPO)/schemes/SCHEME_DEFINITIONS.yaml"
	@echo "## as well!!!"
	@echo "##############################################################"
	@echo

############# Help targets #############

list_variables:
	@echo
	@echo "#############################################"
	@echo "## Variables ################################"
	make -pn | grep -A1 "^# makefile"| grep -v "^#\|^--" | sort | uniq
	@echo "#############################################"
	@echo ""

## from https://stackoverflow.com/a/26339924/632423
list_targets:
	@echo
	@echo "#############################################"
	@echo "## Targets    ###############################"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
	@echo "#############################################"
	@echo

list: list_variables list_targets

#############

.PHONY: list_variables list_targets scheme

