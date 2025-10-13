--
-- PostgreSQL database dump
--

\restrict ldd5GcABQStY30s4VI4fE7BkNgCy7YxYPgs3u8UzguPKK6iDaN4qUhBzjOpUb4d

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-13 15:58:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16473)
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    "fullName" character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    icon character varying(50) NOT NULL,
    "categoryId" integer CONSTRAINT applications_categoryid_not_null NOT NULL
);


ALTER TABLE public.applications OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16472)
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.applications_id_seq OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 221
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- TOC entry 224 (class 1259 OID 24596)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24595)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 220 (class 1259 OID 16438)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    nama character varying(100),
    email character varying NOT NULL,
    password character varying NOT NULL,
    badge character varying,
    telp character varying,
    departemen character varying,
    role character varying DEFAULT 'admin'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16437)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 4869 (class 2604 OID 16476)
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- TOC entry 4870 (class 2604 OID 24599)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4866 (class 2604 OID 16441)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 5032 (class 0 OID 16473)
-- Dependencies: 222
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.applications VALUES (19, 'IPAM', 'IP Addres Management', 'http://10.5.252.156', 'Globe', 1);
INSERT INTO public.applications VALUES (23, 'Network', 'network', 'https://myinternship.id/index.php', 'Network', 1);
INSERT INTO public.applications VALUES (21, 'VmWare', 'Vpshere, Vmware', 'https://10.5.252.101', 'Monitor', 1);
INSERT INTO public.applications VALUES (20, 'WLC Controllers', 'WLC LAN Controllers', 'https://10.5.252.64:8443', 'Wifi', 1);
INSERT INTO public.applications VALUES (24, 'SMOE', 'SMOE PORTAL', 'https://www.smoebatam.com/smoe_portal/home', 'Globe', 1);
INSERT INTO public.applications VALUES (22, 'Seatrium', 'Seatrium', 'https://www.smoebatam.com/smoe_portal/', 'Server', 11);
INSERT INTO public.applications VALUES (25, 'Drive', 'Drive', 'https://drive.google.com/drive/folders/1MB165zrlJnRILudeJrh5HfMlRglJcF1G', 'File', 11);
INSERT INTO public.applications VALUES (26, 'Drive', 'drive', 'https://drive.google.com/drive/folders/1MB165zrlJnRILudeJrh5HfMlRglJcF1G', 'File', 11);


--
-- TOC entry 5034 (class 0 OID 24596)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (1, 'Network', 'Network infrastructure and connectivity applications');
INSERT INTO public.categories VALUES (2, 'Server', 'Server management and monitoring applications');
INSERT INTO public.categories VALUES (3, 'Cloud', 'Cloud services and platforms');
INSERT INTO public.categories VALUES (4, 'Security', 'Security and access management applications');
INSERT INTO public.categories VALUES (5, 'Database', 'Database management systems');
INSERT INTO public.categories VALUES (6, 'Monitoring', 'System monitoring and alerting tools');
INSERT INTO public.categories VALUES (7, 'Storage', 'Storage and backup solutions');
INSERT INTO public.categories VALUES (8, 'Virtualization', 'Virtualization and container platforms');
INSERT INTO public.categories VALUES (9, 'Collaboration', 'Collaboration and communication tools');
INSERT INTO public.categories VALUES (10, 'Development', 'Development and DevOps tools');
INSERT INTO public.categories VALUES (11, 'Documentation', 'Documentation and knowledge base systems');
INSERT INTO public.categories VALUES (12, 'Automation', 'Automation and orchestration tools');
INSERT INTO public.categories VALUES (13, 'ITSM', 'IT Service Management applications');
INSERT INTO public.categories VALUES (14, 'Backup', 'Backup and recovery solutions');
INSERT INTO public.categories VALUES (15, 'Compliance', 'Compliance and governance tools');
INSERT INTO public.categories VALUES (16, 'Reporting', 'Reporting and analytics applications');
INSERT INTO public.categories VALUES (17, 'API Management', 'API management and gateway services');
INSERT INTO public.categories VALUES (18, 'Identity Management', 'Identity and access management systems');
INSERT INTO public.categories VALUES (19, 'Network Security', 'Network security appliances and tools');
INSERT INTO public.categories VALUES (20, 'Container Platform', 'Container orchestration platforms');


