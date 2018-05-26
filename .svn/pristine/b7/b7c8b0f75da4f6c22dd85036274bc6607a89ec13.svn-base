CREATE OR REPLACE FUNCTION fun_geterror_organization()
  RETURNS refcursor AS
$BODY$
DECLARE
result refcursor;
BEGIN
open result for select *  from core_organization o where 
length(o.orgcode) <> 2 * o.lvl and lvl <=3 or length(o.orgcode) <> 10 and lvl > 3;
return result;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;