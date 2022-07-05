const express = require("express");
const app = express();
const port = 4000;

app.get("/", (req, res) => {
  res.status(200).send("SOY UN CRACK EN DOCKER!!!!");
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));
