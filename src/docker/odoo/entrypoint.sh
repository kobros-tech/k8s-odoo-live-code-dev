#!/bin/bash
set -e

echo "Starting Odoo..."

exec python3 /app/odoo/odoo-bin \
    -c /app/odoo.conf \
    -d demo_db
    --stop-after-init

exec python3 /app/odoo/odoo-bin \
    -c /app/odoo.conf \
    -d demo_db
    --dev=all
