# AWS CLI v2 for BOSH deployments

Add and configure `aws` CLI into your BOSH deployments.

```plain
source /var/vcap/jobs/awscliv2/env
aws s3 ls
```

# Version Bump process

## Creation of the blobs directory

Update the aws CLIv2 download link in the script `update-awscliv2.sh` to get the current version.
Run ```./update-awscliv2.sh``` which will create the blobs directory with the downloaded file.

1. Check the version of aws cli in blob

Run the script `awscliv2-blob-version.sh`.

**Notes**:
For M1 Macbook users modify the script as indicated:

```plain
#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $ROOT

rm -rf tmp/awscli
mkdir tmp/awscli
unzip -qq -d tmp/awscli blobs/awscliv2/awscliv2.zip

# For M1 Mac users add  “--platform linux/x86_64” after “docker run”
docker run -ti -v $PWD/tmp/awscli:/awscli ubuntu /awscli/aws/dist/aws --version
# rm -rf tmp/awscli
```

## Creation of a Dev Release

* Create a Dev release: ``` bosh create-release --force```
* Test the Dev release by uploading it to a test enviroment ```bosh upload-release /path/to/dev/release```. 
* Edit a BOSH deployment manifest pointing to the Dev release. 


## Creation of the Final Release

### Uploading of the blobs

Blobs should be saved into release blobstore before cutting a new final release.
Create a config/private.yml as follow:
```plain
---
blobstore:
  options:
    access_key_id: <access_key_id>
    secret_access_key: <secret_access_key>
```
Upload the blobs by running: ```bosh upload-blobs```

### Commit 
Commit all the changes made in the directory


### Compiled Release and Final Release

The compiled releases are done through the concourse pipeline. They are done against stemcells.
To cut a compiled release against ubuntu-xenial or ubuntu-bionic do the following:
1. Check the following files pipeline.yml, ci/scripts/export-release, ci/scripts/use-compiled-releases and manifests/awscliv2.yml.
2. if the desired stemcell is presents in them go to 5. If no, go to 3.
3. Modify the stemcell in the pipeline.yml, ci/scripts/export-release, ci/scripts/use-compiled-releases and manifests/awscliv2.yml.
4. run the script ./repipe
5. Use the Concourse UI to run the builds
6. Start generating compiled release under the Compile-release group.

 
