# OpenELIS Global with Odoo invoicing

OpenELIS Global 3.3.0 (the [openelis-docker](https://github.com/DIGI-UW/openelis-docker) 3.3.0 stack)
with [Odoo](https://www.odoo.com) 17 Invoicing. Each time an order is saved in OpenELIS, OpenELIS creates
a draft customer invoice in Odoo for the patient, with one line per billable test.

Guide: [Odoo (Billing / ERP)](https://uwdigi.atlassian.net/wiki/spaces/oeg/pages/1776975920)

## Start

```bash
docker compose up -d
```

The first start takes a few minutes: Odoo creates the database `openelis` with the Invoicing app and the
generic chart of accounts, and OpenELIS waits until Odoo is healthy. Then open:

| Service | URL | User : password |
|---|---|---|
| OpenELIS | <https://localhost> | `admin` : `adminADMIN!` |
| Odoo | <http://localhost:8069> | `admin` : `admin` |

Change the Odoo admin password (and `org.openelisglobal.odoo.password`) before anyone else can reach
the server.

## Try it

1. In OpenELIS, **Order > Add Order**: enter a patient, add a **Whole Blood** sample with **ARV
   resistance** and **CD4 Absolute count (mm3)**, and submit.
2. In Odoo, **Invoicing > Customers > Invoices**: a draft invoice with the reference `OE-<lab number>`,
   the patient as customer and two lines (57.00 and 42.00).

## How it is wired

| Where | What |
|---|---|
| `configs/properties/common.properties` | `org.openelisglobal.odoo.*`: enabled, Odoo address, database, user, password, and the language of the test names in the mapping file |
| `configs/odoo/odoo-test-product-mapping.csv` | Billable tests: OpenELIS test name, invoice line label, quantity, unit price. Tests not listed are not billed |
| `.env` | `ODOO_PORT`, `ODOO_DATABASE` (must match `org.openelisglobal.odoo.database`), `ODOO_DB_PASSWORD` |

OpenELIS logs in to Odoo and reads the mapping file once, at startup. After changing either, run
`docker compose up -d --force-recreate oe.openelis.org`. If Odoo cannot be reached at startup, OpenELIS
runs without invoicing until it is restarted. `https://localhost/api/OpenELIS-Global/health/odoo` shows the state.

## Known limits (OpenELIS 3.3.0)

- Invoice lines carry the label, quantity and price from the mapping file; they are not linked to an Odoo
  product.
- Invoice lines are posted to the account with id 1, which is **101000 Current Assets** on the generic
  chart, instead of an income account. Fix the account on each invoice before confirming it until this is
  corrected in OpenELIS.

## Verified with this setup

On OpenELIS 3.3.0 and Odoo 17: OpenELIS connects at startup, an order with two mapped tests creates draft
invoice `INV/2026/00001` (`OE-<lab number>`, total 99.00) and a customer for the patient.

Everything else (backups, upgrades, certificates, light stack) works as in openelis-docker: see its
[README](https://github.com/DIGI-UW/openelis-docker#readme).
