db.bandas.drop();

db.bandas.insertMany([
	{
		solista: "VER K BITCH",
		genero: "INSTRUMENTAL",
		fecha_inscripcion: new Date(2018, 0, 20),
		discos: [
			{ nombre: "DIOS AGUJERO NEGRO", anio: 2008 },
			{ nombre: "APICHONADOS", anio: 2007 },
			{ nombre: "MERIDIANO", anio: 2006 },
			{ nombre: "CAUSALIDADES", anio: 2005 },
			{ nombre: "PLANETA ESMERALDA", anio: 2001 }
		],
		barrio: "VERSALLES",
		integantes: 1
	},
	{
		solista: "TROTAMUNDOS",
		genero: "INDIE",
		fecha_inscripcion: new Date(2017, 10, 30),
		discos: [
			{ nombre: "HECHO BOLITA", anio: 2014 }
		],
		barrio: "VILLA LURO",
		integantes: 4
	},
	{
		solista: "EFECTO ALFONS",
		genero: "ROCK",
		estilo: "POWER TRIO",
		fecha_inscripcion: new Date(2017, 10, 27),
		discos: [
			{ nombre: "EFECTO ALFONS", anio: 2000 }
		],
		barrio: "BARRACAS",
		integantes: 3
	},
	{
		solista: "MARCELO GIULITTI",
		genero: "SOLISTA",
		fecha_inscripcion: new Date(2017, 10, 26),
		barrio: "AGRONOMIA",
		integantes: 1
	},
	{
		solista: "AFTERLIFE",
		genero: "ROCK",
		estilo: "ROCK ALTERNATIVO",
		fecha_inscripcion: new Date(2017, 10, 14),
		barrio: "BALVANERA",
		integantes: 5
	},
	{
		solista: "VIRGINIA FERREYRA",
		genero: "ROCK",
		estilo: "ROCK POP",
		fecha_inscripcion: new Date(2017, 10, 14),
		barrio: "VILLA DEL PARQUE",
		integantes: 1
	},
	{
		solista: "LMV",
		genero: "POP",
		fecha_inscripcion: new Date(2017, 10, 10),
		barrio: "LA LUCILA",
		integantes: 6
	},
	{
		solista: "EFECTO ALFONS",
		genero: "ROCK",
		estilo: "POWER TRIO",
		fecha_inscripcion: new Date(2017, 10, 6),
		discos: [
			{ nombre: "EFECTO ALFONS", anio: 1995 }
		],
		barrio: "BARRACAS",
		integantes: 3
	},
	{
		solista: "TANTAS PREGUNTAS",
		genero: "PUNK",
		estilo: "PUNK ROCK",
		fecha_inscripcion: new Date(2017, 9, 27),
		discos: [
			{ nombre: "DESPUES DE TODO", anio: 2006 },
			{ nombre: "LIBRE ALBEDRIO", anio: 2006 }
		],
		barrio: "MORENO",
		integantes: 3
	},
	{
		solista: "TAL VEZ DE PASO",
		genero: "POP",
		estilo: "POP ROCK",
		fecha_inscripcion: new Date(2017, 9, 26),
		barrio: "PUERTO MADERO",
		integantes: 4
	},
	{
		solista: "LA SURTIDA FOLCK",
		genero: "FOLKLORE",
		fecha_inscripcion: new Date(2017, 9, 25),
		barrio: "BERAZATEGUI",
		integantes: 7
	},
	{
		solista: "JAYDEE M",
		genero: "HIP HOP / RAP",
		fecha_inscripcion: new Date(2017, 9, 24),
		barrio: "BARRACAS",
		integantes: 1
	}
]);

// 2) Todas las bandas de menor a mayor cantidad de integrantes
db.bandas.find().sort({ integrantes: 1 });

// 3) Las dos bandas con mayor numero de integrantes
db.bandas.find().sort({ integrantes: "desc" }).limit(2);

// 4) Sumar un integrante a todas las bandas
db.bandas.updateMany({}, { $inc: { integrantes: 1 } });

// 5) Bandas cuyo genero es Rock
db.bandas.find({ genero: "ROCK" });

// 6) Genero Rock o estilo que contenga Rock
db.bandas.find({
	$or: [
		{ genero: "ROCK" },
		{ estilo: /ROCK/i }
	]
});

// 7) Bandas que lanzaron disco en 2006
db.bandas.find({ "discos.anio": 2006 });

// 8) Bandas que lanzaron disco despues de 2010
db.bandas.find({ "discos.anio": { $gt: 2010 } });

// 9) Cantidad de bandas en Barracas
db.bandas.countDocuments({ barrio: "BARRACAS" });

// 10) Vista bandas_resumen y promedio de integrantes por genero
db.bandas_resumen.drop();
db.createView("bandas_resumen", "bandas", [
	{
		$project: {
			_id: 0,
			solista: 1,
			genero: 1,
			barrio: 1,
			integantes: 1
		}
	}
]);

db.bandas_resumen.aggregate([
	{
		$group: {
			_id: "$genero",
			promedio_integrantes: { $avg: "$integrantes" }
		}
	},
	{ $sort: { _id: 1 } }
]);

// 11) Cantidad de bandas por barrio, de mas musicales a menos
db.bandas_resumen.aggregate([
	{
		$group: {
			_id: "$barrio",
			cantidad: { $sum: 1 }
		}
	},
	{ $sort: { cantidad: -1 } }
]);
