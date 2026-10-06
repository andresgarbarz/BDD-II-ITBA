# Preguntas teóricas

## A. ¿Qué es un Sistema Gestor de Bases de Datos (SGBD)?

Es un software que define, crea, consulta y mantiene una base de datos. Se ubica entre los usuarios y los datos almacenados, y se ocupa de la integridad, la concurrencia, la seguridad y la recuperación ante fallas.

## B. ¿Qué es el modelo conceptual de datos? Indique los elementos de un DER.

Es la representación de la realidad a modelar, independiente del SGBD y de cómo se guardan los datos. Describe qué información existe y cómo se vincula.

Elementos de un DER:

- Entidades
- Atributos
- Relaciones
- Cardinalidades
- Identificadores
- Jerarquías

## C. En el modelo conceptual, ¿qué diferencia hay entre una jerarquía exclusiva y una compartida?

En una jerarquía exclusiva, cada ocurrencia de la entidad padre pertenece a lo sumo a un subtipo. En una compartida, puede pertenecer a varios subtipos a la vez.

Ejemplo: Si tenemos la entidad "Vehículo" y los subtipos "Auto" y "Moto", en una jerarquía exclusiva cada vehículo será sólo auto o sólo moto, nunca ambos. En cambio, si tuviéramos la entidad "Persona" y subtipos como "Profesor" y "Alumno", en una jerarquía compartida una persona podría ser ambos al mismo tiempo, según cada caso.

## D. Defina el concepto de una entidad débil en el modelo conceptual y cómo se deriva al modelo lógico.

Es una entidad que no se identifica sola: depende de una entidad fuerte, y su identificador es la clave de esa fuerte más una clave propia.

En el modelo lógico pasa a ser una tabla. Su clave primaria es la clave de la entidad fuerte, que queda como clave foránea, más su clave propia.
