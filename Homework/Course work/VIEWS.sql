USE SolarCentury;

-- Представления

-- представление показывает самые востребованные отели  
CREATE OR REPLACE VIEW top_hotels_by_requets (hotel_id, hotel_name) AS
SELECT h.name, COUNT(*) FROM SolarCentury.hotels AS h
JOIN SolarCentury.tours AS t ON h.id = t.hotels_id 
JOIN SolarCentury.orders AS o ON  o.tours_id = t.id
GROUP BY h.name 
;
SELECT * FROM top_hotels_by_requets;

-- представление показывает самые эффективные перевозки (отношение емкости корабля к скорости и удаленности планеты)
CREATE OR REPLACE VIEW top_routers_by_ships (planet_name, ship_name, result_num) AS
SELECT p.name, s.name, ROUND((s.capacity_people/(p.avarage_distatnse/s.speed)),5) as results FROM SolarCentury.planets AS p
JOIN SolarCentury.starships AS s
ORDER BY results DESC -- чем выше индекс, тем выше эфеективность сочетания маршрута и корабля
;
SELECT * FROM top_routers_by_ships;