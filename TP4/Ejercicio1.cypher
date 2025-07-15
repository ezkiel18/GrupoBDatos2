//CREACION DE DEPARTAMENTOS
CREATE (d1:departamento {nombre:'Recursos Humanos'});
CREATE (d2:departamento {nombre:'Finanzas'});
CREATE (d3:departamento {nombre:'Marketing'});

//CREACION DE EMPLEADOS
CREATE (e1:empleado {nombre:'Franco', apellido:'Muñoz'});
CREATE (e2:empleado {nombre:'Ezequiel', apellido:'Barrionuevo'});
CREATE (e3:empleado {nombre:'Juan', apellido:'Natalini'});

//RELACION DE EMPLEADO / DEPARTAMENTO
MATCH (e:empleado {nombre: 'Franco'}), (d:departamento {nombre: 'Recursos Humanos'})
CREATE (e)-[:trabaja_en]->(d);
MATCH (e:empleado {nombre: 'Ezequiel'}), (d:departamento {nombre: 'Finanzas'})
CREATE (e)-[:trabaja_en]->(d);
MATCH (e:empleado {nombre: 'Juan'}), (d:departamento {nombre: 'Marketing'})
CREATE (e)-[:trabaja_en]->(d);

//CREACION DE PROYECTOS
CREATE (p1:proyecto {nombre:'Capacitacion de Empleados'});
CREATE (p2:proyecto {nombre:'Campaña de Marketing'});

//ASIGNACION DE LIDERES
MATCH (e:empleado {nombre: 'Franco'}), (p:proyecto {nombre: 'Capacitacion de Empleados'})
CREATE (e)-[:lidera]->(p);
MATCH (e:empleado {nombre: 'Juan'}), (p:proyecto {nombre: 'Campaña de Marketing'})
CREATE (e)-[:lidera]->(p);

//ASIGNACION DE HORAS
MATCH (e:empleado {nombre: 'Franco'}), (p:proyecto {nombre: 'Capacitacion de Empleados'})
CREATE (e)-[:trabaja {horas: 20}]->(p);
MATCH (e:empleado {nombre: 'Ezequiel'}), (p:proyecto {nombre: 'Capacitacion de Empleados'})
CREATE (e)-[:trabaja {horas: 15}]->(p);
MATCH (e:empleado {nombre: 'Juan'}), (p:proyecto {nombre: 'Campaña de Marketing'})
CREATE (e)-[:trabaja {horas: 20}]->(p);
MATCH (e:empleado {nombre: 'Juan'}), (p:proyecto {nombre: 'Capacitacion de Empleados'})
CREATE (e)-[:trabaja {horas: 8}]->(p);

//CONSULTAS
MATCH (l:empleado)-[:lidera]->(p:proyecto)
OPTIONAL MATCH (e:empleado)-[:trabaja]->(p)
RETURN p.nombre AS proyecto, l.nombre +' '+ l.apellido AS lider, collect(e.nombre +' '+ e.apellido) as EmpleadosAsignados;

MATCH (e:empleado)-[t:trabaja]->(p:proyecto)
RETURN p.nombre AS proyecto, sum(t.horas) AS HorasSemanales;

MATCH (e:empleado)-[:trabaja]->(p:proyecto)
WITH e, count(p) AS CantidadProyectos
WHERE CantidadProyectos > 1
RETURN e.nombre +' '+ e.apellido as empleado, CantidadProyectos;

