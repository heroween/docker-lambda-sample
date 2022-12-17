#!/bin/bash
set -euo pipefail

function usage {
  cat <<EOS
Usage: $(basename ${0}) [arn]
Parameter:
  arn    AWSに既存のGitHub OIDC Providerが存在する場合は、そのARNを設定する
         完全に新規でGitHub OIDC Providerを作成する場合には、この引数の設定は不要
EOS
  exit 1
}

if [ $# -gt 1 ]; then
  echo -e "Error:指定された引数の数が不正です"
  usage
fi

if [ $# -eq 1 ]; then
  readonly GITHUB_OIDC_PROVIDER_ARN=${1}
  readonly PARAMETERS_OPTION="--parameters PrameterKey=GitHubOIDCProviderArn,ParameterValue=${GITHUB_OIDC_PROVIDER_ARN}"
else
  readonly PARAMETERS_OPTION=""
fi

readonly STACK_NAME=github-oidc-provider
readonly TEMPLATE_PATH=$(git rev-parse --show-toplevel)/cfn-template/github-oidc-provider.yaml

aws cloudformation validate-template --template-body file://${TEMPLATE_PATH} --no-cli-pager

aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${TEMPLATE_PATH} --capabilities CAPABILITY_NAMED_IAM ${PARAMETERS_OPTION} --no-cli-pager