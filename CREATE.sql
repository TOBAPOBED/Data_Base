--Создание таблиц и связей

CREATE TABLE IF NOT EXISTS music_genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL 
);

CREATE TABLE IF NOT EXISTS performers (
  id SERIAL PRIMARY KEY,
  nickname VARCHAR(100) NOT NULL 
);

CREATE TABLE IF NOT EXISTS albums (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) UNIQUE NOT NULL,
  year_of_issue INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS tracks (
  id SERIAL PRIMARY KEY,
  album_id INTEGER NOT NULL REFERENCES albums(id),
  title VARCHAR(100) NOT NULL,
  duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS compilations (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) UNIQUE NOT NULL,
  release_year INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS performers_genres (
  music_genre_id INTEGER NOT NULL REFERENCES music_genres(id),
  performer_id INTEGER NOT NULL REFERENCES performers(id),
  CONSTRAINT mp PRIMARY KEY (music_genre_id, performer_id)
);

CREATE TABLE IF NOT EXISTS performers_albums (
  performer_id INTEGER NOT NULL REFERENCES performers(id),
  album_id INTEGER NOT NULL REFERENCES albums(id),
  CONSTRAINT pa PRIMARY KEY (performer_id, album_id)
);

CREATE TABLE IF NOT EXISTS compilations_tracks (
  compilation_id INTEGER NOT NULL REFERENCES compilations(id),
  track_id INTEGER NOT NULL REFERENCES tracks(id),
  CONSTRAINT ct PRIMARY KEY (compilation_id, track_id)
);