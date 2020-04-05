# BOSH release for awscli2

This BOSH release and deployment manifest deploy a cluster of awscli2.

## Usage

This repository includes base manifests and operator files. They can be used for initial deployments and subsequently used for updating your deployments:

```plain
export BOSH_ENVIRONMENT=<bosh-alias>
export BOSH_DEPLOYMENT=awscli2
git clone https://github.com/cloudfoundry-community/awscli2-boshrelease.git
bosh deploy awscli2-boshrelease/manifests/awscli2.yml
```

If your BOSH does not have Credhub/Config Server, then remember `--vars-store` to allow generation of passwords and certificates.

### Update

When new versions of `awscli2-boshrelease` are released the `manifests/awscli2.yml` file will be updated. This means you can easily `git pull` and `bosh deploy` to upgrade.

```plain
export BOSH_ENVIRONMENT=<bosh-alias>
export BOSH_DEPLOYMENT=awscli2
cd awscli2-boshrelease
git pull
cd -
bosh deploy awscli2-boshrelease/manifests/awscli2.yml
```
