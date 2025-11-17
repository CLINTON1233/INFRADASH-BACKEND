--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-11-17 22:31:56

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
-- TOC entry 217 (class 1259 OID 16466)
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    "fullName" character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    icon character varying(50) NOT NULL,
    "categoryId" integer NOT NULL,
    status integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.applications OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16471)
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
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 218
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- TOC entry 219 (class 1259 OID 16472)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(255)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16475)
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
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 220
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 224 (class 1259 OID 16692)
-- Name: icons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.icons (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    icon_key character varying(100) NOT NULL,
    category character varying(50),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.icons OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16691)
-- Name: icons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.icons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.icons_id_seq OWNER TO postgres;

--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 223
-- Name: icons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.icons_id_seq OWNED BY public.icons.id;


--
-- TOC entry 221 (class 1259 OID 16476)
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
-- TOC entry 222 (class 1259 OID 16483)
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
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 222
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 4710 (class 2604 OID 16484)
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- TOC entry 4712 (class 2604 OID 16485)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 16695)
-- Name: icons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icons ALTER COLUMN id SET DEFAULT nextval('public.icons_id_seq'::regclass);


--
-- TOC entry 4713 (class 2604 OID 16486)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 4876 (class 0 OID 16466)
-- Dependencies: 217
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, title, "fullName", url, icon, "categoryId", status) FROM stdin;
19	IPAM	IP Addres Management	http://10.5.252.156	Globe	1	1
21	VmWare	Vpshere, Vmware	https://10.5.252.101	Monitor	1	1
20	WLC Controllers	WLC LAN Controllers	https://10.5.252.64:8443	Wifi	1	1
25	Drive	Drive	https://drive.google.com/drive/folders/1MB165zrlJnRILudeJrh5HfMlRglJcF1G	File	11	0
26	Drive	drive	https://drive.google.com/drive/folders/1MB165zrlJnRILudeJrh5HfMlRglJcF1G	File	11	0
24	SMOE	SMOE PORTAL	https://www.smoebatam.com/smoe_portal/home	Globe	1	0
22	Seatrium	Seatrium	https://www.smoebatam.com/smoe_portal/	Server	11	0
23	Network	network	https://myinternship.id/index.php	Network	1	0
27	Smoe Portal	Smoe Batam Portal	https://www.smoebatam.com/smoe_portal/home	Globe	41	1
28	Drive	Document	https://drive.google.com/drive/u/0/my-drive	Folder	11	1
\.


--
-- TOC entry 4878 (class 0 OID 16472)
-- Dependencies: 219
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description) FROM stdin;
1	Network	Network infrastructure and connectivity applications
2	Server	Server management and monitoring applications
3	Cloud	Cloud services and platforms
4	Security	Security and access management applications
5	Database	Database management systems
6	Monitoring	System monitoring and alerting tools
7	Storage	Storage and backup solutions
8	Virtualization	Virtualization and container platforms
9	Collaboration	Collaboration and communication tools
10	Development	Development and DevOps tools
11	Documentation	Documentation and knowledge base systems
12	Automation	Automation and orchestration tools
13	ITSM	IT Service Management applications
14	Backup	Backup and recovery solutions
15	Compliance	Compliance and governance tools
16	Reporting	Reporting and analytics applications
17	API Management	API management and gateway services
18	Identity Management	Identity and access management systems
19	Network Security	Network security appliances and tools
20	Container Platform	Container orchestration platforms
41	Applications	General application systems and software used in IT operations
42	Email System	Corporate email and messaging systems
43	Asset Management	IT asset and inventory management systems
44	Endpoint Management	Management tools for laptops, desktops, and mobile devices
45	Patch Management	Automated software update and patching systems
46	Firewall	Firewall and perimeter security appliances
47	VPN Services	Virtual private network solutions
48	Load Balancer	Traffic distribution and load balancing technologies
49	DNS & DHCP	DNS and DHCP server systems
50	Logging	Centralized logging and log analysis tools
51	Observability	End-to-end observability platforms
53	Messaging Queue	Messaging queue and event streaming systems
54	Data Warehouse	Enterprise data warehouse platforms
55	ETL / Data Pipeline	Data integration and ETL pipeline tools
56	Configuration Management	Tools for managing configuration and infrastructure state
57	SaaS Management	Management of software-as-a-service applications
58	Mobile Device Management	MDM tools for enterprise mobile devices
59	Web Hosting	Web hosting and web server platforms
60	API Gateway	Gateways for managing API traffic and routing
61	Business Intelligence	BI and dashboarding tools
62	Helpdesk	Helpdesk and ticketing systems
63	Project Management	Project collaboration and task management tools
52	AI Tools & Software	Artificial intelligence and machine learning platforms
\.


