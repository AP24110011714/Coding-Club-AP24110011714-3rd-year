CREATE DATABASE IF NOT EXISTS library_lending_system;
USE library_lending_system;


-- 1. Books
CREATE TABLE books (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(200) NOT NULL,
    publisher VARCHAR(200),
    publication_year INT,
    category VARCHAR(100)
);


-- 2. Physical book copies
CREATE TABLE book_copies (
    copy_id INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(20) NOT NULL,
    status ENUM('AVAILABLE', 'BORROWED', 'LOST', 'DAMAGED')
        DEFAULT 'AVAILABLE',
    shelf VARCHAR(50),
    section VARCHAR(50),

    FOREIGN KEY (isbn)
        REFERENCES books(isbn)
);


-- 3. Members
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(150) UNIQUE,
    membership_date DATE NOT NULL
);


-- 4. Librarians
CREATE TABLE librarians (
    librarian_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    hire_date DATE NOT NULL
);


-- 5. Loans
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    copy_id INT NOT NULL,
    member_id INT NOT NULL,
    issued_by INT NOT NULL,
    received_by INT,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('BORROWED', 'RETURNED', 'OVERDUE')
        DEFAULT 'BORROWED',

    FOREIGN KEY (copy_id)
        REFERENCES book_copies(copy_id),

    FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    FOREIGN KEY (issued_by)
        REFERENCES librarians(librarian_id),

    FOREIGN KEY (received_by)
        REFERENCES librarians(librarian_id),

    CHECK (due_date >= borrow_date),

    CHECK (
        return_date IS NULL
        OR return_date >= borrow_date
    )
);


-- 6. Fines
CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    paid BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
        ON DELETE CASCADE,

    CHECK (amount >= 0)
);