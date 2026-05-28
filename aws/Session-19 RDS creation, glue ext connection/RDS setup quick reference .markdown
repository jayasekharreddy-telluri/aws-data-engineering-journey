# RDS Postgres — Setup Quick Reference

**For Day 3.5 of the AWS DE Course · Keystone Edtech**

---

## What you're spinning up

A small Postgres instance on RDS, populated with Marketing's `customer_feedback` data. Your Glue job will read from it. Total cost: ~$0.018/hr (db.t3.micro). Delete after the day to avoid charges.

---

## Step-by-step (do this BEFORE class starts)

### 1. Open RDS console
AWS Console → RDS → Databases → **Create database**

### 2. Engine and template
- **Engine type:** PostgreSQL
- **Version:** 16.x (any 16.x works)
- **Templates:** **Free tier**

### 3. Settings
- **DB instance identifier:** `swiggy-feedback-db`
- **Master username:** `postgres`
- **Master password:** *(your choice — write it down)*
- **Confirm password:** *(same as above)*

### 4. Instance configuration
- **DB instance class:** db.t3.micro (auto-selected by Free tier)
- **Storage:** 20 GiB gp2 (default is fine)

### 5. Connectivity — **CRITICAL**
- **VPC:** default VPC (write down the VPC ID — you'll need it for the Glue Connection)
- **Subnet group:** default
- **Public access:** **Yes** (only for class — production should be No)
- **VPC security group:** **Create new** → name: `rds-public-access-sg`
- **Availability Zone:** any
- **Database port:** 5432

### 6. Database authentication
- **Password authentication** ← keep selected

### 7. Additional configuration
- **Initial database name:** leave blank (we'll create `swiggy_external` via the seed script)
- **Backup:** disable (saves cost, fine for class)
- **Encryption:** keep default
- **Maintenance:** keep default

### 8. Click **Create database**
Status will show **Creating** for ~5-10 minutes. Move on with class while it provisions.

---

## After RDS is Available

### 9. Note the endpoint
RDS → Databases → `swiggy-feedback-db` → **Connectivity & security** tab → copy the **Endpoint** (looks like `swiggy-feedback-db.abc123xyz.us-east-1.rds.amazonaws.com`)

### 10. Allow inbound connections from your laptop
- **VPC → Security Groups** → `rds-public-access-sg`
- **Inbound rules** → Edit → Add rule:
  - Type: PostgreSQL
  - Source: My IP
  - Description: `Class - my laptop`
- **Save rules**

### 11. Connect via psql and seed
```bash
psql -h <your-endpoint> -U postgres -d postgres
# Enter password from step 3
```

Once connected:
```sql
\i customer_feedback_seed.sql
```

Or from outside psql:
```bash
psql -h <your-endpoint> -U postgres -d postgres -f customer_feedback_seed.sql
```

Verify:
```sql
\c swiggy_external
SELECT COUNT(*) FROM customer_feedback;
-- Should return 50
```

---

## During class — Glue Connection setup

Your instructor will walk you through:
1. Adding inbound + self-referencing rules to the security group (so Glue can reach the DB)
2. Creating the Glue Connection pointing to your RDS endpoint
3. Testing the connection

You'll need these on hand:
- ✅ RDS endpoint (step 9)
- ✅ Master password (step 3)
- ✅ Database name: `swiggy_external`
- ✅ VPC ID (step 5)
- ✅ Security group ID for `rds-public-access-sg`

---

## After class — TEAR IT DOWN

**Don't forget — RDS bills hourly even when idle.**

RDS → Databases → `swiggy-feedback-db` → **Actions** → **Delete**
- ☐ Create final snapshot: **No**
- ☐ Retain automated backups: **No**
- ✓ Acknowledge → type `delete me`

VPC → Security Groups → `rds-public-access-sg` → Delete (only after RDS is gone)

---

## Common issues

**"Could not connect" from psql** → Security group inbound rule for your IP missing or wrong. Re-check step 10.

**RDS stuck in "Creating" > 15 min** → Try a different AZ. Some AZs have capacity issues.

**Forgot the master password** → Modify DB instance → Set new master password → Apply immediately. Wait ~2 min for it to take effect.

**psql command not found** → Install: `brew install postgresql` (Mac), `sudo apt install postgresql-client` (Ubuntu), or use the AWS Cloud9 / CloudShell terminal which has it pre-installed.
