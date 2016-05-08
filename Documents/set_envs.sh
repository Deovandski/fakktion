#!/bin/bash
# Create Default ENV VARS
echo "SECRET_KEY_BASE=\"$(rake secret)\"" >> /etc/default/locale
echo "RAILS_ENV=\"production\"" >> /etc/default/locale
echo "FAKKTION_DATABASE_USER=\"$USER\"" >> /etc/default/locale
echo "FAKKTION_DATABASE_PASSWORD=\"CHANGE_ME\"" >> /etc/default/locale
echo "FAKKTION_PRODUCTION_DATABASE=\"fakktion\"" >> /etc/default/locale
