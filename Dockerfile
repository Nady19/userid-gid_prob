FROM ubuntu:latest

RUN groupadd -g 1001 appuser

RUN useradd -r -u 1001 -g appuser appuser

USER appuser

ENTRYPOINT [“sleep”, “infinity”]