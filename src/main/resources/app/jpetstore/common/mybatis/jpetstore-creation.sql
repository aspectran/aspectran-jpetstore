CREATE SCHEMA IF NOT EXISTS jpetstore;
RUNSCRIPT FROM 'classpath:app/jpetstore/common/mybatis/jpetstore-schema.sql';
RUNSCRIPT FROM 'classpath:app/jpetstore/common/mybatis/jpetstore-dataload.sql';
