#!/usr/bin/env bash
STACKNAME=aws-hands-on-iam

echo "**********************************"
echo STACKNAME:${STACKNAME}
echo "**********************************"

aws cloudformation delete-stack --stack-name ${STACKNAME}
