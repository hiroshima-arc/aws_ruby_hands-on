#!/usr/bin/env bash
STACKNAME=ruby-hands-on-pipeline

echo "**********************************"
echo STACKNAME:${STACKNAME}
echo "**********************************"

aws cloudformation delete-stack --stack-name ${STACKNAME}
