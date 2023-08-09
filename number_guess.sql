--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guessing_game_db;
--
-- Name: number_guessing_game_db; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guessing_game_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guessing_game_db OWNER TO freecodecamp;

\connect number_guessing_game_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer,
    result integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    date_created text DEFAULT (now())::date
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 1, 565);
INSERT INTO public.games VALUES (2, 1, 71);
INSERT INTO public.games VALUES (3, 2, 951);
INSERT INTO public.games VALUES (4, 2, 828);
INSERT INTO public.games VALUES (5, 1, 328);
INSERT INTO public.games VALUES (6, 1, 592);
INSERT INTO public.games VALUES (7, 1, 158);
INSERT INTO public.games VALUES (8, 3, 166);
INSERT INTO public.games VALUES (9, 3, 631);
INSERT INTO public.games VALUES (10, 4, 751);
INSERT INTO public.games VALUES (11, 4, 615);
INSERT INTO public.games VALUES (12, 3, 857);
INSERT INTO public.games VALUES (13, 3, 825);
INSERT INTO public.games VALUES (14, 3, 353);
INSERT INTO public.games VALUES (15, 5, 5);
INSERT INTO public.games VALUES (16, 6, 522);
INSERT INTO public.games VALUES (17, 6, 428);
INSERT INTO public.games VALUES (18, 7, 874);
INSERT INTO public.games VALUES (19, 7, 91);
INSERT INTO public.games VALUES (20, 6, 264);
INSERT INTO public.games VALUES (21, 6, 373);
INSERT INTO public.games VALUES (22, 6, 376);
INSERT INTO public.games VALUES (23, 8, 217);
INSERT INTO public.games VALUES (24, 8, 220);
INSERT INTO public.games VALUES (25, 9, 604);
INSERT INTO public.games VALUES (26, 9, 638);
INSERT INTO public.games VALUES (27, 8, 488);
INSERT INTO public.games VALUES (28, 8, 846);
INSERT INTO public.games VALUES (29, 8, 966);
INSERT INTO public.games VALUES (30, 10, 706);
INSERT INTO public.games VALUES (31, 10, 510);
INSERT INTO public.games VALUES (32, 11, 583);
INSERT INTO public.games VALUES (33, 11, 397);
INSERT INTO public.games VALUES (34, 10, 748);
INSERT INTO public.games VALUES (35, 10, 834);
INSERT INTO public.games VALUES (36, 10, 492);
INSERT INTO public.games VALUES (37, 12, 414);
INSERT INTO public.games VALUES (38, 12, 391);
INSERT INTO public.games VALUES (39, 13, 167);
INSERT INTO public.games VALUES (40, 13, 973);
INSERT INTO public.games VALUES (41, 12, 408);
INSERT INTO public.games VALUES (42, 12, 89);
INSERT INTO public.games VALUES (43, 12, 769);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'user_1670869072790', '2022-12-12');
INSERT INTO public.users VALUES (2, 'user_1670869072789', '2022-12-12');
INSERT INTO public.users VALUES (3, 'user_1670869082598', '2022-12-12');
INSERT INTO public.users VALUES (4, 'user_1670869082597', '2022-12-12');
INSERT INTO public.users VALUES (5, 'Sam', '2022-12-12');
INSERT INTO public.users VALUES (6, 'user_1670869141876', '2022-12-12');
INSERT INTO public.users VALUES (7, 'user_1670869141875', '2022-12-12');
INSERT INTO public.users VALUES (8, 'user_1670869150866', '2022-12-12');
INSERT INTO public.users VALUES (9, 'user_1670869150865', '2022-12-12');
INSERT INTO public.users VALUES (10, 'user_1670869155345', '2022-12-12');
INSERT INTO public.users VALUES (11, 'user_1670869155344', '2022-12-12');
INSERT INTO public.users VALUES (12, 'user_1670869159621', '2022-12-12');
INSERT INTO public.users VALUES (13, 'user_1670869159620', '2022-12-12');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 43, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 13, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--