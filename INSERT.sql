--Заполнение таблиц

INSERT INTO performers(nickname)
VALUES 
	('В. Цой'), 
  	('Юра музыкант'), 
  	('Freddie Mercury'), 
  	('Noize MC'),  
  	('Горшок'), 
  	('Макар'), 
  	('The Beatles'),
	('Eminem'),  
	('Непара');

INSERT INTO music_genres(name)
VALUES 
	('Рок'), 
	('Поп'), 
	('Хип-хоп'),   
	('Рэп');

INSERT INTO albums(title, year_of_issue)
VALUES 
	('46', 1983), 
	('Группа крови', 1988), 
	('Это всё', 1995), 
	('Актриса Весна', 1992), 
	('Live Killers', 1979), 
	('Место, где свет', 2001),
	('Выход в город', 2020), 
	('Новый альбом', 2012), 
	('Камнем по голове', 1996), 
	('Help!', 1965), 
	('Let It Be', 1970),
	('The Slim Shady LP', 1999),
	('Другая семья', 2003);

INSERT INTO tracks(album_id, title, duration)
VALUES 
	(1, 'Троллейбус', 170), 
	(1, 'Транквилизатор', 329),
	(1, 'Дождь для нас', 207),
	(1, 'Пора', 107),
	(1, 'Музыка волн', 166),
	(1, 'Генерал мой', 239),
	(2, 'Закрой за мной дверь, я ухожу', 257),
	(2, 'Спокойная ночь', 368),
	(2, 'Мама, мы все сошли с ума', 248),
	(2, 'Легенда', 249),
	(3, 'Это всё', 466),
	(4, 'Дождь', 304),
	(4, 'В последнюю осень', 285),
	(4, 'Родина', 276),
	(4, 'Что такое осень', 282),
	(5, 'We Will Rock You', 209),
	(5, 'Dont Stop Me Now', 209),
	(5, 'Bohemian Rhapsody', 354),
	(5, 'We are the champions my friend', 180),
	(6, 'Не надо так мой друг', 187),
	(7, 'Вояджер-1', 218),
	(7, 'Сельма Лагерлёф', 195),
	(7, 'Столетняя война', 198),
	(7, 'Песня предателя', 195),
	(7, 'Бизнесмен, что продал мир', 207),
	(7, 'Всё как у людей', 207),
	(7, '26.04', 190),
	(8, 'Бассейн', 216),
	(8, 'Похуисты', 278),
	(8, 'Yes Future!', 189),
	(9, 'Дурак и молния', 114),
	(9, 'Камнем по голове', 180),
	(9, 'Лесник', 191),
	(10, 'Yesterday', 123),
	(10, 'Help!', 136),
	(11, 'Let It Be', 243),
	(12, 'My Name Is', 268),
	(13, 'Будет всё', 197);
	
INSERT INTO compilations(title, release_year)
VALUES 
	('Лучший сборник', 2026), 
	('Рок сборник', 2018), 
	('Русский рок', 2019), 
	('Старые треки', 2020);	


--Связи

INSERT INTO performers_Genres(performer_id, music_genre_id)
VALUES 
	((SELECT id FROM performers WHERE nickname = 'В. Цой'), (SELECT id FROM music_genres WHERE name = 'Рок')),
	((SELECT id FROM performers WHERE nickname = 'Юра музыкант'), (SELECT id FROM music_genres WHERE name = 'Рок')),
	((SELECT id FROM performers WHERE nickname = 'Freddie Mercury'), (SELECT id FROM music_genres WHERE name = 'Рок')),
	((SELECT id FROM performers WHERE nickname = 'Noize MC'), (SELECT id FROM music_genres WHERE name = 'Рэп')),
	((SELECT id FROM performers WHERE nickname = 'Горшок'), (SELECT id FROM music_genres WHERE name = 'Рок')),
	((SELECT id FROM performers WHERE nickname = 'Макар'), (SELECT id FROM music_genres WHERE name = 'Рок')),
	((SELECT id FROM performers WHERE nickname = 'The Beatles'), (SELECT id FROM music_genres WHERE name = 'Рок')),
	((SELECT id FROM performers WHERE nickname = 'Eminem'), (SELECT id FROM music_genres WHERE name = 'Хип-хоп')),
	((SELECT id FROM performers WHERE nickname = 'Eminem'), (SELECT id FROM music_genres WHERE name = 'Рэп')),
	((SELECT id FROM performers WHERE nickname = 'Непара'), (SELECT id FROM music_genres WHERE name = 'Поп'));

