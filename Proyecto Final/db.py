from pymongo import MongoClient
MONGO_URI = "mongodb+srv://ezelionel11:tLWTudNCfUdLwaZL@cluster0.trtjkta.mongodb.net/"
client = MongoClient(MONGO_URI)
db = client['biblioteca']
libros_collection = db['libros']
prestamos_collection = db['prestamos']