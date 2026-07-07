--SELECT-запросы
--1
--Название и продолжительность самого длительного трека.
SELECT title, duration FROM tracks
ORDER BY duration DESC 
LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут.
SELECT title FROM tracks
WHERE duration >= 210;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title FROM compilations
WHERE release_year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова.
SELECT nickname FROM performers
WHERE nickname NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my».
SELECT title FROM tracks
WHERE title LIKE '%мой%' OR title LIKE '%my%'';


--2
--Количество исполнителей в каждом жанре
SELECT mg.name, COUNT(pg.performer_id) AS performer_count FROM music_genres mg
LEFT JOIN performers_genres pg ON mg.id = pg.music_genre_id
GROUP BY mg.name;

--Количество треков, вошедших в альбомы 2019–2020 годов
SELECT al.title, COUNT(tr.album_id) AS track_count FROM albums al
LEFT JOIN tracks tr ON al.id = tr.album_id
WHERE year_of_issue BETWEEN 2019 AND 2020
GROUP BY al.title;

--Средняя продолжительность треков по каждому альбому. (Дополнительно добавил окгругление до 2-х знаков)
SELECT al.title, ROUND(AVG(tr.duration), 2) AS avg_duration FROM albums al
LEFT JOIN tracks tr ON al.id = tr.album_id
GROUP BY al.title;

--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT p.nickname FROM performers p
WHERE NOT EXISTS (
    SELECT 1 FROM performers_albums pa
    JOIN albums a ON pa.album_id = a.id
    WHERE pa.performer_id = p.id
      AND a.year_of_issue = 2020
);

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT DISTINCT c.title FROM compilations c
JOIN compilations_tracks ct ON c.id = ct.compilation_id
JOIN tracks tr ON ct.track_id = tr.id
JOIN albums al ON tr.album_id = al.id
JOIN performers_albums pa ON al.id = pa.album_id 
JOIN performers p ON pa.performer_id = p.id 
WHERE p.nickname = 'Freddie Mercury';


--3
--Наименования треков, которые не входят в сборники.
SELECT tr.title FROM tracks tr
LEFT JOIN compilations_tracks ct ON tr.id = ct.track_id 
WHERE ct.track_id IS NULL;

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT DISTINCT p.nickname AS performer, t.title AS track, t.duration FROM performers p
JOIN performers_albums pa ON p.id = pa.performer_id
JOIN albums a ON pa.album_id = a.id
JOIN tracks t ON a.id = t.album_id
WHERE t.duration = (SELECT MIN(duration) FROM tracks);
