const express = require('express');
const { Server } = require('ws');

const PORT = process.env.PORT || 3000; //port for https

const server = express()
    .use((req, res) => res.send("Hi there"))
    .listen(PORT, () => console.log(`Listening on ${PORT}`));

const wss = new Server({ server });