db.bandas.find({ $or: [{ genero: "ROCK" }, { estilo: /ROCK/i }] });
