import psycopg2
import json
from datetime import datetime
import time
class DBQueries():
    def __init__(self):
        self.con = psycopg2.connect(
                host = 'db.zgsxrxkgwrqfyzjawfbs.supabase.co',
                database="postgres",
                user="postgres",
                password='7979844513Kh@'
            )
        self.con.autocommit = True   #very important
        self.bookid=0
        self.book={
            'book_id': 0,
            'title':'',
            'authors':'',
            'average_rating':0,
            'isbn':'',
            'isbn13':'',
            'language_code':'',
            'num_pages':0,
            'ratings_count':0,
            'text_reviews_count':0,
            'publication_date':'',
            'publisher':''
        }
        self.member={
            'name':'',
            'email':'',
            'phone':'',
        }
        self.member_id = 0
        self.due = 0
        self.issued= 0
        self.book_list=[]
    def __del__(self):
        if self.con!=None:
            self.con.close()
            print("Connection closed")

    def queries(self,task):
        query={}
        book = self.book
        member= self.member
        query['get_users']='select * from shelfease.users;'
        query['delete_book']=f'delete from shelfease.books_master where book_id={self.bookid}'
        query['delete_member']=f'delete from shelfease.members where member_id={self.member_id}'
        query["get_members"]="select * from shelfease.members;"
        query['bookisavailable'] = f'select isavailable from shelfease.books_master where book_id={self.bookid};'
        query['add_member'] = f"insert into shelfease.members (name, email,phone) values ('{member['name']}','{member['email']}','{member['phone']}');"
        query['add_book'] =f"insert into shelfease.books_master(book_id,title,authors,average_rating,isbn,isbn13,language_code,num_pages,ratings_count,text_reviews_count,publication_date,publisher) values ({book['book_id']},'{book['title']}','{book['authors']}',{book['average_rating']},'{book['isbn']}','{book['isbn13']}','{book['language_code']}',{book['num_pages']},{book['ratings_count']},{book['text_reviews_count']},'{book['publication_date']}','{book['publisher']}');"
        query['get_issued_book_list'] = f'select book_list from shelfease.members where member_id={self.member_id}'
        query['book_issue_date'] = f'select issuedate from shelfease.books_master where book_id={self.bookid}'
        query['set_due'] = f'update shelfease.members set due_amt={self.due} where member_id={self.member_id}'
        query['update_issuedate'] = f'update shelfease.books_master set issuedate={self.issued} where book_id={self.bookid};'
        query['update_avl_status'] = f'update shelfease.books_master set isavailable=false where book_id={self.bookid};'
        query['update_mem_books'] = f'update shelfease.members set book_list=ARRAY{self.book_list} where member_id={self.member_id};'
        query['update_mem_books_hard_refresh']=f'update shelfease.members set book_list=ARRAY{self.book_list}::integer[] where member_id={self.member_id};'
        query['update_due']=f'update shelfease.members set due_amt=0 where member_id={self.member_id} ;'
        query['reset_date']=f'update shelfease.books_master set issuedate=0 where book_id={self.bookid};'
        query['reset_avl']=f'update shelfease.books_master set isavailable=true where book_id={self.bookid};'
        return query.get(task)

    def sqltasks(self,task):
        try:
            con = self.con
            if con!=None:
                print("Connection successful to database")
                cur = con.cursor()
                query=self.queries(task)
                print(query)
                result = None
                if query!=None:
                    cur.execute(query)
                    result = cur.fetchall()
                   
                return result
        except Exception as e:
            print(e)

    def bookisavailable(self,reqBody):
        self.bookid = int(reqBody.get('book_id'))
        state = False
        if self.bookid:
            res = self.sqltasks('bookisavailable')
            res = list(res[0]) if len(res)>0 else []
            if len(res)==1:
                return res[0]
            else :
                return False
        return False
    
    def getDbData(self, reqBody):
        title= reqBody.get('title') if reqBody.get('title') else None
        author= reqBody.get('author') if reqBody.get('author') else None
        isbn= reqBody.get('isbn') if reqBody.get('isbn') else None
        publisher= reqBody.get('publisher') if reqBody.get('publisher') else None
        pages= int(reqBody.get('pages')) if reqBody.get('pages') else 0
        book_id =int(reqBody.get('book_id')) if reqBody.get('book_id') else 0
        
        Data=[]
        query ="select * from shelfease.books_master where"
        print('isbn',isbn)
        if title is not None:
            query+= f" title ILIKE '%{title}%'"  if query[len(query)-5:]=='where' else f" and title ILIKE '%{title}%'"
        if isbn is not None:
            query+= f" isbn ILIKE '%{isbn}%' " if query[len(query)-5:]=='where' else f" and isbn ILIKE '%{isbn}%' "
        if publisher is not None:
            query+= f" publisher ILIKE '%{publisher}%' " if query[len(query)-5:]=='where' else f" and publisher ILIKE '%{publisher}%' "
        if author is not None:
            query+= f" authors ILIKE '%{author}%'" if query[len(query)-5:]=='where' else f" and authors ILIKE '%{author}%'"
        if pages != 0:
            query+= f" num_pages={pages}" if query[len(query)-5:]=='where' else f" and num_pages={pages}"
        if(book_id!=0):
            query+= f" book_id={book_id} " if query[len(query)-5:]=='where' else f" and book_id={book_id} "
        
        if query[len(query)-5:]=='where':
            query+=' true'
        con = self.con
        print(query)
        with con.cursor() as cursor:
            cursor.execute(query)
            Data = cursor.fetchall()

        masterData=[]
        for cur in Data:
            x = {}
            x['  num_pages']=cur[0]
            x['authors']=cur[1]
            x['average_rating']=cur[2]
            x['bookID']=cur[3]
            x['isbn']=cur[4]
            x['isbn13']=cur[5]
            x['language_code']=cur[6]
            x['publication_date']=cur[7]
            x['publisher']=cur[8]
            x['ratings_count']=cur[9]
            x['text_reviews_count']=cur[10]
            x['title']=cur[11]
            x['isAvailable']=cur[13]
            x['issuedate']=cur[14]

            masterData.append(x)
        return masterData

    def getmembers(self):
        masterlist=[]
        masterData=[]
        masterlist= self.sqltasks(task="get_members")
        for cur in masterlist:
            x = {}
            x['id']=cur[0]
            x['name']=cur[1]
            x['email']=cur[2]
            x['phone']=cur[3]
            x['mem_status']=cur[4]
            x['books_id']=cur[5]
            x['due_amt']=cur[6]
            masterData.append(x)
        return masterData

    def verifyuser(self,reqBody):
        username = reqBody.get('username')
        password = reqBody.get('password') 
        userList = self.sqltasks(task='get_users')
        state = False
        masterList = []
        if userList and len(userList)>0:
            for obj in userList:
                cur={}
                userid,user_name,pwd = obj[0],obj[1],obj[2]
                cur={'userid':userid, 'username':user_name}
                masterList.append(cur)
                if user_name == username and password==pwd:
                    state=True
        return state,masterList

    def storeBookData(self,masterList):
        books = []

        # parsing data
        for cur in masterList:
            obj=[]
            obj.append(int(cur.get('bookID'))) if cur.get('bookID') else obj.append(0)
            obj.append(cur.get('title').replace("'", "''")) if cur.get('title') else obj.append(None)
            obj.append(cur.get('authors').replace("'", "''")) if cur.get('authors') else obj.append(None)
            obj.append(float(cur.get('average_rating'))) if cur.get('average_rating') else obj.append(0)
            obj.append(cur.get('isbn')) if cur.get('isbn') else obj.append(None)
            obj.append(cur.get('isbn13')) if cur.get('isbn13') else obj.append(None)
            obj.append(cur.get('language_code')) if cur.get('language_code') else obj.append(None)
            obj.append(int(cur.get('  num_pages'))) if cur.get('  num_pages') else obj.append(0)
            obj.append(int(cur.get('ratings_count'))) if cur.get('ratings_count') else obj.append(0)
            obj.append(int(cur.get('text_reviews_count'))) if cur.get('text_reviews_count') else obj.append(0)
            if cur.get('publication_date'):
                dt = cur.get('publication_date')
                parsed_date = datetime.strptime(dt,'%m/%d/%Y')
                ft_dt = parsed_date.strftime('%Y-%m-%d') 
                obj.append(ft_dt)
            else :
                obj.append(None)
            obj.append(cur.get('publisher').replace("'", "''")) if cur.get('publisher') else obj.append(None)
            obj = tuple(obj)
            books.append(obj)
        con = self.con
        with con.cursor() as cursor:
            txt = ''
            for tpl in books:
                txt = txt + str(tpl) + ','
            txt = txt[:-1].replace('None', "null").replace("'null'", 'null').replace('True','true').replace('False', 'false').replace('"',"'")
            if len(txt) != 0:
                cursor.callproc('shelfease.store_books_data', [txt])

    def addBooks(self,reqBody):
        self.book['num_pages']=int(reqBody['num_pages'])
        self.book['authors'] = reqBody['authors']
        self.book['average_rating']=float(reqBody['average_rating'])
        self.book['book_id']=int(reqBody['book_id'])
        self.book['isbn']=reqBody['isbn']
        self.book['isbn13']=reqBody['isbn13']
        self.book['language_code']=reqBody['language_code']
        self.book['publication_date']=reqBody['publication_date']
        self.book['publisher']=reqBody['publisher']
        self.book['ratings_count']=int(reqBody['ratings_count'])
        self.book['text_reviews_count']=int(reqBody['text_reviews_count'])
        self.book['title']=reqBody['title']
        self.sqltasks('add_book')
        
        
    def addmembers(self,reqBody):
        self.member['name']=(reqBody['name'])
        self.member['email'] = reqBody['email']
        self.member['phone']=(reqBody['phone'])
        self.sqltasks('add_member')
    
    def deleteBook(self,reqBody):
        self.bookid = int(reqBody.get('book_id'))
        self.sqltasks('delete_book')
        
    def deleteMem(self,reqBody):
        self.member_id = int(reqBody.get('member_id'))
        try:
            con=self.con
            if con!=None:
                print("Connection successful to database")
                cur = con.cursor()
                query = f'delete from shelfease.members where member_id={self.member_id}'
                cur.execute(query)
                cur.close()
                return True
        except Exception as e:
            print("Error:", e)
            return False

        
    def issue_book(self, reqBody):
        self.member_id = int(reqBody.get('member_id'))
        book_to_add = int(reqBody.get('book_id'))
        books_issued=self.sqltasks('get_issued_book_list')
        books_issued = list(books_issued[0])
        books_issued=books_issued[0]

        # NOTE: 1. refresh the due amount
        if len(books_issued)>0:
            # calculate dues
            dates=[]
            for book in books_issued:
                self.bookid = int(book)
                dates.extend(list(self.sqltasks('book_issue_date')[0]))
            cur = int(time.time()) # current time in epoch format
            diff=0
            for x in dates:
                diff+=cur-x
            diff = diff//86400 # converted to number of days for penalty
            due = diff*10 # NOTE: 10 rupees per day as penalty
            self.due=due
            self.sqltasks(task='set_due')

        # NOTE: 2. check if the due amount is <= 500
        if self.due<=500:
            books_issued.append(book_to_add)
            self.bookid=book_to_add
            self.issued = int(time.time()) 
            self.book_list=books_issued
            self.sqltasks('update_issuedate')
            self.sqltasks('update_avl_status')
            self.sqltasks('update_mem_books')
            return True
        else:
            return False

    def return_book(self, reqBody):
        self.member_id = int(reqBody.get('member_id'))
        book_to_remove = int(reqBody.get('book_id'))
        self.bookid = book_to_remove
        books_issued=self.sqltasks('get_issued_book_list')
        books_issued = list(books_issued[0])
        books_issued=books_issued[0]
        amt_returned=int(reqBody.get('amt_returned'))
        books_issued.remove(book_to_remove)
        if amt_returned:
            self.sqltasks('update_due')
            if len(books_issued)>0:
            # calculate dues
                dates=[]
                for book in books_issued:
                    self.bookid = int(book)
                    dates.extend(list(self.sqltasks('book_issue_date')[0]))
                cur = int(time.time()) # current time in epoch format
                diff=0
                for x in dates:
                    diff+=cur-x
                diff = diff//86400 # converted to number of days for penalty
                due = diff*10 # NOTE: 10 rupees per day as penalty
                self.due=due
                self.sqltasks(task='set_due')
        self.book_list=books_issued
        self.bookid = book_to_remove
        if len(books_issued)>0:
            self.sqltasks('update_mem_books')
        else:
            self.sqltasks('update_mem_books_hard_refresh')
        self.sqltasks('reset_date')
        self.sqltasks('reset_avl')
        return True


