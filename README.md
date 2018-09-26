Barbican policy testing
=======================

This repository is mostly meant for testing purposes. It provides several
scripts to do the following:

* Build a basic barbican container image with a very minimal configuration. The
  configuration uses barbican's unauthenticated context, which makes testing a
  lot easier. This is fine as we're just testing out policy with this.

* Run the barbican container with different, pre-defined policy files

* Create a basic secret (or attempt to)

Files
=====

* **build-barbican-container-image.sh**: As the name suggests, this script will
  build a basic barbican container with the configuration files that are
  included in this repository. The hardcoded resulting tag is
  "barbican-minimal:latest".

* **run-barbican-<suffix>.sh**: These scripts attempt to have self-explanatory
  names, but the main idea with them is that they'll run barbican in a
  container with specific configurations.

* **create-secret.sh**: This will call barbican through the REST API and create
  a secret. If you don't give any arguments, it'll use an empty role. An empty
  role in the unauthenticated context means admin. The first argument you pass
  will be used as a role. So, using `./create-secret.sh reader` will use the
  reader role. Note that the project is hardcoded to '1234'.

* **list-secrets.sh**: This will call barbican through the REST API and list
  the available secrets. If you don't give any arguments, it'll use an empty
  role. An empty role in the unauthenticated context means admin. The first
  argument you pass will be used as a role. So, using
  `./list-secrets.sh reader` will use the reader role. Note that the project
  is hardcoded to '1234'.

* **policy-<name>.json**: These are different policy files that are used in
  different scenarios.

Scenarios
=========

reader role
-----------

In this scenario we change Barbican's observer role and replace it with
'reader'. The policy file that's used in this scenario is
**policy-reader.json**. In order to run a container that takes this policy into
use, you need to run the **run-barbican-with-reader-policy.sh** script.

To verify that this works, do the following:

```bash
# run the container
run-barbican-with-reader-policy.sh

# create a secret
create-secret.sh

# Attempt to list the available secrets with the reader role. This
# operation should succeed.
./list-secrets.sh reader

# Attempt to list the available secrets with the observer role. This
# operation should fail.
./list-secrets.sh observer
```

Note that if you want to try out the next scenario, you need to stop the
container.

Remove audit role
-----------------

Barbican's audit role is meant to only read a very minimal set of things from
the barbican's entities. For some, this role might not be very useful, so lets
delete it!

The policy file that's used in this scenario is **policy-remove-audit.json**,
and in order to run a container that takes this into use, use the
**run-barbican-without-audit-policy.sh** script.

To verify that this works, do the following:

```bash
# run the container
run-barbican-without-audit-policy.sh

# create a secret
create-secret.sh

# Attempt to view the secret metadata with the creator role. This
# operation should succeed.
curl -H 'X-Project-Id: 1234' -H 'X-Roles: creator' \
    http://localhost:9311/v1/secrets/<some ID> | python -m json.tool

# Attempt to view the secret metadata with the creator role. This
# operation should fail.
curl -H 'X-Project-Id: 1234' -H 'X-Roles: audit' \
    http://localhost:9311/v1/secrets/<some ID> | python -m json.tool
```
