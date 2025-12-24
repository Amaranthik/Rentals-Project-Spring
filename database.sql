--
-- PostgreSQL database dump
--

\restrict Q0w3IYFg7cd7KJYmjFrRekDZELdAVn2Q5vkj3mjtqqrcEqjeXd4cm3COk1XRMDE

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-25 02:17:25

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
-- TOC entry 226 (class 1259 OID 16538)
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    property_id integer NOT NULL,
    tenant_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    status character varying(20) NOT NULL,
    total_price numeric(10,2),
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT chk_dates CHECK ((end_date >= start_date))
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16537)
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.bookings ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.bookings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16503)
-- Name: properties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.properties (
    id integer NOT NULL,
    owner_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    price_per_month numeric(10,2) NOT NULL,
    address character varying(200) NOT NULL,
    city character varying(100),
    property_type character varying(50),
    area numeric(10,2),
    rooms integer,
    created_at timestamp with time zone DEFAULT now(),
    is_available boolean DEFAULT true
);


ALTER TABLE public.properties OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16502)
-- Name: properties_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.properties ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.properties_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16523)
-- Name: property_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.property_images (
    id integer NOT NULL,
    property_id integer NOT NULL,
    url character varying(255) NOT NULL,
    is_main boolean DEFAULT false
);


ALTER TABLE public.property_images OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16522)
-- Name: property_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.property_images ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.property_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16562)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    property_id integer NOT NULL,
    user_id integer NOT NULL,
    rating integer,
    comment text,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16561)
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16487)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    phone character varying(20),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16486)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4955 (class 0 OID 16538)
-- Dependencies: 226
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, property_id, tenant_id, start_date, end_date, status, total_price, created_at) FROM stdin;
2	2	1	2025-11-26	2025-11-28	Pending	50000.00	2025-11-21 20:12:21.283988+05
3	3	1	2025-09-10	2025-10-10	Confirmed	35000.00	2025-11-21 20:13:18.096833+05
4	4	3	2025-10-01	2025-10-15	Completed	25000.00	2025-11-21 20:13:18.096833+05
5	5	5	2025-11-01	2025-11-20	Pending	60000.00	2025-11-21 20:13:18.096833+05
6	1	1	2025-12-13	2026-04-13	Confirmed	150000.00	2025-12-24 22:55:58.703862+05
7	13	2	2025-12-05	2026-06-25	Confirmed	400000.00	2025-12-25 00:20:48.94278+05
8	1	2	2025-12-25	2025-12-31	Confirmed	100000.00	2025-12-25 00:28:09.995342+05
9	1	2	2025-11-21	2025-11-28	Confirmed	200100.00	2025-12-25 00:48:03.295793+05
\.


--
-- TOC entry 4951 (class 0 OID 16503)
-- Dependencies: 222
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.properties (id, owner_id, title, description, price_per_month, address, city, property_type, area, rooms, created_at, is_available) FROM stdin;
1	2	Квартира на Ленина	Уютная квартира с ремонтом	30000.00	ул. Ленина, 10	Moscow	Apartment	45.50	2	2025-11-21 20:12:21.283988+05	t
2	2	Студия на Пушкина	Маленькая студия в центре	25000.00	ул. Пушкина, 5	Moscow	Studio	30.00	1	2025-11-21 20:12:21.283988+05	t
3	2	Квартира у метро	Уютная 2-комнатная квартира	35000.00	ул. Ленина, 10	Moscow	Apartment	50.00	2	2025-11-21 20:13:18.096833+05	t
4	4	Студия в центре	Современная студия для одного	25000.00	пр. Парковый, 7	Moscow	Studio	25.00	1	2025-11-21 20:13:18.096833+05	t
5	4	Дом на окраине	Просторный дом с садом	60000.00	ул. Солнечная, 15	Moscow	House	120.00	4	2025-11-21 20:13:18.096833+05	t
6	2	Комната в квартире	Комната с мебелью	15000.00	ул. Победы, 22	Moscow	Room	15.00	1	2025-11-21 20:13:18.096833+05	t
7	1	Квартира на Тверской	Светлая и уютная квартира	45000.00	Тверская 10	Moscow	Apartment	55.00	2	2025-11-21 20:14:22.186981+05	t
8	3	Студия в Сколково	Современная студия	35000.00	Сколково 5	Moscow	Studio	25.00	1	2025-11-21 20:14:22.186981+05	t
9	1	Дом на Рублёвке	Просторный дом с садом	120000.00	Рублёвка 7	Moscow	House	200.00	5	2025-11-21 20:14:22.186981+05	t
10	2	Комната в Петербурге	Комната в коммунальной квартире	15000.00	Невский 50	Saint Petersburg	Room	15.00	1	2025-11-21 20:14:22.186981+05	t
11	3	Квартира в Казани	Квартира рядом с метро	25000.00	Баумана 12	Kazan	Apartment	45.00	2	2025-11-21 20:14:22.186981+05	t
12	1	Роскошный пентхаус с видом на Кремль	\N	250000.00	ул. Тверская, д. 1, кв. 777	Москва	Apartment	\N	\N	2025-12-24 21:56:35.999122+05	t
13	1	Уютная студия для студента	\N	60000.00	Ул. Ленина 23/2 	Москва	Studio	\N	\N	2025-12-25 00:19:15.91453+05	t
\.


