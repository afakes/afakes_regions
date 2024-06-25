#!/bin/bash

# get the path to the directory where the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bucket="s3://adamfakes.com"
path="au_regions"

# copy files to s3
aws s3 sync . $bucket/$path --recursive --acl public-read

echo "Invalidating cloudfront cache"
aws cloudfront create-invalidation --distribution-id E3KQYE7K1YTIPL --paths "/$path/*"
aws cloudfront create-invalidation --distribution-id E20CMRUG3YJNW8 --paths "/$path/*"


