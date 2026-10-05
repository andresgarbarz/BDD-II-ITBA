db.bandas_resumen.drop();

db.createView("bandas_resumen", "bandas", [
	{
		$project: {
			_id: 0,
			solista: 1,
			genero: 1,
			barrio: 1,
			integrantes: 1,
		},
	},
]);

db.bandas_resumen.aggregate([
	{
		$group: {
			_id: "$genero",
			promedio_integrantes: { $avg: "$integrantes" },
		},
	},
	{ $sort: { _id: 1 } },
]);
