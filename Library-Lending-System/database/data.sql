USE library_lending_system;


-- 1. Books
INSERT INTO books
(isbn, title, author, publisher, publication_year, category)
VALUES
('9780132350884', 'Clean Code', 'Robert C. Martin',
 'Prentice Hall', 2008, 'Programming'),

('9780262033848', 'Introduction to Algorithms', 'Thomas H. Cormen',
 'MIT Press', 2009, 'Algorithms'),

('9780134685991', 'Effective Java', 'Joshua Bloch',
 'Addison-Wesley', 2018, 'Java'),

('9781492052203', 'Designing Data-Intensive Applications', 'Martin Kleppmann',
 'O''Reilly Media', 2017, 'Database');


-- 2. Physical book copies
INSERT INTO book_copies
(isbn, shelf, section)
VALUES
('9780132350884', 'S1', 'Programming'),
('9780132350884', 'S1', 'Programming'),
('9780132350884', 'S1', 'Programming'),

('9780262033848', 'S2', 'Algorithms'),
('9780262033848', 'S2', 'Algorithms'),

('9780134685991', 'S3', 'Java'),
('9780134685991', 'S3', 'Java'),

('9781492052203', 'S4', 'Database');


-- 3. Members
INSERT INTO members
(first_name, last_name, address, phone, email, membership_date)
VALUES
('Ananya', 'Rao', 'Vijayawada', '9876501234',
 'ananya@example.com', '2026-01-10'),

('Rahul', 'Kumar', 'Guntur', '9876512345',
 'rahul@example.com', '2026-02-15'),

('Priya', 'Sharma', 'Mangalagiri', '9876523456',
 'priya@example.com', '2026-03-05'),

('Arjun', 'Reddy', 'Amaravati', '9876534567',
 'arjun@example.com', '2026-04-12');


-- 4. Librarians
INSERT INTO librarians
(name, email, hire_date)
VALUES
('Ramesh Kumar', 'ramesh@example.com', '2023-06-10'),

('Sneha Rao', 'sneha@example.com', '2024-01-15');


-- 5. Loans
INSERT INTO loans
(copy_id, member_id, issued_by, borrow_date, due_date, return_date, status)
VALUES
(1, 1, 1, '2026-09-01', '2026-09-15',
 NULL, 'OVERDUE'),

(2, 2, 1, '2026-09-05', '2026-09-19',
 NULL, 'OVERDUE'),

(4, 3, 2, '2026-09-20', '2026-10-04',
 NULL, 'BORROWED'),

(6, 4, 2, '2026-09-10', '2026-09-24',
 '2026-09-22', 'RETURNED');


-- 6. Update physical copy status
UPDATE book_copies
SET status = 'BORROWED'
WHERE copy_id IN (1, 2, 4);


-- Returned copy becomes available
UPDATE book_copies
SET status = 'AVAILABLE'
WHERE copy_id = 6;


-- 7. Fines
INSERT INTO fines
(loan_id, amount, paid)
VALUES
(1, 40.00, FALSE),
(2, 60.00, TRUE);