ARG REQUESTS_LAYER_REPOS_URI
ARG REQUESTS_LAYER_IMAGE_TAG

FROM ${REQUESTS_LAYER_REPOS_URI}:${REQUESTS_LAYER_IMAGE_TAG} AS requests-layer
FROM public.ecr.aws/lambda/python:3.9 AS base

WORKDIR /opt
COPY --from=requests-layer /opt/ .

WORKDIR ${LAMBDA_TASK_ROOT}
COPY sample1.py ${LAMBDA_TASK_ROOT}

CMD [ "sample1.lambda_handler" ]