INSERT INTO performers_albums(performer_id, album_id)
VALUES 
	((SELECT id FROM performers WHERE nickname = 'В. Цой'), (SELECT id FROM albums WHERE title = '46')),
	((SELECT id FROM performers WHERE nickname = 'В. Цой'), (SELECT id FROM albums WHERE title = 'Группа крови')),
	((SELECT id FROM performers WHERE nickname = 'Юра музыкант'), (SELECT id FROM albums WHERE title = 'Это всё')),
	((SELECT id FROM performers WHERE nickname = 'Юра музыкант'), (SELECT id FROM albums WHERE title = 'Актриса Весна')),
	((SELECT id FROM performers WHERE nickname = 'Freddie Mercury'), (SELECT id FROM albums WHERE title = 'Live Killers')),
	((SELECT id FROM performers WHERE nickname = 'Noize MC'), (SELECT id FROM albums WHERE title = 'Выход в город')),
	((SELECT id FROM performers WHERE nickname = 'Noize MC'), (SELECT id FROM albums WHERE title = 'Новый альбом')),
	((SELECT id FROM performers WHERE nickname = 'Горшок'), (SELECT id FROM albums WHERE title = 'Камнем по голове')),
	((SELECT id FROM performers WHERE nickname = 'Макар'), (SELECT id FROM albums WHERE title = 'Место, где свет')),
	((SELECT id FROM performers WHERE nickname = 'The Beatles'), (SELECT id FROM albums WHERE title = 'Help!')),
	((SELECT id FROM performers WHERE nickname = 'The Beatles'), (SELECT id FROM albums WHERE title = 'Let It Be')),
	((SELECT id FROM performers WHERE nickname = 'Eminem'), (SELECT id FROM albums WHERE title = 'The Slim Shady LP')),
	((SELECT id FROM performers WHERE nickname = 'Непара'), (SELECT id FROM albums WHERE title = 'Другая семья'));

INSERT INTO compilations_tracks (compilation_id,  track_id)
VALUES 
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Музыка волн')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Закрой за мной дверь, я ухожу')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Спокойная ночь')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Мама, мы все сошли с ума')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Легенда')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Это всё')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Дождь')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Dont Stop Me Now')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Bohemian Rhapsody')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Вояджер-1')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Сельма Лагерлёф')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Всё как у людей')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = '26.04')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Лесник')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Yesterday')),
	((SELECT id FROM compilations WHERE title = 'Лучший сборник'), (SELECT id FROM tracks WHERE title = 'Let It Be')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Закрой за мной дверь, я ухожу')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Дождь')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Это всё')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Мама, мы все сошли с ума')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Лесник')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Спокойная ночь')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Легенда')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Dont Stop Me Now')),
	((SELECT id FROM compilations WHERE title = 'Рок сборник'), (SELECT id FROM tracks WHERE title = 'Bohemian Rhapsody')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Дождь')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Лесник')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Закрой за мной дверь, я ухожу')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Спокойная ночь')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Музыка волн')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Легенда')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Мама, мы все сошли с ума')),
	((SELECT id FROM compilations WHERE title = 'Русский рок'), (SELECT id FROM tracks WHERE title = 'Это всё')),
	((SELECT id FROM compilations WHERE title = 'Старые треки'), (SELECT id FROM tracks WHERE title = 'Троллейбус')),
	((SELECT id FROM compilations WHERE title = 'Старые треки'), (SELECT id FROM tracks WHERE title = 'Dont Stop Me Now')),
	((SELECT id FROM compilations WHERE title = 'Старые треки'), (SELECT id FROM tracks WHERE title = 'Yesterday')),
	((SELECT id FROM compilations WHERE title = 'Старые треки'), (SELECT id FROM tracks WHERE title = 'Let It Be')),
	((SELECT id FROM compilations WHERE title = 'Старые треки'), (SELECT id FROM tracks WHERE title = 'Дурак и молния')),
	((SELECT id FROM compilations WHERE title = 'Старые треки'), (SELECT id FROM tracks WHERE title = 'Родина'));
