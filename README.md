Baton-Okta Helm Chart Documentation
===================================

The Baton-Okta Helm chart simplifies the deployment of the Baton-Okta connector as a Kubernetes cron job. This document guides you through the process of configuring and deploying the chart. It is intended for users with knowledge of Kubernetes and Helm.

Prerequisites
-------------

1.  A running Kubernetes cluster with `kubectl` configured to communicate with it.
2.  Helm (v3 or later) installed on your local machine.

Chart Overview
--------------

The Baton-Okta Helm chart includes the following components:

-   Baton-Okta cron job: Runs the Baton-Okta connector on a specified schedule.
-   Baton-Okta secrets: Contains the required secrets for the connector to access the Okta API and upload results to an S3 bucket.

Configuration
-------------

Before deploying the Helm chart, you must configure the following values in the `values.yaml` file:

  `namespace`: The namespace in which the cron job and secrets will be deployed. By default, it is set to `baton-okta`.

  `okta.apiToken`: The Okta API token as mentioned in the ConductorOne documentation.

  `okta.domain`: The domain used to connect to your Okta instance (e.g., `baton.okta.com`).

  `s3.fileUri`: The S3 File URI string that tells the Baton-Okta connector where and how to upload the sync results to an S3 bucket.

  `schedule`: The schedule for the cron job in Cron format (e.g., `*/5 * * * *` to run every 5 minutes). Adjust it according to your requirements.

Deploying the Helm Chart
------------------------

Follow these steps to deploy the Baton-Okta Helm chart:

1.  Package the chart:

```
$ helm package baton-okta`
```

Install the chart:

```
$ helm install baton-okta ./baton-okta-0.1.0.tgz --namespace <NAMESPACE> --set okta.apiToken=<OKTA_API_TOKEN> --set okta.domain=<OKTA_DOMAIN> --set s3.fileUri=<S3_FILE_URI> [--set schedule=<CRON_JOB_SCHEDULE>]
```
Replace `<NAMESPACE>`, `<OKTA_API_TOKEN>`, `<OKTA_DOMAIN>`, `<S3_FILE_URI>`, and optionally `<CRON_JOB_SCHEDULE>` with the corresponding values.

Verify the deployment:

```
$ kubectl -n <NAMESPACE> get cronjob baton-okta
```

This command lists the deployed Baton-Okta cron job in the specified namespace.

To inspect the logs for a specific job run, find the corresponding pod name and run:

```
$ kubectl -n <NAMESPACE> logs <POD_NAME>
```

Upgrading the Chart
-------------------

To upgrade the chart to a new version, follow these steps:

Package the updated chart:

```
$ helm package baton-okta
```

Upgrade the chart:

```
$ helm upgrade baton-okta ./baton-okta-<NEW_VERSION>.tgz --namespace <NAMESPACE> --reuse-values
```

Replace `<NEW_VERSION>` and `<NAMESPACE>` with the corresponding values.

Uninstalling the Chart
----------------------

To uninstall the Baton-Okta Helm chart, run the following command:

```
$ helm uninstall baton-okta --namespace <NAMESPACE>
```

Replace `<NAMESPACE>` with the namespace where the chart was deployed.
