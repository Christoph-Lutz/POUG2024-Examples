set lines 130 pages 999
col username for a16

select spid, '0x'||trim(leading '0' from lower(rawtohex(saddr))) saddr, sid, s.username username
from v$session s, v$process p where p.addr = s.paddr and s.sid = sys_context('userenv', 'sid');