--
-- TOC entry 4883 (class 0 OID 16692)
-- Dependencies: 224
-- Data for Name: icons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.icons (id, name, icon_key, category, created_at) FROM stdin;
1	Activity	Activity	general	2025-11-17 20:48:45.427132
2	Airplay	Airplay	media	2025-11-17 20:48:45.427132
3	AlertCircle	AlertCircle	feedback	2025-11-17 20:48:45.427132
4	AlertTriangle	AlertTriangle	feedback	2025-11-17 20:48:45.427132
5	AlignCenter	AlignCenter	editor	2025-11-17 20:48:45.427132
6	AlignJustify	AlignJustify	editor	2025-11-17 20:48:45.427132
7	AlignLeft	AlignLeft	editor	2025-11-17 20:48:45.427132
8	AlignRight	AlignRight	editor	2025-11-17 20:48:45.427132
9	Anchor	Anchor	navigation	2025-11-17 20:48:45.427132
10	Aperture	Aperture	media	2025-11-17 20:48:45.427132
11	Archive	Archive	file	2025-11-17 20:48:45.427132
12	ArrowDown	ArrowDown	arrows	2025-11-17 20:48:45.427132
13	ArrowLeft	ArrowLeft	arrows	2025-11-17 20:48:45.427132
14	ArrowRight	ArrowRight	arrows	2025-11-17 20:48:45.427132
15	ArrowUp	ArrowUp	arrows	2025-11-17 20:48:45.427132
16	AtSign	AtSign	communication	2025-11-17 20:48:45.427132
17	Award	Award	general	2025-11-17 20:48:45.427132
18	BarChart	BarChart	data	2025-11-17 20:48:45.427132
19	Battery	Battery	device	2025-11-17 20:48:45.427132
20	BatteryCharging	BatteryCharging	device	2025-11-17 20:48:45.427132
21	Bell	Bell	communication	2025-11-17 20:48:45.427132
22	BellOff	BellOff	communication	2025-11-17 20:48:45.427132
23	Bluetooth	Bluetooth	device	2025-11-17 20:48:45.427132
24	Bold	Bold	editor	2025-11-17 20:48:45.427132
25	Book	Book	education	2025-11-17 20:48:45.427132
26	Bookmark	Bookmark	general	2025-11-17 20:48:45.427132
27	Box	Box	shopping	2025-11-17 20:48:45.427132
28	Briefcase	Briefcase	business	2025-11-17 20:48:45.427132
29	Calendar	Calendar	time	2025-11-17 20:48:45.427132
30	Camera	Camera	media	2025-11-17 20:48:45.427132
31	Cast	Cast	device	2025-11-17 20:48:45.427132
32	Check	Check	feedback	2025-11-17 20:48:45.427132
33	CheckCircle	CheckCircle	feedback	2025-11-17 20:48:45.427132
34	CheckSquare	CheckSquare	feedback	2025-11-17 20:48:45.427132
35	ChevronDown	ChevronDown	arrows	2025-11-17 20:48:45.427132
36	ChevronLeft	ChevronLeft	arrows	2025-11-17 20:48:45.427132
37	ChevronRight	ChevronRight	arrows	2025-11-17 20:48:45.427132
38	ChevronUp	ChevronUp	arrows	2025-11-17 20:48:45.427132
39	Clipboard	Clipboard	file	2025-11-17 20:48:45.427132
40	Clock	Clock	time	2025-11-17 20:48:45.427132
41	Cloud	Cloud	weather	2025-11-17 20:48:45.427132
42	Code	Code	development	2025-11-17 20:48:45.427132
43	Cog	Cog	general	2025-11-17 20:48:45.427132
44	Columns	Columns	layout	2025-11-17 20:48:45.427132
45	Command	Command	development	2025-11-17 20:48:45.427132
46	Compass	Compass	navigation	2025-11-17 20:48:45.427132
47	Copy	Copy	file	2025-11-17 20:48:45.427132
48	CreditCard	CreditCard	finance	2025-11-17 20:48:45.427132
49	Crop	Crop	media	2025-11-17 20:48:45.427132
50	Database	Database	development	2025-11-17 20:48:45.427132
51	Delete	Delete	general	2025-11-17 20:48:45.427132
52	Disc	Disc	media	2025-11-17 20:48:45.427132
53	DollarSign	DollarSign	finance	2025-11-17 20:48:45.427132
54	Download	Download	file	2025-11-17 20:48:45.427132
55	Edit	Edit	editor	2025-11-17 20:48:45.427132
56	ExternalLink	ExternalLink	navigation	2025-11-17 20:48:45.427132
57	Eye	Eye	general	2025-11-17 20:48:45.427132
58	EyeOff	EyeOff	general	2025-11-17 20:48:45.427132
59	Facebook	Facebook	social	2025-11-17 20:48:45.427132
60	FastForward	FastForward	media	2025-11-17 20:48:45.427132
61	Feather	Feather	nature	2025-11-17 20:48:45.427132
62	File	File	file	2025-11-17 20:48:45.427132
63	FileText	FileText	file	2025-11-17 20:48:45.427132
64	Film	Film	media	2025-11-17 20:48:45.427132
65	Filter	Filter	data	2025-11-17 20:48:45.427132
66	Flag	Flag	general	2025-11-17 20:48:45.427132
67	Folder	Folder	file	2025-11-17 20:48:45.427132
68	Gift	Gift	shopping	2025-11-17 20:48:45.427132
69	GitBranch	GitBranch	development	2025-11-17 20:48:45.427132
70	GitCommit	GitCommit	development	2025-11-17 20:48:45.427132
71	GitMerge	GitMerge	development	2025-11-17 20:48:45.427132
72	GitPullRequest	GitPullRequest	development	2025-11-17 20:48:45.427132
73	Globe	Globe	navigation	2025-11-17 20:48:45.427132
74	Grid	Grid	layout	2025-11-17 20:48:45.427132
75	HardDrive	HardDrive	device	2025-11-17 20:48:45.427132
76	Hash	Hash	general	2025-11-17 20:48:45.427132
77	Headphones	Headphones	media	2025-11-17 20:48:45.427132
78	Heart	Heart	general	2025-11-17 20:48:45.427132
79	Home	Home	navigation	2025-11-17 20:48:45.427132
80	Image	Image	media	2025-11-17 20:48:45.427132
81	Inbox	Inbox	communication	2025-11-17 20:48:45.427132
82	Info	Info	feedback	2025-11-17 20:48:45.427132
83	Instagram	Instagram	social	2025-11-17 20:48:45.427132
84	Italic	Italic	editor	2025-11-17 20:48:45.427132
85	Key	Key	security	2025-11-17 20:48:45.427132
86	Layers	Layers	layout	2025-11-17 20:48:45.427132
87	Layout	Layout	layout	2025-11-17 20:48:45.427132
88	LifeBuoy	LifeBuoy	general	2025-11-17 20:48:45.427132
89	Link	Link	navigation	2025-11-17 20:48:45.427132
90	Linkedin	Linkedin	social	2025-11-17 20:48:45.427132
91	List	List	layout	2025-11-17 20:48:45.427132
92	Loader	Loader	feedback	2025-11-17 20:48:45.427132
93	Lock	Lock	security	2025-11-17 20:48:45.427132
94	LogIn	LogIn	security	2025-11-17 20:48:45.427132
95	LogOut	LogOut	security	2025-11-17 20:48:45.427132
96	Mail	Mail	communication	2025-11-17 20:48:45.427132
97	Map	Map	navigation	2025-11-17 20:48:45.427132
98	MapPin	MapPin	navigation	2025-11-17 20:48:45.427132
99	Maximize	Maximize	layout	2025-11-17 20:48:45.427132
100	Meh	Meh	feedback	2025-11-17 20:48:45.427132
101	Menu	Menu	layout	2025-11-17 20:48:45.427132
102	MessageCircle	MessageCircle	communication	2025-11-17 20:48:45.427132
103	MessageSquare	MessageSquare	communication	2025-11-17 20:48:45.427132
104	Mic	Mic	media	2025-11-17 20:48:45.427132
105	Minimize	Minimize	layout	2025-11-17 20:48:45.427132
106	Minus	Minus	math	2025-11-17 20:48:45.427132
107	Monitor	Monitor	device	2025-11-17 20:48:45.427132
108	Moon	Moon	weather	2025-11-17 20:48:45.427132
109	MoreHorizontal	MoreHorizontal	navigation	2025-11-17 20:48:45.427132
110	MoreVertical	MoreVertical	navigation	2025-11-17 20:48:45.427132
111	MousePointer	MousePointer	development	2025-11-17 20:48:45.427132
112	Move	Move	layout	2025-11-17 20:48:45.427132
113	Music	Music	media	2025-11-17 20:48:45.427132
114	Navigation	Navigation	navigation	2025-11-17 20:48:45.427132
115	Navigation2	Navigation2	navigation	2025-11-17 20:48:45.427132
116	Octagon	Octagon	shapes	2025-11-17 20:48:45.427132
117	Package	Package	shopping	2025-11-17 20:48:45.427132
118	Paperclip	Paperclip	file	2025-11-17 20:48:45.427132
119	Pause	Pause	media	2025-11-17 20:48:45.427132
120	PauseCircle	PauseCircle	media	2025-11-17 20:48:45.427132
121	PenTool	PenTool	editor	2025-11-17 20:48:45.427132
122	Percent	Percent	math	2025-11-17 20:48:45.427132
123	Phone	Phone	communication	2025-11-17 20:48:45.427132
124	Play	Play	media	2025-11-17 20:48:45.427132
125	PlayCircle	PlayCircle	media	2025-11-17 20:48:45.427132
126	Plus	Plus	math	2025-11-17 20:48:45.427132
127	PlusCircle	PlusCircle	math	2025-11-17 20:48:45.427132
128	Pocket	Pocket	general	2025-11-17 20:48:45.427132
129	Power	Power	device	2025-11-17 20:48:45.427132
130	Printer	Printer	device	2025-11-17 20:48:45.427132
131	Radio	Radio	media	2025-11-17 20:48:45.427132
132	RefreshCw	RefreshCw	arrows	2025-11-17 20:48:45.427132
133	Repeat	Repeat	media	2025-11-17 20:48:45.427132
134	Rewind	Rewind	media	2025-11-17 20:48:45.427132
135	RotateCw	RotateCw	arrows	2025-11-17 20:48:45.427132
136	Rss	Rss	communication	2025-11-17 20:48:45.427132
137	Save	Save	file	2025-11-17 20:48:45.427132
138	Scissors	Scissors	editor	2025-11-17 20:48:45.427132
139	Search	Search	general	2025-11-17 20:48:45.427132
140	Send	Send	communication	2025-11-17 20:48:45.427132
141	Server	Server	development	2025-11-17 20:48:45.427132
142	Settings	Settings	general	2025-11-17 20:48:45.427132
143	Share	Share	communication	2025-11-17 20:48:45.427132
144	Shield	Shield	security	2025-11-17 20:48:45.427132
145	Shuffle	Shuffle	media	2025-11-17 20:48:45.427132
146	Sidebar	Sidebar	layout	2025-11-17 20:48:45.427132
147	SkipBack	SkipBack	media	2025-11-17 20:48:45.427132
148	SkipForward	SkipForward	media	2025-11-17 20:48:45.427132
149	Slack	Slack	social	2025-11-17 20:48:45.427132
150	Slash	Slash	general	2025-11-17 20:48:45.427132
151	Sliders	Sliders	media	2025-11-17 20:48:45.427132
152	Smartphone	Smartphone	device	2025-11-17 20:48:45.427132
153	Smile	Smile	feedback	2025-11-17 20:48:45.427132
154	Speaker	Speaker	media	2025-11-17 20:48:45.427132
155	Square	Square	shapes	2025-11-17 20:48:45.427132
156	Star	Star	general	2025-11-17 20:48:45.427132
157	StopCircle	StopCircle	media	2025-11-17 20:48:45.427132
158	Sun	Sun	weather	2025-11-17 20:48:45.427132
159	Tablet	Tablet	device	2025-11-17 20:48:45.427132
160	Tag	Tag	shopping	2025-11-17 20:48:45.427132
161	Target	Target	general	2025-11-17 20:48:45.427132
162	Terminal	Terminal	development	2025-11-17 20:48:45.427132
163	ThumbsDown	ThumbsDown	feedback	2025-11-17 20:48:45.427132
164	ThumbsUp	ThumbsUp	feedback	2025-11-17 20:48:45.427132
165	ToggleLeft	ToggleLeft	ui	2025-11-17 20:48:45.427132
166	ToggleRight	ToggleRight	ui	2025-11-17 20:48:45.427132
167	Trash	Trash	general	2025-11-17 20:48:45.427132
168	Trash2	Trash2	general	2025-11-17 20:48:45.427132
169	Trello	Trello	social	2025-11-17 20:48:45.427132
170	TrendingDown	TrendingDown	data	2025-11-17 20:48:45.427132
171	TrendingUp	TrendingUp	data	2025-11-17 20:48:45.427132
172	Triangle	Triangle	shapes	2025-11-17 20:48:45.427132
173	Truck	Truck	shopping	2025-11-17 20:48:45.427132
174	Twitter	Twitter	social	2025-11-17 20:48:45.427132
175	Type	Type	editor	2025-11-17 20:48:45.427132
176	Umbrella	Umbrella	weather	2025-11-17 20:48:45.427132
177	Underline	Underline	editor	2025-11-17 20:48:45.427132
178	Unlock	Unlock	security	2025-11-17 20:48:45.427132
179	Upload	Upload	file	2025-11-17 20:48:45.427132
180	User	User	general	2025-11-17 20:48:45.427132
181	UserCheck	UserCheck	general	2025-11-17 20:48:45.427132
182	UserMinus	UserMinus	general	2025-11-17 20:48:45.427132
183	UserPlus	UserPlus	general	2025-11-17 20:48:45.427132
184	Users	Users	general	2025-11-17 20:48:45.427132
185	Video	Video	media	2025-11-17 20:48:45.427132
186	VideoOff	VideoOff	media	2025-11-17 20:48:45.427132
187	Voicemail	Voicemail	communication	2025-11-17 20:48:45.427132
188	Volume	Volume	media	2025-11-17 20:48:45.427132
189	Volume1	Volume1	media	2025-11-17 20:48:45.427132
190	Volume2	Volume2	media	2025-11-17 20:48:45.427132
191	VolumeX	VolumeX	media	2025-11-17 20:48:45.427132
192	Watch	Watch	device	2025-11-17 20:48:45.427132
193	Wifi	Wifi	device	2025-11-17 20:48:45.427132
194	WifiOff	WifiOff	device	2025-11-17 20:48:45.427132
195	Wind	Wind	weather	2025-11-17 20:48:45.427132
196	X	X	feedback	2025-11-17 20:48:45.427132
197	XCircle	XCircle	feedback	2025-11-17 20:48:45.427132
198	XSquare	XSquare	feedback	2025-11-17 20:48:45.427132
199	Youtube	Youtube	social	2025-11-17 20:48:45.427132
200	Zap	Zap	weather	2025-11-17 20:48:45.427132
201	ZoomIn	ZoomIn	media	2025-11-17 20:48:45.427132
202	ZoomOut	ZoomOut	media	2025-11-17 20:48:45.427132
203	Laptop	Laptop	General	2025-11-17 21:32:04.794737
204	Fingerprint	Fingerprint	Security	2025-11-17 21:32:04.854393
\.


