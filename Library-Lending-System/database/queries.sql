USE library_lending_system;


-- 1. View all books
SELECT *
FROM books;


-- 2. View all physical copies
SELECT *
FROM book_copies;


-- 3. Check book availability
SELECT
    b.isbn,
    b.title,
    COUNT(bc.copy_id) AS total_copies,
    SUM(
        CASE
            WHEN bc.status = 'AVAILABLE' THEN 1
            ELSE 0
        END
    ) AS available_copies
FROM books b
LEFT JOIN book_copies bc
    ON b.isbn = bc.isbn
GROUP BY b.isbn, b.title;


-- 4. View all members
SELECT *
FROM members;


-- 5. View member loan history
SELECT
    l.loan_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    bc.copy_id,
    l.borrow_date,
    l.due_date,
    l.return_date,
    l.status
FROM loans l
JOIN members m
    ON l.member_id = m.member_id
JOIN book_copies bc
    ON l.copy_id = bc.copy_id
JOIN books b
    ON bc.isbn = b.isbn
ORDER BY l.borrow_date DESC;


-- 6. Find overdue books
SELECT
    l.loan_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    l.due_date,
    DATEDIFF(CURDATE(), l.due_date) AS days_overdue
FROM loans l
JOIN members m
    ON l.member_id = m.member_id
JOIN book_copies bc
    ON l.copy_id = bc.copy_id
JOIN books b
    ON bc.isbn = b.isbn
WHERE l.return_date IS NULL
AND l.due_date < CURDATE();


-- 7. View overdue books with fines
SELECT
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    l.due_date,
    DATEDIFF(CURDATE(), l.due_date) AS days_overdue,
    f.amount AS fine_amount,
    f.paid
FROM loans l
JOIN members m
    ON l.member_id = m.member_id
JOIN book_copies bc
    ON l.copy_id = bc.copy_id
JOIN books b
    ON bc.isbn = b.isbn
LEFT JOIN fines f
    ON l.loan_id = f.loan_id
WHERE l.return_date IS NULL
AND l.due_date < CURDATE();


-- 8. Library statistics
SELECT
    COUNT(DISTINCT b.isbn) AS total_books,
    COUNT(bc.copy_id) AS total_copies,
    SUM(
        CASE
            WHEN bc.status = 'AVAILABLE' THEN 1
            ELSE 0
        END
    ) AS available_copies,
    SUM(
        CASE
            WHEN bc.status = 'BORROWED' THEN 1
            ELSE 0
        END
    ) AS borrowed_copies
FROM books b
LEFT JOIN book_copies bc
    ON b.isbn = bc.isbn;


-- 9. Count overdue loans
SELECT COUNT(*) AS total_overdue_loans
FROM loans
WHERE return_date IS NULL
AND due_date < CURDATE();


-- 10. View unpaid fines
SELECT
    f.fine_id,
    f.loan_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    f.amount
FROM fines f
JOIN loans l
    ON f.loan_id = l.loan_id
JOIN members m
    ON l.member_id = m.member_id
WHERE f.paid = FALSE;