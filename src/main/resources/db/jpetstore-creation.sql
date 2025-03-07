CREATE SCHEMA IF NOT EXISTS jpetstore;
RUNSCRIPT FROM 'classpath:db/jpetstore-schema.sql';
RUNSCRIPT FROM 'classpath:db/jpetstore-dataload.sql';
