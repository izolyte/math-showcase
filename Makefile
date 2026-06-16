# Compile Typst problem files to PDF.
#
#   make                    compile all problems into output/
#   make compile P=calc-001 compile a single problem (prefix-matches the file)
#   make watch P=calc-001   live-preview a problem while editing
#   make new T=calc S=slug  scaffold a new problem from the template
#   make index              regenerate the README problem index from metadata
#   make index-check        fail if the README index is out of date (CI)
#   make topics             propagate topics.txt into docs / issue template
#   make topics-check       fail if any topic region is out of date (CI)
#   make template-check     verify _TEMPLATE.typ still compiles (CI)
#   make clean              remove compiled PDFs

PROBLEMS := $(wildcard problems/*.typ)
PROBLEMS := $(filter-out problems/_TEMPLATE.typ,$(PROBLEMS))
PDFS := $(patsubst problems/%.typ,output/%.pdf,$(PROBLEMS))

.PHONY: all clean compile watch new index index-check topics topics-check template-check

all: template-check $(PDFS)

output/%.pdf: problems/%.typ
	@mkdir -p output
	typst compile --root . $< $@

# Resolve the file matching P (e.g. P=calc-001) for compile/watch.
define resolve_problem
	if [ -z "$(P)" ]; then echo "usage: make $@ P=<topic>-<NNN>" >&2; exit 1; fi; \
	f=$$(ls problems/$(P)-*.typ 2>/dev/null | head -1); \
	if [ -z "$$f" ]; then echo "No problem matching '$(P)'" >&2; exit 1; fi
endef

compile:
	@$(resolve_problem); \
	mkdir -p output; \
	typst compile --root . "$$f" "output/$$(basename $${f%.typ}).pdf"; \
	echo "Compiled $$f"

watch:
	@$(resolve_problem); \
	mkdir -p output; \
	typst watch --root . "$$f" "output/$$(basename $${f%.typ}).pdf"

new:
	@if [ -z "$(T)" ] || [ -z "$(S)" ]; then \
	  echo "usage: make new T=<topic> S=<slug>" >&2; exit 1; fi
	@bash scripts/new-problem.sh "$(T)" "$(S)"

index:
	@bash scripts/build-index.sh

index-check:
	@bash scripts/build-index.sh --check

topics:
	@bash scripts/sync-topics.sh

topics-check:
	@bash scripts/sync-topics.sh --check

# Compile the template to a throwaway PDF so the src/ machinery is always
# exercised by CI, even when there are zero problems.
template-check:
	@typst compile --root . problems/_TEMPLATE.typ /tmp/_template-check.pdf \
	  && echo "_TEMPLATE.typ compiles" \
	  || { echo "_TEMPLATE.typ failed to compile" >&2; exit 1; }

clean:
	rm -f output/*.pdf
