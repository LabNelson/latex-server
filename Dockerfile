FROM kjarosh/latex:latest

RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-setuptools \
    py3-wheel

WORKDIR /app

COPY pyproject.toml .
COPY README.md .
COPY latex_server/ latex_server/

RUN pip3 install --no-cache-dir --break-system-packages .

RUN adduser -D -u 1000 latexuser && \
    chown -R latexuser:latexuser /app

USER latexuser

EXPOSE 9080

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:9080/')" || exit 1

CMD ["latex-server"]
