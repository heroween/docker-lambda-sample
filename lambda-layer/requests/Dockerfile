FROM public.ecr.aws/lambda/python:3.9 AS installer
WORKDIR /opt/python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -t .

FROM scratch AS base
WORKDIR /opt/python
COPY --from=installer /opt/python .