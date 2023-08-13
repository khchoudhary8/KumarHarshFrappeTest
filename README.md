
# Frappe Dev Hiring Test


## Shelf Ease Application


Created a user-friendly application for a local library to simplify daily tasks. Librarians can manage books, members, and transactions effortlessly. The system allows CRUD operations on books and members, allows book issuance and returns, searches by all parameters, applies rental fees, and enforces a Rs.500 debt limit for members. Integrated Frappe API enables easy book imports, supporting parameters like title and author. Made simple code structure and clean. Abstracted functions ensure code reusability, with concise SQL queries for efficient data handling. Deployment on Vercel.



## Contents
- Description
- Features 
- Tech Stack
- Screenshots
- How to Run ?
- DB Structure
- API Docs
- Queries
- Contact
## Features
 - Login Authentication and logout
 - Import Books: Librarians can import books into DB (PostGre SQL). Allows Count, Title, Author, Isbn, Publisher, Pages as params.
 - Add / Delete books: Add or Delete books from the postgre SQL. Only unissued books can be deleted.
 - Issue books: Search by title and isbn, allows to list to be produced in front of the librarian, on the detail page, allows the list of members to whom the book can be issued. For issuing, debt must be less that Rs.500
 - Return books:  Showed all the books assigned to members and the librarian can return the book from the member. The dues are recalculated once returned.
 - All penalty: Concisely see the dues on issued books.
 - Montly Report: See the month's report for the amount of transaction and books in stock.
 - Add / Remove members: Add a member to the membership list or delete member if has no pending dues.
 - Search DB: Search the whole DB by 5 params.

 
## Tech Stack

- Flutter
- Dart
- Python
- Flask
- PostgreSQL
- Vercel (For Hosting)
- Supabase (DB hosting)
- Github
## Screenshots



| Login Page  | Home Page | Search Books | Dashboard |
| ------------- | ------------- | ------------- |  ------------- |
| <img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/546fa23d-270b-402a-bbac-4a600353914a.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/b0ed4a9d-7c37-4743-b4cb-0f444c5f1414.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/3eb82318-c0e7-4084-899b-7675e456c7ee.jpg" width="180" height="400"> |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/fdd2eb87-fac0-417f-a932-183ec7e2a0cc.jpg" width="180" height="400"> 

| Profile  | Import Books | Add Books | Import Confirm Screen |
| ------------- | ------------- | ------------- |  ------------- |
| <img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/4da885f3-a161-417d-87fb-79524cfa3d0a.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/d7209e1d-d07a-478b-b265-a0f6b835985e.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/4115f611-b987-4bf7-842a-df8925039796.jpg" width="180" height="400"> |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/5983d1dc-12bf-4457-acba-152181e03d3a.jpg" width="180" height="400"> 

| Issue Books  | Book Detail | Select Member for Issuing | Book Search Result with filters |
| ------------- | ------------- | ------------- |  ------------- |
| <img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/8c941164-b4b3-41ff-bcd5-8ff4411dd667.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/e32f31f7-0ed4-4544-ab27-269e0d2f16b7.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/6e4d88b3-6bd5-4420-9263-d6748bb9dfc2.jpg" width="180" height="400"> |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/d0226286-415b-456a-8d2e-c1e4d702f6d9.jpg" width="180" height="400"> 

| All Members  | Add Members | Report | Members respective books issued |
| ------------- | ------------- | ------------- |  ------------- |
| <img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/7aad5513-8440-4a9b-afba-1ff134c555e5.jpg" width="180" height="400">  |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/b19bb2f0-ce3f-412e-842d-365be8b68d21.jpg" width="180" height="400"> |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/e6f20dbc-7f75-43c6-955c-06f0dd892ddf.jpg" width="180" height="400"> |<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/2f1b0bf7-d0e2-4997-8007-de0ed0d5f2d1.jpg" width="180" height="400">  
## How to Run ?

