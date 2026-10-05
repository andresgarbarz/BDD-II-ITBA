En el teorema CAP, MongoDB es **CP**: consistente (C) y tolerante a particiones (P). En una partición de red prioriza la consistencia y puede perder disponibilidad un rato.

### Consistencia (C)

En un replica set hay un nodo primary, que recibe las escrituras, y nodos secondary, que las replican. Si el primary cae, se elige otro nodo y los clientes siguen leyendo de uno que tenga los datos al día.

### Disponibilidad (A)

Mientras se elige el primary nuevo, no se puede escribir. Mongo no promete estar siempre disponible: prefiere no responder antes que devolver un dato viejo.

### Tolerancia a particiones (P)

Está pensado para un cluster distribuido, así que tolera que la red se parta. El sistema sigue, pero puede perder disponibilidad mientras se elige un nuevo nodo primary.
