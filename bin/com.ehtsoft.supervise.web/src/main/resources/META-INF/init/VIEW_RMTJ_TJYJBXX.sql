create or replace view VIEW_RMTJ_TJYJBXX
as
select  a.id,xm,ZW as twhzw,b.jgbm as TWHBM,a.orgid as TWHID,rybm as TJYBM,4 as lx  from jc_sfxzjggzryjbxx a
inner join JC_SFXZJGJBXX b on a.orgid = b.id
union
SELECT id,xm,twhzw,TWHBM,TWHID,TJYBM,5 as lx FROM RMTJ_TJYJBXX

