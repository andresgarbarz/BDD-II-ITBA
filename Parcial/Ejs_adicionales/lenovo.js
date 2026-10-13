// A
db.productos.find(
	{ categoria: "Informática", precio: { $lt: 1000000 } },
	{ nombre: 1, precio: 1, _id: 0 },
);

// B
db.productos.find({
	nombre: { $regex: "^Note" },
	stock: { $gt: 0 },
});

// C
db.productos.find({
	marcas: { $all: ["Lenovo", "Intel"] },
});

// D
db.productos.find({
	"proveedor.provincia": "Buenos Aires",
});

// E
db.productos.updateOne({ _id: 101 }, { $mul: { precio: 1.1 } });

// F
db.productos.deleteMany({ stock: 0 });

// G
db.productos.createIndex({ categoria: 1 });
// El índice ascendente permite resolver filtros (y ordenamientos) por categoría sin recorrer toda la colección.
// Las búsquedas por igualdad o rango sobre categoria leen menos documentos y, en colecciones grandes, responden más rápido.

// H
db.productos.aggregate([
	{
		$group: {
			_id: "$categoria",
			cantidad: { $sum: 1 },
			precioPromedio: { $avg: "$precio" },
		},
	},
]);
