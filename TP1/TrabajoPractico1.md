1. <br>Si se elimina un estudiante que este inscripto en un curso surge un problema que viola la integridad referencial porque la clave foranea de una supuesta tabla cursos ya no tendria donde apuntar.
<br>
Para que esto no suceda se deberia usar un ON DELETE RESTRICT.
***

2. <br>Creamos una tabla Matriculas, que tiene una clave foránea hacia la tabla estudiantes y otra a la tabla curso. 
<br>
Ingresamos los valores que violen la integridad referencial.

<img src="img/errorMatriculaEj2.PNG"  width="900" />

***

3. <br>READ COMMITED:
<br>
SESION 1: (TRANSACCION A)
<td><img src="img/transactionNoCommit.PNG" width="600" height="300"/></td>

SESION 2: (TRANSACCION B)
<td><img src="img/transactionCommit.PNG" width="600" height="300"/></td>

SERIALIZABLE:
<br>
SESION 1 (TRANSACCION A)
<td><img src="img/serializableNoCommit.PNG" width="600" height="300"/></td>

SESION 2 (TRANSACCION B)
<td><img src="img/serializableCommit.PNG" width="600" height="300"/></td>

***

4. <br>Sin Indice:

<td><img src="img/sinIndice.PNG" width="600" height="300"/></td>

Con Indice:

<td><img src="img/conIndice.PNG"  width="600" height="300"/></td>

***

5. <br>Creamos una consulta que filtra por múltiples columnas: stock, categoria y precio. 
<br>Primero se ejecutó sin ningún índice, despues con diferentes índices  y se compararon usando EXPLAIN.

<td><img src="img/ejercicio5.1.PNG" width="800" height="300"/></td>

<td><img src="img/Ejercicio 5.2.PNG" width="800" height="200"/></td>

<td><img src="img/ejercicio 5.3.PNG" width="800" height="200"/></td>



***

6. <br> Creamos la tabla de ventas: 

<td><img src="img/ejercicio6.1.PNG" width="600"/></td>

Creamos la vista:

<td><img src="img/ejercicio6.2.PNG"  width="600" height="300"/></td>

Mostramos los 5 productos mas vendidos:

<td><img src="img/ejercicio6.3.PNG" width="600" height="300"/></td>

***

7. <br>Creamos el usuario y le damos permisos de lectura:

<td><img src="img/ejercicio7.1.PNG" width="600" /></td>

Probamos ver la tabla cuentas:

<td><img src="img/ejercicio7.2.PNG" width="600" height="400"/></td>

Mostramos el error al insertar un producto:

<td><img src="img/ejercicio7.3.PNG" alt="Vista ventas" width="800" height="300"/></td>

***

8. <br> Creamos la base de datos y las tablas 

<td><img src="img/ejercicio8.1.PNG" width="600" /></td>

Creamos el trigger para insert

<td><img src="img/ejercicio8.2.PNG" width="600" /></td>

Creamos el trigger para update

<td><img src="img/ejercicio8.3.PNG" width="600" /></td>

Creamos el trigger para el delete

<td><img src="img/ejercicio8.4.PNG" width="600" /></td>

Probamos la auditoria 

<td><img src="img/ejercicio8.5.PNG" width="600" /></td>
<td><img src="img/ejercicio8.6.PNG" width="600" /></td>
<td><img src="img/ejercicio8.7.PNG" width="600" /></td>

***

9. <br> Usamos una base de datos llamada empresa y un usuario fran
<br>
-- Backup de una base de datos específica<br>
mysqldump -u fran -p empresa > backup.sql
<br>
-- Backup de todas las bases de datos <br>
mysqldump -u fran -p --all-databases > backup_full.sql
<br>
-- Restauración del backup <br>
mysql -u fran -p empresa < backup.sql
<br>
-- Simulacion de perdida de datos y recuperacion<br>
Creacion de la base de datos y una tabla:
<td><img src="img/ejercicio9.PNG" width="600" /></td>
<br>
-- Se hace el backup <br>
mysqldump -u fran -p empresa > backupEmpresa.sql
<br>
-- Se borra por "accidente" la base de datos <br>
DROP DATABASE empresa;
<br>
-- Se restaura la base de datos<br>
mysql -u fran -p empresa < backupEmpresa.sql