--
-- TOC entry 4953 (class 0 OID 16523)
-- Dependencies: 224
-- Data for Name: property_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.property_images (id, property_id, url, is_main) FROM stdin;
1	1	img1.jpg	t
2	1	img1_2.jpg	f
3	2	img2.jpg	t
4	3	img1.jpg	t
5	4	img2.jpg	t
6	5	img3.jpg	t
7	6	img4.jpg	t
\.


--
-- TOC entry 4957 (class 0 OID 16562)
-- Dependencies: 228
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, property_id, user_id, rating, comment, created_at) FROM stdin;
1	1	1	5	Отличная квартира, всё понравилось	2025-11-21 20:12:21.283988+05
2	2	1	4	Студия маленькая, но чистая	2025-11-21 20:12:21.283988+05
3	3	1	5	Отличная квартира, чисто и уютно	2025-11-21 20:13:18.096833+05
4	4	3	4	Хорошая студия, но немного шумно	2025-11-21 20:13:18.096833+05
\.


--
-- TOC entry 4949 (class 0 OID 16487)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, email, password_hash, role, phone, created_at) FROM stdin;
2	Петров П.П.	petrov@mail.ru	hash2	Landlord	+79002222222	2025-11-21 20:12:21.283988+05
3	Сидоров Сергей	sidorov@mail.ru	hash3	Tenant	+79003333333	2025-11-21 20:13:18.096833+05
4	Кузнецова Анна	anna@mail.ru	hash4	Landlord	+79004444444	2025-11-21 20:13:18.096833+05
5	Алексеева Мария	maria@mail.ru	hash5	Tenant	+79005555555	2025-11-21 20:13:18.096833+05
1	Иванов И.И.	ivanov@mail.ru	12345	Landlord	+79001111111	2025-11-21 20:12:21.283988+05
9	Александр А.	alex.a@gmail.com	12345	Tenant	+79221233456	2025-12-24 23:38:07.745617+05
12	Дмитрий Ш.О.	example@mail.ru	12345	Tenant	+79224356533	2025-12-25 00:17:03.554774+05
\.


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 225
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_id_seq', 10, true);


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 221
-- Name: properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.properties_id_seq', 13, true);


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 223
-- Name: property_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.property_images_id_seq', 7, true);


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 227
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 4, true);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- TOC entry 4792 (class 2606 OID 16550)
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 16516)
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 16531)
-- Name: property_images property_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property_images
    ADD CONSTRAINT property_images_pkey PRIMARY KEY (id);


--
-- TOC entry 4794 (class 2606 OID 16573)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 16501)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4786 (class 2606 OID 16499)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4797 (class 2606 OID 16551)
-- Name: bookings fk_bookings_property; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- TOC entry 4798 (class 2606 OID 16556)
-- Name: bookings fk_bookings_tenant; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_bookings_tenant FOREIGN KEY (tenant_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4796 (class 2606 OID 16532)
-- Name: property_images fk_images_property; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.property_images
    ADD CONSTRAINT fk_images_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- TOC entry 4795 (class 2606 OID 16517)
-- Name: properties fk_properties_owner; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.properties
    ADD CONSTRAINT fk_properties_owner FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4799 (class 2606 OID 16574)
-- Name: reviews fk_reviews_property; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_reviews_property FOREIGN KEY (property_id) REFERENCES public.properties(id) ON DELETE CASCADE;


--
-- TOC entry 4800 (class 2606 OID 16579)
-- Name: reviews fk_reviews_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-12-25 02:17:26

--
-- PostgreSQL database dump complete
--

\unrestrict Q0w3IYFg7cd7KJYmjFrRekDZELdAVn2Q5vkj3mjtqqrcEqjeXd4cm3COk1XRMDE

