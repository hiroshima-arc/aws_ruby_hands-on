#!/usr/bin/env bash
STACKNAME=ruby-hands-on-pipeline
TEMPLATE=ci.yml
TEMPLATE_PARAMS=ci-parameter.json
TAGKEY=Name
TAGVALUE=event

echo "**********************************"
echo STACKNAME:${STACKNAME}
echo TEMPLATE:${TEMPLATE}
echo TEMPLATE_PARAMS:${TEMPLATE_PARAMS}
echo TAGKEY:${TAGKEY}
echo TAGVALUE:${TAGVALUE}
echo "**********************************"

aws cloudformation create-stack --stack-name ${STACKNAME} \
                                --template-body file://${TEMPLATE} \
                                --parameters file://${TEMPLATE_PARAMS} \
                                --tags Key=${TAGKEY},Value=${TAGVALUE} \
                                --capabilities CAPABILITY_NAMED_IAM
