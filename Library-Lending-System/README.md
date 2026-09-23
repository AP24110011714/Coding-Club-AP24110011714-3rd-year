# Library Lending System

A relational database system designed to manage library books, physical book copies, members, librarians, borrowing, returns, overdue books, and fines.

## Features

- Manage books and book information
- Manage multiple physical copies of each book
- Track book copy availability
- Register library members
- Manage librarians
- Record book borrowing and returns
- Calculate due dates
- Detect overdue books
- Restrict members with overdue books
- Manage fines and payment status
- View member borrowing history
- Generate book availability reports
- Generate library statistics

## Database Design

The system uses six main tables:

- `books` - Stores book information
- `book_copies` - Stores individual physical copies
- `members` - Stores library member information
- `librarians` - Stores librarian information
- `loans` - Stores borrowing and return transactions
- `fines` - Stores overdue fine information

## Relationships

```text
books
  |
  | 1:N
  |
book_copies
  |
  | 1:N
  |
loans
 /    \
/      \
members  librarians
  |
  |
fines