Download the App's APK file from here: https://drive.google.com/drive/folders/1oqIPQqbu8Rf9z_MVq1O87sr23w7G9uce?usp=sharing

Login Credentials:

username: admin

password: admin_123
## DB Structure & Schemas

<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/4e472df2-318c-417c-859a-ad047a1ba686.png" width="880" height="550"> 


<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/060cdd33-bc78-4972-bb92-fcea1f0148c1.png" width="920" height="550"> 

## API Docs

https://kumar-harsh-frappe-api-dev-hiring-test.vercel.app/

This API uses `POST` request to communicate and HTTP to indenticate status and errors. All responses come in standard JSON. All requests must include a `content-type` of `application/json`, `accept` of `application/json` and the body must be valid JSON.



## Login
**You send:**  Your  login credentials.


**Request:**
```javascript
POST /user/verify
Accept: application/json
Content-Type: application/json

Query: 

{
    'username': 'admin', 
    'password': 'admin_123'
}

**Successful Response:**
200 OK

{
    'users': [{'userid': 1, 'username': 'admin'}, {'userid': 2, 'username': 'devil'}, {'userid': 3, 'username': 'library'}],
    'state': True
 }
```


## Import Data
**You send:**  Optional: title, author, isbn, publisher, pages, count.


**Request:**
```javascript
POST /importData
Accept: application/json
Content-Type: application/json

{
    'count': '30',
     'title': 'witchcraft'
}

**Successful Response:**
200 OK


{
    'message': 'Data imported successfully and Data stored successfully',
 'data': [{'bookID': '2002', 'title': 'Harry Potter Schoolbooks 
 Box Set: Two Classic Books from the Library of Hogwarts School
  of Witchcraft and Wizardry', 'authors': 'J.K. Rowling', 'average_rating':
  '4.40', 'isbn': '043932162X','isbn13': '9780439321624', 'language_code':
    'eng', '  num_pages': '240', 'ratings_count': '11515',
     'text_reviews_count': '139', 'publication_date': '11/1/2001',
      'publisher': 'Arthur A. Levine'}], 'count': 1
}

```



## Search DB
**You send:**  Optional: title, author, isbn, publisher, pages .


**Request:**
```javascript
POST /search/data
Accept: application/json
Content-Type: application/json

select * from shelfease.books_master where title ILIKE '%harry potter boxed%'
{

     'title': 'harry potter boxed'
}


**Successful Response:**
200 OK

{
    'message': 'Success', 'data': [{'  num_pages': 2690, 'authors': 
    'J.K. Rowling/Mary GrandPré', 'average_rating': 4.78, 'bookID': 8,
     'isbn': '0439682584', 'isbn13': '9780439682589', 'language_code':
      'eng', 'publication_date': datetime.date(2004, 9, 13), 'publisher':
       'Scholastic', 'ratings_count': 41428, 'text_reviews_count': 164,
        'title': 'Harry Potter Boxed Set  Books 1-5 (Harry Potter  #1-5)',
         'isAvailable': True, 'issuedate': 0}], 'count': 1
}

```


## Check available before issuing
**You send:**  book_id .


**Request:**
```javascript
POST /isbookavailable
Accept: application/json
Content-Type: application/json


select isavailable from shelfease.books_master where book_id=25257;

{
    'book_id': '25257'
}


**Successful Response:**
200 OK

{
    'available': True
}

```


## Get All members
**You send:**  null .


**Request:**
```javascript
POST /members/all
Accept: application/json
Content-Type: application/json

select * from shelfease.members;

**Successful Response:**
200 OK


{
    'message': 'success', 'data': [{'id': 6, 'name': 'Kumar Harsh', 'email':
     'khchoudhary8@gmail.com', 'phone': '7979844513', 'mem_status': True, 
     'books_id': [26968], 'due_amt': 610}, {'id': 9, 'name': 'Sumeet', 'email':
      'sumeet1709@gmail.com', 'phone': '1111223344', 'mem_status': True, 
      'books_id': [9742, 32816, 2912], 'due_amt': 210}, {'id': 4, 'name': 
      'Will Smith', 'email': 'will.smith@gmail.com', 'phone': '9986754563',
       'mem_status': True, 'books_id': [], 'due_amt': 0}, {'id': 2, 'name':
        'Jane Smith', 'email': 'jane@example.com', 'phone': '987-654-3210',
         'mem_status': True, 'books_id': [], 'due_amt': 0}], 'count': 4
}

```


