--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sys_rmtj_ywsz; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sys_rmtj_ywsz (
    id character varying(36) NOT NULL,
    lx character varying(20),
    mc character varying(100),
    url character varying(200),
    remark character varying(500),
    sfjy character varying(1),
    vurl character varying(200)
);


ALTER TABLE sys_rmtj_ywsz OWNER TO postgres;

--
-- Data for Name: sys_rmtj_ywsz; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sys_rmtj_ywsz (id, lx, mc, url, remark, sfjy, vurl) FROM stdin;
7	确认	司法确认有关材料	com.ehtsoft.supervise.activity.AddVisitRecordActivity	\N	1	\N
1	申请	人民调解受理登记表	com.ehtsoft.supervise.activity.AddApplyActivity	\N	0	com.ehtsoft.supervise.activity.AddApplyQuearyActivity
2	调查	人民调解调查记录	com.ehtsoft.supervise.activity.AddSurveyRecordsActivity	\N	0	com.ehtsoft.supervise.activity.AddSurveyRecordsActivity
3	取证	人民调解取证材料	com.ehtsoft.supervise.activity.ObtainEvidenceInfoActivity	\N	0	com.ehtsoft.supervise.activity.ObtainEIQuearyActivity
6	回访	人民调解回访记录	com.ehtsoft.supervise.activity.AddVisitRecordActivity	\N	0	com.ehtsoft.supervise.activity.AddVisitRecordActivity
9	封底	封底	com.ehtsoft.supervise.activity.BackCoverActivity	\N	0	com.ehtsoft.supervise.activity.BackCoverActivity
5	协议	人民调解协议书	com.ehtsoft.supervise.activity.PeopleMediateAgreementActivity	\N	0	com.ehtsoft.supervise.activity.PeopleMAQuearyActivity
8	说明	卷宗情况说明	com.ehtsoft.supervise.activity.FileSituationActivity	\N	0	com.ehtsoft.supervise.activity.FileSituationActivity
4	记录	人民调解记录	com.ehtsoft.supervise.activity.AddMediateRecordActivity	\N	0	com.ehtsoft.supervise.activity.AddMRQuearyActivity
\.


--
-- Name: pk_sys_rmtj_ywsz; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sys_rmtj_ywsz
    ADD CONSTRAINT pk_sys_rmtj_ywsz PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

