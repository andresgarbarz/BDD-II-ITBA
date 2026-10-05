// use book;

db.towns.drop();

db.towns.insertMany([
	{
		name: "New York",
		population: 22200000,
		lastCensus: new Date("2016-07-01"),
		famousFor: ["the MOMA", "food", "Derek Jeter"],
		mayor: {
			name: "Bill de Blasio",
			party: "D",
		},
	},
	{
		name: "Punxsutawney",
		population: 6200,
		lastCensus: new Date("2016-01-31"),
		famousFor: ["Punxsutawney Phil"],
		mayor: {
			name: "Richard Alexander",
			party: null,
		},
	},
	{
		name: "Portland",
		population: 582000,
		lastCensus: new Date("2016-09-20"),
		famousFor: ["beer", "food", "Portlandia"],
		mayor: {
			name: "Ted Wheeler",
			party: "D",
		},
	},
]);

// a
db.towns.find({ name: { $regex: "new", $options: "i" } });

// b
db.towns.find({
	name: { $regex: "e", $options: "i" },
	famousFor: { $in: ["food", "beer"] },
});

// c
// use blogger;

db.articles.insertOne({
	title: "The Great Gatsby",
	content:
		"The Great Gatsby is a novel by F. Scott Fitzgerald. It was published in 1925.",
	author: {
		name: "F. Scott Fitzgerald",
		email: "f.scott.fitzgerald@gmail.com",
	},
	createdAt: new Date("1925-05-20"),
});

// d
db.articles.updateOne(
	{ title: "The Great Gatsby" },
	{
		$set: {
			comments: [
				{
					content: "This is a great article!",
					author: {
						name: "John Doe",
						email: "john.doe@gmail.com",
					},
				},
			],
		},
	},
);
