#!/bin/bash
set -e

echo "Initializing Odoo database..."
python3 /app/odoo/odoo-bin \
    -c /app/odoo.conf \
    -d demo_db \
    -i base \
    --stop-after-init

echo "Starting Odoo normally..."
exec python3 /app/odoo/odoo-bin \
    -c /app/odoo.conf \
    -d demo_db \
    --dev=all
