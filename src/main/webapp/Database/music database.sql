--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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

--
-- Name: add_song_for_user(integer, character varying, numeric, character varying, date, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_song_for_user(user_id integer, title character varying, duration numeric, description character varying, release_date date, language character varying, album character varying, song_cover character varying, song_url character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    status INT;
BEGIN
    BEGIN
        INSERT INTO song (title,description, release_date, language,song_url,album,song_cover)
        VALUES (title, description, release_date, language,song_url,get_album_id(album),song_cover)
        RETURNING song_id INTO status;

        INSERT INTO user_song (user_id, song_id)
        VALUES (user_id, status);

        RETURN status;
    EXCEPTION
        WHEN others THEN
            RAISE NOTICE 'An error occurred: %', SQLERRM;
            RETURN -1;
    END;
END;
$$;


ALTER FUNCTION public.add_song_for_user(user_id integer, title character varying, duration numeric, description character varying, release_date date, language character varying, album character varying, song_cover character varying, song_url character varying) OWNER TO postgres;

--
-- Name: delete_album_from_artist(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_album_from_artist() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM album WHERE album.artist = OLD.artist_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.delete_album_from_artist() OWNER TO postgres;

--
-- Name: delete_artist_from_record(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_artist_from_record() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM artist WHERE artist.label_record = OLD.rec_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.delete_artist_from_record() OWNER TO postgres;

--
-- Name: delete_song_reference(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_song_reference() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM user_song WHERE user_song.song_id=OLD.song_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.delete_song_reference() OWNER TO postgres;

--
-- Name: delete_songs_from_album(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_songs_from_album() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM song WHERE song.album = OLD.album_id;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.delete_songs_from_album() OWNER TO postgres;

--
-- Name: get_album_id(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_album_id(name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
total INTEGER;
BEGIN
SELECT album_id INTO total FROM album WHERE album_title ILIKE name || '%';
RETURN total;
END;
$$;


ALTER FUNCTION public.get_album_id(name character varying) OWNER TO postgres;

--
-- Name: get_artist_id(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_artist_id(name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
total INTEGER;
BEGIN
SELECT artist_id INTO total FROM artist WHERE artist_name ILIKE name || '%';
RETURN total;
END;
$$;


ALTER FUNCTION public.get_artist_id(name character varying) OWNER TO postgres;

--
-- Name: get_record_id(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_record_id(title character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
total INT;
BEGIN
SELECT rec_id INTO total FROM record_label where rec_name ILIKE title || '%';
RETURN total;
END;
$$;


ALTER FUNCTION public.get_record_id(title character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album (
    album_id bigint NOT NULL,
    album_title character varying(100) NOT NULL,
    artist bigint NOT NULL,
    description character varying(300) NOT NULL,
    release_date date NOT NULL,
    album_cover character varying(100) NOT NULL,
    user_id integer
);


ALTER TABLE public.album OWNER TO postgres;

--
-- Name: album_album_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.album_album_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.album_album_id_seq OWNER TO postgres;

--
-- Name: album_album_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.album_album_id_seq OWNED BY public.album.album_id;


--
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user (
    user_id bigint NOT NULL,
    full_name character varying(20) NOT NULL,
    email character varying(30) NOT NULL,
    password character varying(20) NOT NULL
);


ALTER TABLE public.app_user OWNER TO postgres;

--
-- Name: app_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_user_id_seq OWNER TO postgres;

--
-- Name: app_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_user_user_id_seq OWNED BY public.app_user.user_id;


--
-- Name: artist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artist (
    artist_id bigint NOT NULL,
    artist_name character varying(100) NOT NULL,
    bio character varying(300) NOT NULL,
    birth_date date NOT NULL,
    debut_date date NOT NULL,
    country character varying(100) NOT NULL,
    label_record bigint NOT NULL,
    artist_pic character varying(100),
    user_id integer
);


ALTER TABLE public.artist OWNER TO postgres;

--
-- Name: artist_artist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artist_artist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artist_artist_id_seq OWNER TO postgres;

--
-- Name: artist_artist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artist_artist_id_seq OWNED BY public.artist.artist_id;


--
-- Name: song; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.song (
    song_id bigint NOT NULL,
    title character varying(100) NOT NULL,
    description character varying(500) NOT NULL,
    release_date date NOT NULL,
    language character varying(100) NOT NULL,
    album bigint NOT NULL,
    song_cover character varying(100) NOT NULL,
    song_url character varying(1000) NOT NULL
);


ALTER TABLE public.song OWNER TO postgres;

--
-- Name: user_song; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_song (
    user_id bigint NOT NULL,
    song_id bigint NOT NULL
);


ALTER TABLE public.user_song OWNER TO postgres;

--
-- Name: main_query; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.main_query AS
 SELECT app_user.user_id,
    song.song_id,
    song.title,
    song.release_date,
    song.language,
    song.album,
    song.song_cover,
    song.song_url
   FROM ((public.app_user
     JOIN public.user_song ON ((app_user.user_id = user_song.user_id)))
     JOIN public.song ON ((user_song.song_id = song.song_id)));


ALTER TABLE public.main_query OWNER TO postgres;

--
-- Name: record_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.record_label (
    rec_id bigint NOT NULL,
    rec_name character varying(100) NOT NULL,
    description character varying(300) NOT NULL,
    founder character varying(100),
    founded_date date NOT NULL,
    country character varying(100),
    cover_url character varying(100) NOT NULL,
    user_id integer
);


ALTER TABLE public.record_label OWNER TO postgres;

--
-- Name: record_label_rec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.record_label_rec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.record_label_rec_id_seq OWNER TO postgres;

--
-- Name: record_label_rec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.record_label_rec_id_seq OWNED BY public.record_label.rec_id;


--
-- Name: song_song_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.song_song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.song_song_id_seq OWNER TO postgres;

--
-- Name: song_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.song_song_id_seq OWNED BY public.song.song_id;


--
-- Name: user_song_song_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_song_song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_song_song_id_seq OWNER TO postgres;

--
-- Name: user_song_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_song_song_id_seq OWNED BY public.user_song.song_id;


--
-- Name: user_song_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_song_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_song_user_id_seq OWNER TO postgres;

--
-- Name: user_song_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_song_user_id_seq OWNED BY public.user_song.user_id;


--
-- Name: album album_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album ALTER COLUMN album_id SET DEFAULT nextval('public.album_album_id_seq'::regclass);


--
-- Name: app_user user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user ALTER COLUMN user_id SET DEFAULT nextval('public.app_user_user_id_seq'::regclass);


--
-- Name: artist artist_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artist ALTER COLUMN artist_id SET DEFAULT nextval('public.artist_artist_id_seq'::regclass);


--
-- Name: record_label rec_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record_label ALTER COLUMN rec_id SET DEFAULT nextval('public.record_label_rec_id_seq'::regclass);


--
-- Name: song song_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song ALTER COLUMN song_id SET DEFAULT nextval('public.song_song_id_seq'::regclass);


--
-- Name: user_song user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_song ALTER COLUMN user_id SET DEFAULT nextval('public.user_song_user_id_seq'::regclass);


--
-- Name: user_song song_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_song ALTER COLUMN song_id SET DEFAULT nextval('public.user_song_song_id_seq'::regclass);


--
-- Data for Name: album; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.album (album_id, album_title, artist, description, release_date, album_cover, user_id) FROM stdin;
\.


--
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user (user_id, full_name, email, password) FROM stdin;
\.


--
-- Data for Name: artist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artist (artist_id, artist_name, bio, birth_date, debut_date, country, label_record, artist_pic, user_id) FROM stdin;
\.


--
-- Data for Name: record_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.record_label (rec_id, rec_name, description, founder, founded_date, country, cover_url, user_id) FROM stdin;
\.


--
-- Data for Name: song; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.song (song_id, title, description, release_date, language, album, song_cover, song_url) FROM stdin;
\.


--
-- Data for Name: user_song; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_song (user_id, song_id) FROM stdin;
\.


--
-- Name: album_album_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.album_album_id_seq', 1, false);


--
-- Name: app_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_user_user_id_seq', 1, false);


--
-- Name: artist_artist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artist_artist_id_seq', 1, false);


--
-- Name: record_label_rec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.record_label_rec_id_seq', 1, false);


--
-- Name: song_song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.song_song_id_seq', 1, false);


--
-- Name: user_song_song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_song_song_id_seq', 1, false);


--
-- Name: user_song_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_song_user_id_seq', 1, false);


--
-- Name: album album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (album_id);


--
-- Name: app_user app_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_key UNIQUE (email);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (user_id);


--
-- Name: artist artist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (artist_id);


--
-- Name: record_label record_label_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record_label
    ADD CONSTRAINT record_label_pkey PRIMARY KEY (rec_id);


--
-- Name: record_label record_label_rec_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record_label
    ADD CONSTRAINT record_label_rec_name_key UNIQUE (rec_name);


--
-- Name: song song_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT song_pkey PRIMARY KEY (song_id);


--
-- Name: user_song user_song_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_song
    ADD CONSTRAINT user_song_pkey PRIMARY KEY (user_id, song_id);


--
-- Name: song before_song_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_song_delete BEFORE DELETE ON public.song FOR EACH ROW EXECUTE FUNCTION public.delete_song_reference();


--
-- Name: artist delete_album_before_artist_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delete_album_before_artist_delete BEFORE DELETE ON public.artist FOR EACH ROW EXECUTE FUNCTION public.delete_album_from_artist();


--
-- Name: record_label delete_artist_before_record_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delete_artist_before_record_delete BEFORE DELETE ON public.record_label FOR EACH ROW EXECUTE FUNCTION public.delete_artist_from_record();


--
-- Name: album delete_songs_after_album_delete; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delete_songs_after_album_delete BEFORE DELETE ON public.album FOR EACH ROW EXECUTE FUNCTION public.delete_songs_from_album();


--
-- Name: song album_ref; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.song
    ADD CONSTRAINT album_ref FOREIGN KEY (album) REFERENCES public.album(album_id);


--
-- Name: album artist_key; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album
    ADD CONSTRAINT artist_key FOREIGN KEY (artist) REFERENCES public.artist(artist_id);


--
-- Name: artist rec_ref; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artist
    ADD CONSTRAINT rec_ref FOREIGN KEY (label_record) REFERENCES public.record_label(rec_id);


--
-- Name: user_song user_song_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_song
    ADD CONSTRAINT user_song_song_id_fkey FOREIGN KEY (song_id) REFERENCES public.song(song_id);


--
-- Name: user_song user_song_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_song
    ADD CONSTRAINT user_song_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.app_user(user_id);


--
-- PostgreSQL database dump complete
--

