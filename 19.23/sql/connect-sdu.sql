-- Connect to a service using a sdu size of 1234
-- Note: requires a vars.sql file with the appropriate
-- variables defined.
@vars.sql

prompt connect &&test_user/********@...:1521/&&pdb..&&test_domain
connect &&test_user/&&test_user_pwd@&&test_vip:1521/&&pdb..&&test_domain
