-- View: public.view_jz_collect_info

-- DROP VIEW public.view_jz_collect_info;

CREATE OR REPLACE VIEW public.view_jz_collect_info AS 
 SELECT sf.id AS orgid,
    sf.jgmc,
    cu.f_aid AS gzryid,
    ry.f_nickname AS gzry,
    ry.f_code,
    ry2.f_nickname AS jzry,
    ry2.f_accountid,
    ry2.f_password,
    cu.f_status,
    cu.f_finger,
    cu.f_face,
    cu.f_voice
FROM jz_collect_user cu
     JOIN im_userinfo ry ON cu.f_aid = ry.f_aid
     JOIN view_im_userinfo ry2 ON cu.f_id = ry2.f_aid
     JOIN jc_sfxzjgjbxx sf ON sf.id = cu.orgid;
