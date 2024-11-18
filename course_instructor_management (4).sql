DROP DATABASE IF EXISTS course_instructor_management;
CREATE DATABASE course_instructor_management;
USE course_instructor_management;

CREATE TABLE teachers (
    teachers_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT
);

CREATE TABLE course_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    day_of_week ENUM('Понеділок', 'Вівторок', 'Середа', 'Четвер', "П'ятниця", 'Субота') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    teacher_id INT, 
    assigned_date DATE NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teachers_id)  
);

INSERT INTO teachers (first_name, last_name, hire_date, email) VALUES
('Андрій', 'Ніколаєнко', '2020-01-15', 'a.i.nikolaienko@rcit.ukr.education'),
('Вікторія', 'Гонтар', '2012-08-23', 'v.gontar@rcit.ukr.education'),
('Тамара', 'Вербило', '2010-05-11', 't.verbilo@rcit.ukr.education'),
('Тарас', 'Мельник', '2019-09-12', 't.melnik@rcit.ukr.education'),
('Любов', 'Шостак', '2022-02-28', 'l.shostak@rcit.ukr.education'),
('Іван', 'Конончук', '2013-06-19', 'i.kononchuk@rcit.ukr.education'),
('Олександр', 'Шпортько', '2015-01-10','o.shportko@rcit.ukr.education');

INSERT INTO courses (course_name, course_description) VALUES
('База диних', 'ОСнови MySQL'),
('Англіська мова', 'Підвищити рівень володіння англійською мовою'),
('Українська мова', 'Формуванню мовної компетенції студентів '),
('ЯПЗ', 'Тестування програмного забезпечення'),
('АТСД', 'Алгоритми та структури даних'),
('Фізкультура', 'Формуванню активної життєвої позиції студентів'),
('Основи програмування', 'Основи програмування та алготмічної мови');

INSERT INTO assignments (course_id, teacher_id, assigned_date) VALUES 
(1, 1, '2023-09-01'),  -- База Даних Ніколаєнко
(2, 2, '2023-09-01'),  -- Англіська Гонтар
(3, 3, '2023-09-01'),  -- Українська Вербило
(4, 4, '2023-09-01'),  -- ЯПЗ Мельник
(5, 5, '2023-09-01'),  -- АТСД Шостак
(6, 6, '2023-09-01'),  -- Фізкультура Конончук
(7, 7, '2023-09-01');  -- Основи Шпортько


INSERT INTO course_schedule (course_id, day_of_week, start_time, end_time) VALUES
-- Тамара Вербило
(1, 'Понеділок', '08:30:00', '09:50:00'), 
(2, 'Понеділок', '10:00:00', '11:20:00'), 
(3, 'Понеділок', '11:50:00', '13:10:00'),
(4, 'Вівторок', '08:30:00', '09:50:00'), 
(5, 'Вівторок', '10:00:00', '11:20:00'), 
(6, 'Вівторок', '11:50:00', '13:10:00'),
(7, 'Середа', '08:30:00', '09:50:00'), 
(1, 'Середа', '10:00:00', '11:20:00'),
(2, 'Четвер', '08:30:00', '09:50:00'), 
(3, 'Четвер', '10:00:00', '11:20:00'), 
(4, "П'ятниця", '08:30:00', '09:50:00'), 
(5, "П'ятниця", '10:00:00', '11:20:00'),

-- Вікторія Гонтар
(1, 'Понеділок', '13:20:00', '14:40:00'), 
(2, 'Вівторок', '13:20:00', '14:40:00'), 
(3, 'Середа', '13:20:00', '14:40:00'),
(4, 'Четвер', '13:20:00', '14:40:00'), 
(5, "П'ятниця", '11:50:00', '13:10:00'),
(6, 'Субота', '10:00:00', '11:20:00'),

-- Іван Конончук
(1, 'Понеділок', '11:50:00', '13:10:00'), 
(2, 'Вівторок', '08:30:00', '09:50:00'), 
(3, 'Середа', '11:50:00', '13:10:00'),
(4, 'Четвер', '11:50:00', '13:10:00'), 
(5, "П'ятниця", '11:50:00', '13:10:00'),
(6, 'Субота', '11:50:00', '13:10:00'),
(1, 'Понеділок', '10:00:00', '11:20:00'), 
(2, 'Понеділок', '15:00:00', '16:20:00'), 
(3, 'Вівторок', '15:00:00', '16:20:00'),
(4, 'Середа', '15:00:00', '16:20:00'), 
(5, 'Четвер', '15:00:00', '16:20:00'), 
(6, "П'ятниця", '15:00:00', '16:20:00'), 
(7, 'Субота', '15:00:00', '16:20:00');

SELECT * FROM teachers;
SELECT * FROM courses;
SELECT * FROM course_schedule;
SELECT * FROM assignments;

SELECT 
    cs.day_of_week AS "День тижня",
    cs.start_time AS "Початок заняття",
    cs.end_time AS "Кінець заняття",
    c.course_name AS "Назва курсу",
    CONCAT(t.first_name, ' ', t.last_name) AS "Ім’я викладача"
FROM 
    course_schedule as cs
JOIN 
    courses c ON cs.course_id = c.course_id
JOIN 
    assignments a ON c.course_id = a.course_id
JOIN 
    teachers t ON a.teacher_id = t.teachers_id
ORDER BY 
    cs.day_of_week, cs.start_time;
SHOW TABLES;
