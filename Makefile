.PHONY: cv-pdf serve build clean

# Génération des PDF des CV (version compacte 2 pages)
cv-pdf:
	@mkdir -p static/pdf
	pandoc pdf/cv_fr.md \
		--pdf-engine=xelatex \
		-H pdf/header.tex \
		-V geometry:margin=1.5cm \
		-V fontsize=10pt \
		-V mainfont="DejaVu Sans" \
		-V monofont="DejaVu Sans Mono" \
		-V colorlinks=true \
		-V linkcolor=blue \
		-V urlcolor=blue \
		-V pagestyle=empty \
		-o static/pdf/cv_nathan_leclercq_fr.pdf
	pandoc pdf/cv_en.md \
		--pdf-engine=xelatex \
		-H pdf/header.tex \
		-V geometry:margin=1.5cm \
		-V fontsize=10pt \
		-V mainfont="DejaVu Sans" \
		-V monofont="DejaVu Sans Mono" \
		-V colorlinks=true \
		-V linkcolor=blue \
		-V urlcolor=blue \
		-V pagestyle=empty \
		-o static/pdf/cv_nathan_leclercq_en.pdf
	@echo "PDFs générés dans static/pdf/"

# Serveur de développement
serve:
	hugo server

# Build production
build: cv-pdf
	hugo

# Nettoyage
clean:
	rm -rf public/ resources/_gen/ static/pdf/
