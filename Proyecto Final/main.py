from libro import agregar_libro, buscar_libros, obtener_libro_por_id
from prestamo import prestar_libro, devolver_libro, reporte_populares

def menu():
    while True:
        print("\n--- SISTEMA DE BIBLIOTECA ---")
        print("1. Agregar libro")
        print("2. Prestar libro")
        print("3. Devolver libro")
        print("4. Buscar libros")
        print("5. Reporte populares")
        print("6. Salir")

        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            try:
                titulo = input("Título: ")
                autor = input("Autor: ")
                isbn = input("ISBN: ")
                genero = input("Género: ")
                anio = int(input("Año: "))
                copias = int(input("Cantidad de copias: "))
                if copias < 1:
                    print("Debe ingresar al menos una copia.")
                    continue
            except ValueError:
                print("Entrada no válida. Asegúrese de ingresar números donde corresponde.")
                continue

            libro = {
                "titulo": titulo,
                "autor": autor,
                "isbn": isbn,
                "genero": genero,
                "anioPublicacion": anio,
                "copias": copias,
                "disponibles": copias
            }
            agregar_libro(libro)

        elif opcion == "2":
            isbn = input("ISBN del libro: ")
            usuario = input("Nombre del usuario: ")
            prestamo_id = prestar_libro(isbn, usuario)
            if prestamo_id:
                print(f"Préstamo registrado con ID: {prestamo_id}")
            else:
                print("No se pudo registrar el préstamo.")

        elif opcion == "3":
            prestamo_id = input("ID del préstamo: ")
            devolver_libro(prestamo_id)

        elif opcion == "4":
            criterio = input("Buscar por título, autor o género: ")
            libros = buscar_libros(criterio)
            for l in libros:
                print(f"{l['_id']} - {l['titulo']} ({l['disponibles']} disponibles)")

        elif opcion == "5":
            populares = reporte_populares()
            print("Top 5 libros más prestados:")
            for p in populares:
                libro = obtener_libro_por_id(p["_id"])
                titulo = libro["titulo"] if libro else "Libro no encontrado"
                print(f"{titulo} - Veces prestado: {p['total']}")

        elif opcion == "6":
            print("Saliendo del sistema. ¡Hasta luego!")
            break

        else:
            print("Opción no válida.")

if __name__ == "__main__":
    menu()
