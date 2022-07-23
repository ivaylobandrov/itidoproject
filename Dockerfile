FROM python:3.8-alpine
LABEL maintainer="bandrov17"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY /myproject /myproject
COPY /scripts /scripts

WORKDIR /myproject
EXPOSE 8000

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
    rm -rf /tmp && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home django-user && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R django-user:django-user /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER django-user

CMD ["run.sh"]