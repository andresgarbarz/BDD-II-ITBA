En el teorema CAP, Cassandra es **AP**: disponible (A) y tolerante a particiones (P). En una partición de red prioriza responder, aunque el dato pueda estar desactualizado.

### Consistencia (C)

No hay un único nodo primary. Las réplicas pueden diferir un rato: cada escritura lleva un timestamp y, si dos copias no coinciden, después se reconcilian. Por defecto alcanza con que responda un nodo (consistency level `ONE`), así que una lectura puede no ver la última escritura.

### Disponibilidad (A)

Mientras quede al menos un nodo alcanzable, se puede leer y escribir. Cassandra prefiere devolver un dato, aunque sea viejo, antes que dejar de responder.

### Tolerancia a particiones (P)

Está pensado para un cluster distribuido, sin un coordinador único. Si la red se parte, cada lado sigue atendiendo con los nodos que le quedan.
