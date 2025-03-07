CREATE SCHEMA IF NOT EXISTS jpetstore;
RUNSCRIPT FROM 'classpath:app/jpetstore/common/db/jpetstore-schema.sql';
RUNSCRIPT FROM 'classpath:app/jpetstore/common/db/jpetstore-dataload.sql';
