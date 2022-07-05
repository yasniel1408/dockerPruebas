const http = require("http");
const host = "127.0.0.1";
const port = 3000;

const requestListener = function (req, res) {
  res.setHeader("Content-Type", "application/json");
  res.writeHead(200);
  res.end(
    `{"message": "HOLA MUNDOOOOOOOOOO, YASNIEL ES UN CKRACK EN DOCKER YAAAA!!!!!"}`
  );
};

const server = http.createServer(requestListener);
server.listen(port, host, () => {
  console.log(`Server is running on http://${host}:${port}`);
});
