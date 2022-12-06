YANGDIR ?= yang

STDYANGDIR ?= $(YANGDIR)/yang
$(STDYANGDIR):
	git clone --depth 10 -b main https://github.com/YangModels/yang $@

OPTIONS=--tree-print-groupings --tree-no-expand-uses -f tree --tree-line-length=70
ifeq ($(OS), Windows_NT)
YANG_PATH="$(YANGDIR);$(STDYANGDIR)/standard/ietf/RFC/;$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
else
YANG_PATH="$(YANGDIR):$(STDYANGDIR)/standard/ietf/RFC/:$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
endif
YANG=$(wildcard $(YANGDIR)/*.yang)
TXT=$(patsubst $(YANGDIR)/%.yang,%-diagram.txt,$(YANG))

.PHONY: yang-lint yang-gen-diagram yang-clean

yang-lint: $(YANG) $(STDYANGDIR)
	pyang -V --lint -p $(YANG_PATH) $<

yang-gen-diagram: yang-lint $(TXT)

yang-clean:
	rm -f $(TXT)

%-diagram.txt: $(YANGDIR)/%.yang
	pyang $(OPTIONS) -p $(YANG_PATH) $< > $@

