.PHONY: all draft thesis clean

all: thesis draft

draft: draft.pdf

thesis: thesis.pdf

clean:
	rm -rf build
	rm git-header.tex

CHAPTERS = introduction.tex prototype.tex validation.tex haptics.tex design_exp.tex conclusion.tex
EXTRA = preface.tex title_and_frontmatter.tex abstract.tex appendix.tex
BUILD_DIR=build
DRAFT_DIR=build/draft

thesis.pdf: thesis.tex $(BUILD_DIR) $(CHAPTERS) $(EXTRA)
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(BUILD_DIR) thesis.tex
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(BUILD_DIR) thesis.tex

draft.pdf: draft.tex $(DRAFT_DIR) $(CHAPTERS) git-header.tex
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(DRAFT_DIR) draft.tex
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory $(DRAFT_DIR) draft.tex

git-header.tex: .git/refs/heads/master
	echo "build \\\texttt{`git log --pretty=format:'%h' -n 1`}" > git-header.tex

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(DRAFT_DIR):
	mkdir -p $(DRAFT_DIR)
