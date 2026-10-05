// a
db.bandas.find(
	{ genero: "ROCK", integrantes: { $gt: 2 } },
	{ _id: 0, nombre_solista: 1 },
);

// b
db.bandas.aggregate([
	{
		$match: {
			fecha_incripcion: { $lte: new Date("2017-11-27") },
		},
	},
	{
		$group: {
			_id: "$genero",
			promedio_integrantes: { $avg: "$integrantes" },
			cant_bandas: { $sum: 1 },
		},
	},
	{
		$project: {
			_id: 0,
			genero: "$_id",
			promedio_integrantes: 1,
			cant_bandas: 1,
		},
	},
	{
		$sort: { promedio_integrantes: -1 },
	},
]);
