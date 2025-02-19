const express = require('express');
const app = express();
const port = process.env.PORT || "8000"

// Access the POD_IP environment variable injected by Kubernetes
const podIP = process.env.POD_IP || "Unknown Pod IP";

app.get('/', (req, res) => {
  res.send(`Hello, WORLD!!! Your Pod IP is: ${podIP}`);
});


app.listen(port, () => {
    console.log(`DevOps Challenge listening at http://localhost:${port}`);
});