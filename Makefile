.PHONY: all draft thesis count clean

all: thesis draft count

CHAPTERS = introduction.tex prototype.tex pointing.tex haptics.tex design_exp.tex conclusion.tex appendix.tex
CHAPTERS := $(addprefix chapters/, $(CHAPTERS))
TABLES = $(shell find tables -type f)
FIGURES = $(shell find figures -type f)
EXTRA = title_and_frontmatter.tex abstract.tex
BUILD_DIR = build

TEXINPUTS = ".:./style/:./$(BUILD_DIR)/:"

draft: $(BUILD_DIR)/draft.pdf

thesis: $(BUILD_DIR)/thesis.pdf

count: $(BUILD_DIR)/count

clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR)/thesis.pdf: thesis.tex dissertation.bib $(BUILD_DIR) $(CHAPTERS) $(TABLES) $(FIGURES) $(BUILD_DIR)/git-header.tex
	TEXINPUTS=$(TEXINPUTS) latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode -halt-on-error" -outdir=$(BUILD_DIR) thesis.tex

$(BUILD_DIR)/draft.pdf: draft.tex dissertation.bib $(BUILD_DIR) $(CHAPTERS) $(TABLES) $(FIGURES) $(BUILD_DIR)/git-header.tex
	TEXINPUTS=$(TEXINPUTS) latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode -halt-on-error" -outdir=$(BUILD_DIR) draft.tex

$(BUILD_DIR)/count: thesis.tex $(BUILD_DIR) $(CHAPTERS) $(TABLES) $(FIGURES) $(EXTRA)
	texcount -q -inc -sum -1 thesis.tex | grep -o '^[0-9]*$$' > $(BUILD_DIR)/count

$(BUILD_DIR)/git-header.tex: .git/refs/heads/master $(BUILD_DIR)
	echo "build \\\texttt{`git log --pretty=format:'%h' -n 1`}" > $(BUILD_DIR)/git-header.tex

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
