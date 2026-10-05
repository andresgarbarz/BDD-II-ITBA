// a
// Desde la terminal del host, con el contenedor Mymongo en marcha:
// docker cp TP9/Parte_2/egresados.csv Mymongo:/egresados.csv
// docker exec Mymongo mongoimport --db academica --collection egresados --type csv --headerline --drop --file /egresados.csv

// use academica;

// b
db.egresados.aggregate([
	{ $group: { _id: "$titulo", cantidad: { $sum: 1 } } },
	// { $sort: { cantidad: -1 } },
]);

// c
db.egresados.aggregate([
	{ $group: { _id: "$colacion", cantidad: { $sum: 1 } } },
	{ $sort: { cantidad: -1 } },
]);