--
-- TOC entry 5030 (class 0 OID 16438)
-- Dependencies: 220
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" VALUES (14, 'daasada', 'das664@gmail.com', '$2b$10$E9nyHO/e7J39XyY2WI8xLOXd/.Zc4gTGHjv5wFur4ZX712mTB9Da.', '312321312', '131312', 'IT Departement', 'superadmin', '2025-10-08 13:51:06.837823');
INSERT INTO public."user" VALUES (15, 'Ikhsan Kurniawan', 'ikhsan664@gmail.com', '$2b$10$54fVAPrl5UqRwwVF/MeA0egnIAeNA99Hy.Ga4ULI90Q8eFJId1xmG', '3131224', '088280801122', 'IT Departement', 'superadmin', '2025-10-08 14:01:44.965208');
INSERT INTO public."user" VALUES (16, 'Yovan Sakti', 'yovan664@gmail.com', '$2b$10$OogWryxTNiWB3ND5XKvGUO41.cRkeUjFnBn9tK8OjyM97Fbh5wIjq', '909088881', '088270801124', 'IT Departement', 'superadmin', '2025-10-09 07:40:56.702483');
INSERT INTO public."user" VALUES (17, 'Clinton alfaro', 'alfaro664@gmail.com', '$2b$10$qGXdX9ocwu3fu7UzoTlzWuyF/CRKefyIoofVuz2cmV.yVfbwV9s.C', '312213412', '088270801123', 'IT Departement', 'superadmin', '2025-10-09 11:33:52.253859');
INSERT INTO public."user" VALUES (19, 'Fery', 'FERR664@gmail.com', '$2b$10$C9lTrFiJv2CVNp3yI.UmD.TLblsx0WRRLDi8V21GPRfSVsqa2Mne.', '124125412', '08888912131', 'IT Developer', 'admin', '2025-10-10 08:51:38.350961');
INSERT INTO public."user" VALUES (13, 'Clinton Alfaro Siagian', 'clintonalfaro664@gmail.com', '$2b$10$ZxU6Jy7jvWjF2/aZxMnHCe9glaH24kdNxC7GPGzlzI/CztcPKMuPa', '90902237565858556', '088270801122', 'IT Developer', 'admin', '2025-10-08 11:48:29.191328');
INSERT INTO public."user" VALUES (18, 'Fery', 'fery@gmail.com', '$2b$10$hYU4feD35t4zz7EJf5srE.LNi1JPSB9PES8Oj.EaSVA8MrTHuBKUa', '12344567', '08888912131', 'IT Infrastructure', 'superadmin', '2025-10-10 07:36:31.584341');


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 221
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_id_seq', 26, true);


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 40, true);


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 19, true);


--
-- TOC entry 4872 (class 2606 OID 16452)
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- TOC entry 4874 (class 2606 OID 16454)
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);


--
-- TOC entry 4876 (class 2606 OID 16485)
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- TOC entry 4878 (class 2606 OID 24605)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4880 (class 2606 OID 24603)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4881 (class 2606 OID 24612)
-- Name: applications FK_e8a06d416399a4c08b4a86574bb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT "FK_e8a06d416399a4c08b4a86574bb" FOREIGN KEY ("categoryId") REFERENCES public.categories(id);


-- Completed on 2025-10-13 15:58:38

--
-- PostgreSQL database dump complete
--

\unrestrict ldd5GcABQStY30s4VI4fE7BkNgCy7YxYPgs3u8UzguPKK6iDaN4qUhBzjOpUb4d

