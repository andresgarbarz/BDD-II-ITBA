db.bandas_resumen.aggregate([
	{
		$group: {
			_id: "$barrio",
			cantidad: { $sum: 1 },
		},
	},
	{ $sort: { cantidad: -1 } },
]);
