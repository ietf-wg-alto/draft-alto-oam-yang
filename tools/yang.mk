YANGDIR ?= yang

STDYANGDIR ?= tools/yang
$(STDYANGDIR):
	git clone --depth 10 -b main https://github.com/YangModels/yang $@

LIBYANGBIN ?= yanglint

OPTIONS=--tree-print-groupings --tree-no-expand-uses -f tree --tree-line-length=67
ifeq ($(OS), Windows_NT)
YANG_PATH="$(YANGDIR);$(STDYANGDIR)/standard/ietf/RFC/;$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
else
YANG_PATH="$(YANGDIR):$(STDYANGDIR)/standard/ietf/RFC/:$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
endif
YANG=$(wildcard $(YANGDIR)/*.yang)
STDYANG=$(wildcard $(YANGDIR)/ietf-*.yang)
EXPYANG=$(wildcard $(YANGDIR)/example-*.yang)
EXPJSON=$(wildcard $(YANGDIR)/example-*.json)
TXT=$(patsubst $(YANGDIR)/%.yang,%-diagram.txt,$(YANG))
YANGLINT=$(patsubst $(YANGDIR)/ietf-%.yang,yang-lint-%.log,$(STDYANG))

.PHONY: yang-lint yang-gen-diagram yang-clean

pyang-lint: $(STDYANG) $(EXPYANG) $(STDYANGDIR)
	pyang -V --ietf -p $(YANG_PATH) $(STDYANG)
	pyang -V -p $(YANG_PATH) $(EXPYANG)

yang-lint-%.log: $(YANGDIR)/ietf-%.yang
	$(LIBYANGBIN) --verbose -p $(YANGDIR)/temp -p $(YANGDIR) -p $(STDYANGDIR)/standard/ietf/RFC/ -p $(STDYANGDIR)/experimental/ietf-extracted-YANG-modules $< -i -o $@

yang-lint: $(YANGLINT)

yang-gen-diagram: yang-lint $(TXT)

yang-clean:
	rm -f $(TXT) $(YANGLINT)

yangson-validate: $(EXPJSON) $(STDYANGDIR)
	yangson -p $(YANGDIR) -p $(YANGDIR):$(STDYANGDIR)/standard/ietf/RFC/:$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules -v $(EXPJSON) $(YANGDIR)/yang-library-ietf-alto.json

%-diagram.txt: $(YANGDIR)/%.yang
	pyang $(OPTIONS) -p $(YANG_PATH) $< > $@

