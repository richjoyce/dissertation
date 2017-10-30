.PHONY: all
all: thesis.pdf draft.pdf
CHAPTERS = introduction.tex prototype.tex validation.tex haptics.tex design_exp.tex conclusion.tex
EXTRA = preface.tex title_and_frontmatter.tex abstract.tex appendix.tex

thesis.pdf: thesis.tex $(CHAPTERS) $(EXTRA)
	pdflatex thesis.tex


draft.pdf: draft.tex $(CHAPTERS) $(EXTRA)
	pdflatex draft.tex