## Issue Book
**You send:**  book_id and member_id .


**Request:**
```javascript
POST /members/all
Accept: application/json
Content-Type: application/json

{
    'member_id': '4',
     'book_id': '25257'
}

select book_list from shelfease.members where member_id=4
update shelfease.books_master set issuedate=1691931114 where book_id=25257;
update shelfease.books_master set isavailable=false where book_id=25257;
update shelfease.members set book_list=ARRAY[25257] where member_id=4;

**Successful Response:**
200 OK

{
    'message': 'Book Issued'
}

```

## Return Book
**You send:**  book_id and member_id .


**Request:**
```javascript
POST /returnbook
Accept: application/json
Content-Type: application/json

{
    'book_id': '25257',
     'member_id': '4',
      'amt_returned': '1'
}

select book_list from shelfease.members where member_id=4
update shelfease.members set due_amt=0 where member_id=4 ;
update shelfease.members set book_list=ARRAY[]::integer[] where member_id=4;
update shelfease.books_master set issuedate=0 where book_id=25257;
update shelfease.books_master set isavailable=true where book_id=25257;

**Successful Response:**
200 OK

{
    'message': 'Book returned'
}

```


## Add Book

**Request:**
```javascript
POST /addbook
Accept: application/json
Content-Type: application/json

{
    'num_pages': '12', 'authors': 'kumar', 'average_rating': '4', 
    'book_id': '3', 'isbn': '1', 'isbn13': '13', 'language_code': 
    'Ger', 'publication_date': '28-10-2012', 'publisher': 'kumar', 
    'ratings_count': '66', 'text_reviews_count': '13', 'title': 'book1'
}

insert into shelfease.books_master(book_id,title,authors,average_rating,
isbn,isbn13,language_code,num_pages,ratings_count,text_reviews_count,
publication_date,publisher) values (3,'book1','kumar',4.0,'1','13','Ger'
,12,66,13,'28-10-2012','kumar');


**Successful Response:**
200 OK

{
    'message': 'data added successfully'
}

```


## Add Members

You send: name, email, phone
**Request:**
```javascript
POST /addmembers
Accept: application/json
Content-Type: application/json

{
    'name': 'Harsh',
     'email': 'w@gmail.com',
      'phone': '2345678987'
}

insert into shelfease.members (name, email,phone) values ('Harsh','w@gmail.com','2345678987');

**Successful Response:**
200 OK

{
    'message': 'Member added successfully'
}

```


## Delete Members

You send: name, email, phone
**Request:**
```javascript
POST /memberdelete
Accept: application/json
Content-Type: application/json


{
    'member_id': '10'
}


**Successful Response:**
200 OK

{
   'message': 'Delete Successful'

}

```

## Delete Book

You send: name, email, phone
**Request:**
```javascript
POST /bookdelete
Accept: application/json
Content-Type: application/json

{
    'book_id': '44145'
}

delete from shelfease.books_master where book_id=44145

**Successful Response:**
200 OK

{
   'message': 'Delete Successful'

}

```
## Queries

<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/38c0ebfe-a732-45ac-bb34-3801237d83a4.png" width="880" height="550"> 



<img src="https://github.com/khchoudhary8/KumarHarshFrappeApiDevHiringTest/assets/76583677/8cadeb54-b647-4568-b088-d184a9fa5d63.png" width="880" height="550"> 


## Contact

### Thank you

#### Made by Kumar Harsh
#### BIT Mesra
#### khchoudhary8@gmail.com
