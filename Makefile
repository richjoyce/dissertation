.PHONY: all
all: thesis.pdf draft.pdf
CHAPTERS = introduction.tex prototype.tex validation.tex haptics.tex design_exp.tex conclusion.tex
EXTRA = preface.tex title_and_frontmatter.tex abstract.tex appendix.tex
BUILD_DIR=build

thesis.pdf: thesis.tex $(BUILD_DIR) $(CHAPTERS) $(EXTRA)
	pdflatex -halt-on-error -output-directory $(BUILD_DIR) thesis.tex


draft.pdf: draft.tex $(BUILD_DIR) $(CHAPTERS) $(EXTRA)
	pdflatex -halt-on-error -output-directory $(BUILD_DIR) draft.tex

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
