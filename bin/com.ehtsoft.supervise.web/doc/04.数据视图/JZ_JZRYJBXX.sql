CREATE OR REPLACE VIEW JZ_JZRYJBXX AS
SELECT
a.RYBS AS ID, --����
a.RYBS AS SQJZRYBH, --����������Ա���
b.SQJZDW as JZJGBM, --������������
CASE WHEN C.RYBS = NULL THEN  0 ELSE 1 END AS SFDCPG, --�Ƿ������
-- D.PGYJ as DCPGYJ, --�����������  ���� �� 2 ��
NULL as DCYJCXQK, --��������������
null as JZLB, --�������
A.SFCN as SFCN, --�Ƿ����
null as WCN, --δ����
A.XM as XM, --����
A.CYM as CYM, --������
A.XB as XB, --�Ա�
A.MZ as MZ, --����
A.SFZH as SFZH, --���֤��
null as CSRQ, --��������
A.YWGATSFZ as YWGATSFZ, --���޸۰�̨���֤
null as GATSFZLX, --�۰�̨���֤����
null as GATSFZHM, --�۰�̨���֤����
A.YWHZ as YWHZ, --���޻���
A.HZHM as HZHM, --���պ���
null as HZBCZT, --���ձ���״̬
A.YWGATTXZ as YWGATTXZ, --���޸۰�̨ͨ��֤
null as GATTXZLX, --�۰�̨ͨ��֤����
A.GATTXZHM as GATTXZHM, --�۰�̨ͨ��֤����
null as GATTXZBCZT, --�۰�̨ͨ��֤����״̬
null as YWGAJMWLNDTXZ, --���޸۰ľ��������ڵ�ͨ ��֤
null as GAJMWLNDTXZ, --�۰ľ��������ڵ�ͨ��֤ ����
null as GAJMWLNDTXZBCZT, --�۰ľ��������ڵ�ͨ��֤ ����״̬
null as YWTBZ, --����̨��֤
null as TBZHM, --̨��֤����
null as TBZBCZT, --̨��֤����״̬
null as ZYJWZXRYSTZK, --�������ִ����Ա����״ ��
null as ZHJZYY, --������ҽԺ
null as SFYJSB, --�Ƿ��о���
A.JDJG as JDJG, --��������
null as SFYCRB, --�Ƿ��д�Ⱦ��
null as JTCRB, --���崫Ⱦ��
null as WHCD, --�Ļ��̶�
A.HYZK as HYZK, --����״��
null as PQZY, --��ǰְҵ
A.JYJXQK as JYJXQK, --��ҵ��ѧ���
null as XZZMM, --��������ò
A.YZZMM as YZZMM, --ԭ������ò
null as YGZDW, --ԭ������λ
A.XGZDW as XGZDW, --�ֹ�����λ
A.DWLXDH as DWLXDH, --��λ��ϵ�绰
A.GRLXDH as GRLXDH, --������ϵ�绰(�ֻ���)
null as QTLXFS, --������ϵ��ʽ
null as GJ, --����
A.YXJTCYJZYSHGX as YXJTCYJZYSHGX, --���޼�ͥ��Ա����Ҫ��� ��ϵ
null as HJDSFYJZDXT, --�������Ƿ����ס����ͬ
A.GDJZDSZS as GDJZDSZS, --�̶���ס������ʡ������ �У�
A.GDJZDSZDS as GDJZDSZDS, --�̶���ס�����ڵأ��С� �ݣ�
A.GDJZDSZXQ as GDJZDSZXQ, --�̶���ס�������أ��С� ����
A.GDJZD as GDJZD, --�̶���ס�أ����򡢽ֵ���
A.GDJZDMX as GDJZDMX, --�̶���ס����ϸ
A.HJSZS as HJSZS, --��������ʡ�������У�
A.HJSZDS as HJSZDS, --�������ڵأ��С��ݣ�
A.HJSZXQ as HJSZXQ, --���������أ��С�����
A.HJSZD as HJSZD, --�������ڵأ����򡢽ֵ���
A.HJSZDMX as HJSZDMX, --�������ڵ���ϸ
null as SFSWRY, --�Ƿ�������Ա
null as JZJG, --��������
null as JZSSSQ, --������������
null as SQJZJDJG, --����������������
null as SQJZJDJGMC, --��������������������
null as ZXTZSWH, --ִ��֪ͨ���ĺ�
null as ZXTZSRQ, --ִ��֪ͨ������
null as JFZXRQ, --����ִ������
null as YJZFJG, --�ƽ��ﷸ����
null as YJZFJGMC, --�ƽ��ﷸ��������
null as SFYQK, --�Ƿ���ǰ��
null as SFLF, --�Ƿ��۷�
null as QKLX, --ǰ������
null as ZYFZSS, --��Ҫ������ʵ
null as SQJZQX, --������������
null as SQJZKSRQ, --����������ʼ����
null as SQJZJSRQ, --����������������
null as FZLX, --��������
null as JTZM, --��������
null as GZQX, --��������
null as HXKYQX, --���̿�������
null as SFSZBF, --�Ƿ����ﲢ��
null as YPXF, --ԭ���̷�
null as YPXQ, --ԭ������
null as YPXQKSRQ, --ԭ�����ڿ�ʼ����
null as YPXQJSRQ, --ԭ�����ڽ�������
null as YQTXQX, --����ͽ������
null as FJX, --������
null as SFWD, --�Ƿ������
null as SFWS, --�Ƿ����桱
null as SFYSS, --�Ƿ��С���ʷ��
null as SFBXGJZL, --�Ƿ������ֹ��
null as SQJZRYJSRQ, --����������Ա��������
null as SQJZRYJSFS, --����������Ա���շ�ʽ
null as FLWSSDSJ, --���������յ�ʱ��
null as FLWSZL, --������������
null as BDQK, --�������
null as SFCJ, --�Ƿ�ɼ����
null as WASBDQKSM, --δ��ʱ�������˵��
null as SFJLJZXZ, --�Ƿ�������С��
null as JZXZRYZCQK, --����С����Ա������
null as SFCYDZDWGL, --�Ƿ���õ��Ӷ�λ����
null as DZDWFS, --���Ӷ�λ��ʽ
null as DWHM, --��λ����
null as DHHBFQH, --�绰�㱨�������
null as DHHBJSH, --�绰�㱨���պ���
null as SFTK, --�Ƿ��ѹ�
null as JCQK, --�������
null as ONLINE1, --�Ƿ�����
null as PJSBH, --�о�����
null as WSLX, --��������
null as PJRQ, --�о�����
null as WSBH, --������
null as WSSXRQ, --������Ч����
null as DEL, --ɾ�����
null as AUDIT1, --��˱��
null as CTS, --����ʱ���
null as UTS, --����ʱ���
null as CDATE, --��������
null as UDATE, --��������
null as CUID, --��ǰ������Ա
null as UUID, --��ǰ������Ա
null as CAID, --��ǰ�����˺�
null as UAID, --��ǰ�����˺�
null as ORGID, --��ǰ����
null as REMARK --��ע
FROM sfszh.T_RYJBXX A
inner join sfszh.T_SQJZDXXX B on A.RYBS = B.RYBS
left join sfszh.T_ZLXGPGJL C on A.RYBS = C.RYBS
left join SFSZH.T_DJPGJL D ON A.RYBS = D.RYBS;
