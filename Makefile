.PHONY: all draft thesis count clean

all: thesis draft count

CHAPTERS = introduction.tex prototype.tex validation.tex haptics.tex design_exp.tex conclusion.tex appendix.tex
CHAPTERS := $(addprefix chapters/, $(CHAPTERS))
EXTRA = title_and_frontmatter.tex abstract.tex
BUILD_DIR = build
DRAFT_DIR = $(BUILD_DIR)/draft

TEXINPUTS = ".:./style/:./$(BUILD_DIR)/:./$(DRAFT_DIR)/:"

draft: $(DRAFT_DIR)/draft.pdf

thesis: $(BUILD_DIR)/thesis.pdf

count: $(BUILD_DIR)/count

clean:
	rm -rf $(DRAFT_DIR)
	rm -rf $(BUILD_DIR)

$(BUILD_DIR)/thesis.pdf: thesis.tex $(BUILD_DIR) $(CHAPTERS) $(EXTRA)
	TEXINPUTS=$(TEXINPUTS) pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(BUILD_DIR) thesis.tex
	TEXINPUTS=$(TEXINPUTS) pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(BUILD_DIR) thesis.tex

$(DRAFT_DIR)/draft.pdf: draft.tex $(DRAFT_DIR) $(CHAPTERS) $(DRAFT_DIR)/git-header.tex
	TEXINPUTS=$(TEXINPUTS) pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(DRAFT_DIR) draft.tex
	TEXINPUTS=$(TEXINPUTS) pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(DRAFT_DIR) draft.tex

$(BUILD_DIR)/count: thesis.tex $(BUILD_DIR) $(CHAPTERS) $(EXTRA)
	texcount -q -inc -sum -1 thesis.tex | grep -o '^[0-9]*$$' > $(BUILD_DIR)/count

$(DRAFT_DIR)/git-header.tex: .git/refs/heads/master
	echo "build \\\texttt{`git log --pretty=format:'%h' -n 1`}" > $(DRAFT_DIR)/git-header.tex

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(DRAFT_DIR):
	mkdir -p $(DRAFT_DIR)
