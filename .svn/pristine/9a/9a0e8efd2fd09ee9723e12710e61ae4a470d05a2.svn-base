CREATE OR REPLACE VIEW public.view_im_userinfo AS 
 SELECT a.f_aid,
    a.f_code,
    a.f_nickname,
    a.f_password,
    b.f_accountid
   FROM im_userinfo a,
    im_userinfo_account b
WHERE a.f_aid = b.f_aid;
