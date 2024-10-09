set lines 130 pages 999

select pid, spid, lower(addr), round(pga_used_mem/1024/1024,1) used_mb, round(pga_alloc_mem/1024/1024,1) alloc_mb 
from v$process where addr = (select paddr from v$session where sid = sys_context('userenv','sid'));
