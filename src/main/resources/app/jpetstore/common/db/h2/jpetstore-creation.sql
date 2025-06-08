CREATE SCHEMA IF NOT EXISTS jpetstore;
RUNSCRIPT FROM 'classpath:app/jpetstore/common/db/h2/jpetstore-schema.sql';
RUNSCRIPT FROM 'classpath:app/jpetstore/common/db/h2/jpetstore-dataload.sql';
