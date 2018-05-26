create or replace view view_zl_sqjz_jcqk
as

SELECT "sum"(cnt) cnt,"sum"(cnt2) cnt2,"sum"(cnt3) cnt3,"sum"(cnt4) cnt4,"sum"(cnt5) cnt5 FROM

	(--警告
	SELECT 'jg' lx,a.jclb lb,b.f_name lbname,count(1) cnt,0 cnt2,0 cnt3,0 cnt4,0 cnt5 from jz_sqjzryjcxxcjb a left join sys_dictionary b on a.jclb = b.f_code where b.f_typecode = 'SYS082' AND a.jclb='01' group by lb,lbname
		UNION ALL
	--治安处罚
	SELECT 'zacf' lx,a.jclb lb,b.f_name lbname,0 cnt,"count"(1) cnt2,0 cnt3,0 cnt4,0 cnt5 from jz_sqjzryjcxxcjb a left join sys_dictionary b on a.jclb = b.f_code where b.f_typecode = 'SYS082' AND a.jclb='02' OR (b.f_typecode = 'SYS082' AND a.jclb='0201') OR (b.f_typecode = 'SYS082' AND a.jclb='0202') group by lb,lbname
	 UNION ALL
	--减刑
	SELECT 'jx' lx,a.jclb lb,b.f_name lbname,0 cnt,0 cnt2,count(1) cnt3,0 cnt4,0 cnt5 from jz_sqjzryjcxxcjb a left join sys_dictionary b on a.jclb = b.f_code where b.f_typecode = 'SYS082' AND a.jclb='03' group by lb,lbname
	 UNION ALL
	--监外执行人员
	SELECT 'jwzx' lx,a.jzlb lb,b.f_name lbname,0 cnt,0 cnt2,0 cnt3,"count"(1) cnt4,0 cnt5 from jz_jzryjbxx_jz a left join sys_dictionary b on a.jzlb = b.f_code where b.f_typecode = 'SYS017' AND a.jzlb='04' group by lb,lbname
	 UNION 
	--撤销缓刑（假释）
	SELECT 'cxhx' lx,to_char(a.audit,'1') lb,'通过' lbname,0 cnt,0 cnt2,0 cnt3,0 cnt4,"count"(1) cnt5 from 

		(SELECT a.audit,b.f_billid from sys_audit_result a LEFT JOIN sys_audit_apply b ON a.f_applyid=b.f_id WHERE b.f_billid='JZ_TQCXHXXXCJB') a

	group by lb,lbname) a