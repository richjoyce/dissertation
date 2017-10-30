.PHONY: all draft thesis

all: thesis.pdf draft.pdf

draft: draft.pdf

thesis: thesis.pdf

CHAPTERS = introduction.tex prototype.tex validation.tex haptics.tex design_exp.tex conclusion.tex
EXTRA = preface.tex title_and_frontmatter.tex abstract.tex appendix.tex
BUILD_DIR=build

thesis.pdf: thesis.tex $(BUILD_DIR) $(CHAPTERS) $(EXTRA)
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(BUILD_DIR) thesis.tex

draft.pdf: draft.tex $(BUILD_DIR) $(CHAPTERS) git-header.tex
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(BUILD_DIR) draft.tex

git-header.tex: .git/refs/heads/master
	echo "build \\\texttt{`git log --pretty=format:'%h' -n 1`}" > git-header.tex

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
