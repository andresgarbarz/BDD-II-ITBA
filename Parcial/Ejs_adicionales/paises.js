// A
db.paises.find({
	"exports.foods.name": "bacon",
	"exports.foods.tasty": false,
});

// B
// $elemMatch. Sin él, "exports.foods.name": "bacon" y "exports.foods.tasty": false pueden cumplirse en elementos distintos del arreglo: uno llamado bacon y otro con tasty en false.
// $elemMatch exige que ambas condiciones valgan en el mismo objeto.

// C
db.paises.deleteOne({
	"exports.foods": {
		$elemMatch: { name: "bacon", tasty: false },
	},
});
