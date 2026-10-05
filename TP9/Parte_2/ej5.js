// a
// Desde la terminal del host, con el contenedor Mymongo en marcha:
// docker cp TP9/Parte_2/mongoCities_fixed.json Mymongo:/mongoCities_fixed.json
// docker exec Mymongo mongoimport --db test --collection cities --drop --file /mongoCities_fixed.json

// use test;

db.cities.createIndex({ location: "2d" });

// Ciudades en un radio de 50 millas del centro de Londres.
// location es [longitud, latitud]. $centerSphere pide el radio en radianes:
// 50 millas / 3959 (radio de la Tierra en millas).
db.cities.find({
	location: {
		$geoWithin: {
			$centerSphere: [[-0.1278, 51.5074], 50 / 3959],
		},
	},
});
