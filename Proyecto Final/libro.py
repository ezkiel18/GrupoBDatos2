from db import libros_collection
from bson import ObjectId
import re

def es_isbn_valido(isbn):
    return bool(re.match(r"^[\d-]{10,}$", isbn))

def agregar_libro(libro):
    isbn = libro.get("isbn")

    if not es_isbn_valido(isbn):
        print("ISBN inválido. Debe tener al menos 10 dígitos o incluir guiones correctamente.")
        return

    libro_existente = libros_collection.find_one({"isbn": isbn})

    if libro_existente:
        libros_collection.update_one(
            {"_id": libro_existente["_id"]},
            {"$inc": {
                "copias": libro["copias"],
                "disponibles": libro["disponibles"]
            }}
        )
        print("Libro ya existente, se sumaron las copias.")
    else:
        libros_collection.insert_one(libro)
        print("Libro agregado exitosamente.")

def buscar_libros(criterio):
    query = {"$or": [
        {"titulo": {"$regex": criterio, "$options": "i"}},
        {"autor": {"$regex": criterio, "$options": "i"}},
        {"genero": {"$regex": criterio, "$options": "i"}},
    ]}
    return list(libros_collection.find(query))

def actualizar_disponibles(libro_id, cantidad):
    libros_collection.update_one({"_id": ObjectId(libro_id)}, {"$inc": {"disponibles": cantidad}})

def obtener_libro_por_id(libro_id):
    return libros_collection.find_one({"_id": ObjectId(libro_id)})

def obtener_libro_por_isbn(isbn):
    return libros_collection.find_one({"isbn": isbn})
