import requests

class DataCollector:
    def __init__(self):
        self.url = 'https://frappe.io/api/method/frappe-library'

    def importData(self,reqBody):
        url = self.url 
        count = reqBody.get('count') if reqBody.get('count') else 0
        title = reqBody.get('title') if reqBody.get('title') else None
        authors = reqBody.get('authors') if reqBody.get('authors') else None
        isbn = reqBody.get('isbn') if reqBody.get('isbn') else None
        publisher = reqBody.get('publisher') if reqBody.get('publisher') else None
        page = 1
        masterData = []
        while page<=((int(count)//20)+1):
            params={}
            if int(count)!=0:
                params['page'] = page
            if title!=None:
                params['title'] = title
            if isbn!=None:
                params['isbn'] = isbn
            if publisher!=None:
                params['publisher'] = publisher
            if authors!=None:
                params['authors'] = authors
            res = requests.post(url,params=params)
            if res and res.status_code==200:
                res = res.json()
                res = res.get('message')
                masterData.extend(res)
            page+=1
        masterData=masterData[0:int(count)] #trim to required length
        return masterData