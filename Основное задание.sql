CREATE TABLE IF NOT EXISTS Music_genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL 
);

CREATE TABLE IF NOT EXISTS Performers (
  id SERIAL PRIMARY KEY,
  nickname VARCHAR(100) NOT NULL 
);

CREATE TABLE IF NOT EXISTS Albums (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  year_of_issue INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Tracks (
  id SERIAL PRIMARY KEY,
  album_id INTEGER NOT NULL REFERENCES Albums(id),
  title VARCHAR(100) NOT NULL,
  duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Compilations (
  id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  release_year INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Performers_Genres (
  music_genre_id INTEGER NOT NULL REFERENCES Music_genres(id),
  performer_id INTEGER NOT NULL REFERENCES Performers(id),
  CONSTRAINT mp PRIMARY KEY (music_genre_id, performer_id)
);

CREATE TABLE IF NOT EXISTS Performers_Albums (
  performer_id INTEGER NOT NULL REFERENCES Performers(id),
  album_id INTEGER NOT NULL REFERENCES Albums(id),
  CONSTRAINT pa PRIMARY KEY (performer_id, album_id)
);

CREATE TABLE IF NOT EXISTS Compilations_Tracks (
  compilation_id INTEGER NOT NULL REFERENCES Compilations(id),
  track_id INTEGER NOT NULL REFERENCES Tracks(id),
  CONSTRAINT ct PRIMARY KEY (compilation_id, track_id)
);