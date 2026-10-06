// a
db.hospitales.aggregate([
	{
		$group: {
			_id: "$tipo",
			count: { $sum: 1 },
		},
	},
	{
		$sort: {
			count: -1,
		},
	},
]);
