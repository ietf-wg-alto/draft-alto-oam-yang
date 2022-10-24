OPTIONS=--tree-print-groupings --tree-no-expand-uses -f tree --tree-line-length=70
YANG=$(wildcard ../yang/*.yang)
TXT=$(patsubst ../yang/%.yang,%-diagram.txt,$(YANG))

gen-diagram: $(TXT)

clean:
	rm -f $(TXT)

%-diagram.txt: ../yang/%.yang
ifeq ($(OS), Windows_NT)
	pyang $(OPTIONS) -p '../yang;../../yang/standard/ietf/RFC/;../../yang/experimental/ietf-extracted-YANG-modules' $< > $@
else
	pyang $(OPTIONS) -p ../yang:../../yang/standard/ietf/RFC/:../../yang/experimental/ietf-extracted-YANG-modules $< > $@
endif
