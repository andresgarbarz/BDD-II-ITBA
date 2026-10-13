db.productos.find(
	{ marcas: { $nin: ["Apple", "Samsung"] } },
	{ _id: 0, nombre: 1 },
);

// A
// Devuelve el nombre (sin _id) de los productos cuyo arreglo marcas no contiene "Apple" ni "Samsung".

// B
// El documento sí se devuelve. $nin también selecciona los documentos en los que el campo no existe.

// C
// Sí. $all exige que el arreglo contenga todos los valores listados, así que devuelve únicamente productos que tengan a la vez "Apple" y "Samsung".
