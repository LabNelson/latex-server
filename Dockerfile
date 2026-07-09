FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    texlive-xetex \
    texlive-luatex \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-bibtex-extra \
    biber \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir .

RUN useradd -m latexuser && chown -R latexuser:latexuser /app

USER latexuser

EXPOSE 9080

CMD ["latex-server"]
