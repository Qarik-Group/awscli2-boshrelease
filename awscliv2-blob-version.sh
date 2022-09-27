#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $ROOT

rm -rf tmp/awscli
mkdir -p tmp/awscli
unzip -qq -d tmp/awscli blobs/awscliv2/awscliv2.zip

docker run -ti -v $PWD/tmp/awscli:/awscli ubuntu /awscli/aws/dist/aws --version
# rm -rf tmp/awscli
