--create user
CREATE USER C##af_plsqlauca IDENTIFIED BY auca;
GRANT ALL PRIVILEGES TO C##af_plsqlauca;

----create pdb
SHOW con_name;
ALTER SESSION SET container = CDB$ROOT;
CREATE PLUGGABLE DATABASE af_to_delete_pdb
ADMIN USER af_plsqlauca IDENTIFIED BY auca
FILE_NAME_CONVERT = ('C:\APP\HP\PRODUCT\21C\ORADATA\XE\PDBSEED\', 'C:\APP\HP\PRODUCT\21C\ORADATA\XE\PDBSEED\\no_to_delete_pdb\');
--
----after creation this is how you connecto to pdb
ALTER SESSION SET CONTAINER = CDB$ROOT;
CONNECT SYS/Mamba024 AS SYSDBA;
ALTER PLUGGABLE DATABASE af_to_delete_pdb OPEN;
ALTER SESSION SET CONTAINER = af_to_delete_pdb;

------delete pdb
CONNECT SYS/Mamba024 AS SYSDBA;
ALTER SESSION SET CONTAINER = CDB$ROOT;
ALTER PLUGGABLE DATABASE af_to_delete_pdb CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE af_to_delete_pdb INCLUDING DATAFILES;
SELECT con_id, name, open_mode FROM v$containers;




