use glpi;

SELECT information_schema.KEY_COLUMN_USAGE.COLUMN_NAME as COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE information_schema.KEY_COLUMN_USAGE.CONSTRAINT_NAME LIKE "PRIMARY" AND
information_schema.KEY_COLUMN_USAGE.TABLE_SCHEMA LIKE "glpi" AND
information_schema.KEY_COLUMN_USAGE.TABLE_NAME LIKE "glpi_tickets";