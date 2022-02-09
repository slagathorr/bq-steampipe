# bq-steampipe

The goal of this is to create a way of being able to query Google Cloud information in BigQuery through [Steampipe](https://steampipe.io/). Steampipe is an open source tool that allows you to query your deployed cloud resources using SQL. Their webpage gives a lot more information on what it does and how it works, but the gist of it is that it allows you to do things like `select * from gcp_compute_instance` across all your cloud resources.

## Deployed Assets
<img src="https://user-images.githubusercontent.com/10038712/153035021-0915f525-9805-4d89-93d5-7ac9cb6f7a7e.png" alt="Architecture Diagram" width="720"/>

At its core, it's just three main things. The Steampipe service is a command line tool, that will be deployed in a [Google Cloud Run service](https://cloud.google.com/run).

Steampipe will be running in [service mode](https://steampipe.io/docs/using-steampipe/service), which will expose a Postgres endpoint. This will stand up a [CloudSQL for Postgres](https://cloud.google.com/sql) instance which will connect to the Steampipe service using the [foreign data wrapper](https://www.postgresql.org/docs/9.5/postgres-fdw.html).

[Google BigQuery](https://cloud.google.com/bigquery) will then use the [external data source](https://cloud.google.com/bigquery/external-data-sources) feature to connect to Cloud SQL.

More details on how these different components is in the following digram.

<img src="https://user-images.githubusercontent.com/10038712/153040356-334fffd3-e61b-4c15-98ef-89d4bec4bc2e.png" alt="Data Connection Diagram" width="720"/>
