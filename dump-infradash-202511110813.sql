--
-- PostgreSQL database dump
--

\restrict 5ptBZat4yx1oqX7UUCT9fka6mGtKSqmZMNbjtAlkMdv7C8ctVCjzPVSIdNE52bV

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-11 08:13:14

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
    "categoryId" integer CONSTRAINT applications_categoryid_not_null NOT NULL,
    status integer DEFAULT 1 NOT NULL
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
-- TOC entry 5041 (class 0 OID 0)
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
-- TOC entry 5042 (class 0 OID 0)
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
-- TOC entry 5043 (class 0 OID 0)
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
-- TOC entry 4871 (class 2604 OID 24599)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4866 (class 2604 OID 16441)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 5033 (class 0 OID 16473)
-- Dependencies: 222
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.applications VALUES (19, 'IPAM', 'IP Addres Management', 'http://10.5.252.156', 'Globe', 1, 1);
INSERT INTO public.applications VALUES (31, 'VmWare', 'VmWare, Vsphere', 'https://10.5.252.101', 'Monitor', 1, 1);
INSERT INTO public.applications VALUES (32, 'Seatrium', 'Seatrium', 'https://seatrium.com/brazil-en.php', 'Globe', 2, 1);
INSERT INTO public.applications VALUES (20, 'WLC Controllers', 'WLC LAN Controllers', 'https://10.5.252.64:8443', 'Wifi', 1, 0);
INSERT INTO public.applications VALUES (34, 'Ms Office', 'Ms Office', 'https://www.office.com/', 'File', 11, 0);
INSERT INTO public.applications VALUES (35, 'WLC Controllers', 'WLC LAN Controllers', 'https://10.5.252.64:8443', 'Wifi', 1, 1);
INSERT INTO public.applications VALUES (33, 'Drive', 'Drive Documentation', 'https://drive.google.com/drive/', 'File', 11, 0);


--
-- TOC entry 5035 (class 0 OID 24596)
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
-- TOC entry 5031 (class 0 OID 16438)
-- Dependencies: 220
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" VALUES (16, 'Yovan Sakti', 'yovan664@gmail.com', '$2b$10$OogWryxTNiWB3ND5XKvGUO41.cRkeUjFnBn9tK8OjyM97Fbh5wIjq', '909088881', '088270801124', 'IT Departement', 'superadmin', '2025-10-09 07:40:56.702483');
INSERT INTO public."user" VALUES (22, 'fery yansyah', 'feryyansyah@gmail.com', '$2b$10$lmmlsRcv5TbMxArDwH2B9O.V1CJMwtndEwBYkuJYQpaHRK7YVcD/K', '1122121', '0898909', 'IT', 'superadmin', '2025-11-10 15:30:15.308186');
INSERT INTO public."user" VALUES (23, 'robie darma', 'robiedarma@gmail.com', '$2b$10$7IeOX6kF0oyRe.yjQelj2elcHFoy/8B7hl9NVNltt8WSxgfWXNVLG', '567890', '08825654645', 'IT', 'admin', '2025-11-10 15:46:29.879932');
INSERT INTO public."user" VALUES (24, 'Roihan Habibi', 'roihanhabibi@gmail.com', '$2b$10$2GiZ6NaO/nloJ3qk6cQYYeDRDcNCT8kGdceYbPVrVoprn8x.X8u/G', '9090898', '08827097987', 'IT', 'admin', '2025-11-11 07:47:00.178957');
INSERT INTO public."user" VALUES (25, 'Ikhsan Kurniawan', 'ikhsan.kurniawan@seatrium.com', '$2b$10$Kwl2676XJiuBgUvEuiLFdubhwL/1HyRdV8g4Utbnh2rbgJ/MedvX6', '10031059', '081372282668', 'IT ', 'superadmin', '2025-11-11 07:51:45.288084');
INSERT INTO public."user" VALUES (26, 'Clinton Alfaro', 'clintonalfaro664@gmail.com', '$2b$10$K48cDuiPGJ3KKovdWp0eOOPMpg42Ww5yKQZk0qxXc5ES29CAb2gk6', '9090223', '088270801123', 'IT', 'superadmin', '2025-11-11 08:07:21.816853');


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 221
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_id_seq', 35, true);


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 40, true);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 219
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 26, true);


--
-- TOC entry 4873 (class 2606 OID 16452)
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 16454)
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);


--
-- TOC entry 4877 (class 2606 OID 16485)
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- TOC entry 4879 (class 2606 OID 24605)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4881 (class 2606 OID 24603)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 24612)
-- Name: applications FK_e8a06d416399a4c08b4a86574bb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT "FK_e8a06d416399a4c08b4a86574bb" FOREIGN KEY ("categoryId") REFERENCES public.categories(id);


-- Completed on 2025-11-11 08:13:14

--
-- PostgreSQL database dump complete
--

\unrestrict 5ptBZat4yx1oqX7UUCT9fka6mGtKSqmZMNbjtAlkMdv7C8ctVCjzPVSIdNE52bV

