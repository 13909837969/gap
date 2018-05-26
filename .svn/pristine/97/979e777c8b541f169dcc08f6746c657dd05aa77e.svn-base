CREATE OR REPLACE FUNCTION fun_geterror_organization1()
  RETURNS SETOF core_organization AS
$BODY$
select *  from core_organization o where 
length(o.orgcode) <> 2 * o.lvl and lvl <=3 or length(o.orgcode) <> 10 and lvl > 3;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;