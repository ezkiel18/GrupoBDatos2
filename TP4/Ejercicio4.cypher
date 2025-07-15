// ESTUDIANTES
CREATE (e1:Estudiante {nombre: 'Ezequiel'});
CREATE (e2:Estudiante {nombre: 'Mateo'});
CREATE (e3:Estudiante {nombre: 'Agustin'});

// MATERIAS
CREATE (m1:Materia {nombre: 'Matemática I'});
CREATE (m2:Materia {nombre: 'Matemática II'});
CREATE (m3:Materia {nombre: 'Programación'});

// PRERREQUISITOS
MATCH (m1:Materia {nombre: 'Matemática I'}), (m2:Materia {nombre: 'Matemática II'})
CREATE (m2)-[:PRERREQUISITO]->(m1);

// CURSOS
MATCH (m1:Materia {nombre: 'Matemática I'}), 
      (m2:Materia {nombre: 'Matemática II'}), 
      (m3:Materia {nombre: 'Programación'})
CREATE 
  (c1:Curso {codigo: 'MAT1-2025'})-[:CORRESPONDE_A]->(m1),
  (c2:Curso {codigo: 'MAT2-2025'})-[:CORRESPONDE_A]->(m2),
  (c3:Curso {codigo: 'PROG-2025'})-[:CORRESPONDE_A]->(m3),
  (c4:Curso {codigo: 'MAT1-2026'})-[:CORRESPONDE_A]->(m1);

// INSCRIPCIONES Y CALIFICACIONES
MATCH (e:Estudiante {nombre: 'Ezequiel'}), (c:Curso {codigo: 'MAT1-2025'})
CREATE (e)-[:CURSA {nota: 8}]->(c);

MATCH (e:Estudiante {nombre: 'Ezequiel'}), (c:Curso {codigo: 'MAT2-2025'})
CREATE (e)-[:CURSA {nota: 6}]->(c);

MATCH (e:Estudiante {nombre: 'Mateo'}), (c:Curso {codigo: 'MAT1-2025'})
CREATE (e)-[:CURSA {nota: 9}]->(c);

MATCH (e:Estudiante {nombre: 'Agustin'}), (c:Curso {codigo: 'PROG-2025'})
CREATE (e)-[:CURSA {nota: 10}]->(c);

MATCH (e:Estudiante {nombre: 'Agustin'}), (c:Curso {codigo: 'MAT1-2026'})
CREATE (e)-[:CURSA {nota: 7}]->(c);

// Consultas

MATCH (e:Estudiante {nombre: 'Ezequiel'})-[r:CURSA]->(c)-[:CORRESPONDE_A]->(m)
RETURN m.nombre AS Materia, c.codigo AS Curso, r.nota AS Nota;

MATCH (e:Estudiante {nombre: 'Ezequiel'}), (m:Materia {nombre: 'Matemática II'})
OPTIONAL MATCH (m)-[:PRERREQUISITO]->(pre:Materia)<-[:CORRESPONDE_A]-(c:Curso)<-[r:CURSA]-(e)
WITH e, m, MAX(r.nota) AS nota_prerrequisito
RETURN e.nombre AS Estudiante, m.nombre AS Materia,
  CASE 
    WHEN nota_prerrequisito IS NULL THEN 'Debe cursar el prerrequisito'
    WHEN nota_prerrequisito >= 7 THEN 'Puede inscribirse'
    ELSE 'No puede inscribirse (nota insuficiente)'
  END AS Estado;

MATCH (e:Estudiante)-[r:CURSA]->()
RETURN e.nombre AS Estudiante, ROUND(AVG(r.nota), 2) AS Promedio;

MATCH (:Estudiante)-[r:CURSA]->(c)-[:CORRESPONDE_A]->(m)
WITH m.nombre AS Materia, c.codigo AS Curso, AVG(r.nota) AS promedio
WHERE promedio < 7
RETURN Materia, Curso, ROUND(promedio, 2) AS Promedio;