--
-- TOC entry 4880 (class 0 OID 16476)
-- Dependencies: 221
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, nama, email, password, badge, telp, departemen, role, created_at) FROM stdin;
20	Clinton Alfaro	clintonalfaro664@gmail.com	$2b$10$nt18yKTjvk60ORo6PKAc5.HVRLJ1WuO4kBBB4uKGPyi2E1Cbr6vgq	9090223	088270801123	IT Infrastructure	superadmin	2025-11-17 20:58:17.537201
21	Ikhsan Kurniawan	ikhsan.kurniawan@seatrium.com	$2b$10$KEzY6WZNPxDDQx8.BKOLe.WlPPsIIX21iAFdFlOUCuGhO5yRWdNEq	10031059	081372282668	IT Infrastructure	superadmin	2025-11-17 21:03:17.910714
22	Taufik	taufik.hidayat4@seatrium.com	$2b$10$k/mefifnNs1JiLdxGkVLWuC1MGDMoSXhWGl27KigVbYAuS.KEoAwm	102000	082284360944	IT Infrastructure	superadmin	2025-11-17 21:04:48.299111
23	Yovan Sakti	yovan.sakti@seatrium.com	$2b$10$4rmgqKrei9Oy1U0YOFxy6.30rKZ6KG5/Gx7JlBiNck0bF5AJUF14q	10058875	081218982570	IT Infrastructure	superadmin	2025-11-17 21:08:59.406797
18	Fery	fery@gmail.com	$2b$10$hYU4feD35t4zz7EJf5srE.LNi1JPSB9PES8Oj.EaSVA8MrTHuBKUa	12344567	08888912131	IT Infrastructure	admin	2025-10-10 07:36:31.584341
\.


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 218
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_id_seq', 28, true);


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 220
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 66, true);


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 223
-- Name: icons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.icons_id_seq', 204, true);


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 222
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 23, true);


--
-- TOC entry 4725 (class 2606 OID 16488)
-- Name: user PK_cace4a159ff9f2512dd42373760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY (id);


--
-- TOC entry 4727 (class 2606 OID 16490)
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e22" UNIQUE (email);


--
-- TOC entry 4719 (class 2606 OID 16492)
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 16494)
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- TOC entry 4723 (class 2606 OID 16496)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4729 (class 2606 OID 16698)
-- Name: icons icons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.icons
    ADD CONSTRAINT icons_pkey PRIMARY KEY (id);


--
-- TOC entry 4730 (class 2606 OID 16497)
-- Name: applications FK_e8a06d416399a4c08b4a86574bb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT "FK_e8a06d416399a4c08b4a86574bb" FOREIGN KEY ("categoryId") REFERENCES public.categories(id);


-- Completed on 2025-11-17 22:31:57

--
-- PostgreSQL database dump complete
--

