# bq-steampipe

The goal of this is to create a way of being able to query Google Cloud information in BigQuery through [Steampipe](https://steampipe.io/). Steampipe is an open source tool that allows you to query your deployed cloud resources using SQL. Their webpage gives a lot more information on what it does and how it works, but the gist of it is that it allows you to do things like `select * from gcp_compute_instance` across all your cloud resources.

## Deployed Assets
<img src="https://user-images.githubusercontent.com/10038712/154295740-c34fefd8-9f2f-45b3-9b56-9c44ab8739e5.png" alt="Architecture Diagram" width="720"/>

At its core, it's just three main things. The Steampipe service is a command line tool, that will be deployed in a [Google Compute Engine virtual machine](https://cloud.google.com/compute).

Steampipe will be running in [service mode](https://steampipe.io/docs/using-steampipe/service), which will expose a Postgres endpoint. This will stand up a [CloudSQL for Postgres](https://cloud.google.com/sql) instance which will connect to the Steampipe service using the [foreign data wrapper](https://www.postgresql.org/docs/9.5/postgres-fdw.html).

[Google BigQuery](https://cloud.google.com/bigquery) will then use the [external data source](https://cloud.google.com/bigquery/external-data-sources) feature to connect to Cloud SQL.

More details on how these different components is in the following digram.

<img src="https://user-images.githubusercontent.com/10038712/154295858-b4b489da-8332-45fb-bf5b-d2478b806474.png" alt="Data Connection Diagram" width="720"/>

[Go here for a writeup detailing how this all works, and a step by step guide on how to deploy this](https://briansuk.medium.com/connecting-steampipe-with-google-bigquery-ae37f258090f).
