BASE_NAME=master_example_en

.PHONY: quick proper compile bibtex clean

quick: compile

proper: clean compile bibtex

compile: introduction.tex appendix.tex $(BASE_NAME).tex
	pdflatex $(BASE_NAME).tex

bibtex:
	bibtex $(BASE_NAME)
	pdflatex $(BASE_NAME).tex > /dev/null
	pdflatex $(BASE_NAME).tex > /dev/null

clean:
	rm -f *.aux *.log *.out *.bbl *.blg *.synctex.gz *.lol *.glo *.lof *.toc *.lot $(BASE_NAME).pdf
