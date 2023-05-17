CREATE SCHEMA IF NOT EXISTS jpetstore;
RUNSCRIPT FROM 'classpath:mybatis/jpetstore-schema.sql';
RUNSCRIPT FROM 'classpath:mybatis/jpetstore-dataload.sql';