# used for testing purposes only
if __name__ == '__main__':
    reqBody={'username':'library', 'password':'library_2023'}
    masterData  = [{
            "  num_pages": "208",
            "authors": "Rumi/A.J. Arberry",
            "average_rating": "4.28",
            "bookID": "39763",
            "isbn": "0226731510",
            "isbn13": "9780226731513",
            "language_code": "eng",
            "publication_date": "3/15/1974",
            "publisher": "University Of Chicago Press",
            "ratings_count": "114",
            "text_reviews_count": "8",
            "title": "The Mystical Poems of Rumi 1: First Selection  Poems 1-200"
        },
        {
            "  num_pages": "121",
            "authors": "Jorge Luis Borges/Eliot Weinberger",
            "average_rating": "4.33",
            "bookID": "17946",
            "isbn": "0811209059",
            "isbn13": "9780811209052",
            "language_code": "eng",
            "publication_date": "5/29/1985",
            "publisher": "New Directions Publishing Corporation",
            "ratings_count": "1037",
            "text_reviews_count": "60",
            "title": "Seven Nights"
        }]
    due_test={'member_id':'1','book_id':'5700'}
    return_test={'member_id':'6','book_id':'29680','amt_returned':'1'}
    obj = DBQueries()
    print(obj.return_book(return_test))