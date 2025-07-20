from db import prestamos_collection
from libro import actualizar_disponibles, obtener_libro_por_isbn
from datetime import datetime, timedelta
from bson import ObjectId

def prestar_libro(isbn, usuario):
    libro = obtener_libro_por_isbn(isbn)
    if libro and libro['disponibles'] > 0:
        prestamo = {
            "libroId": libro['_id'],
            "usuario": usuario,
            "fechaPrestamo": datetime.now(),
            "fechaDevolucion": datetime.now() + timedelta(days=14),
            "devuelto": False
        }
        resultado = prestamos_collection.insert_one(prestamo)
        actualizar_disponibles(libro['_id'], -1)
        print("Préstamo registrado.")
        return str(resultado.inserted_id)
    else:
        print("No hay libros disponibles.")
        return None

def devolver_libro(prestamo_id):
    prestamo = prestamos_collection.find_one({"_id": ObjectId(prestamo_id)})
    if not prestamo:
        print("Préstamo no encontrado.")
        return
    if prestamo.get("devuelto"):
        print("Este libro ya fue devuelto.")
        return

    prestamos_collection.update_one(
        {"_id": ObjectId(prestamo_id)},
        {"$set": {
            "devuelto": True,
            "fechaDevolucion": datetime.now()
        }}
    )
    actualizar_disponibles(prestamo["libroId"], 1)
    print("Libro devuelto.")


def reporte_populares():
    pipeline = [
        {"$group": {"_id": "$libroId", "total": {"$sum": 1}}},
        {"$sort": {"total": -1}},
        {"$limit": 5}
    ]
    return list(prestamos_collection.aggregate(pipeline))
