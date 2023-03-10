const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
app.use(bodyParser.json());

const events = [];

function sendEvent(url, event) {
  console.log("sendEvent", url, event);

  axios.post(url, event).catch((err) => {
    console.log("sendEvent.Error", url, err.code);
  });
}

app.post("/events", (req, res) => {
  const event = req.body;

  event.id = events.length;
  events.push(event);

  console.log("Received Event: ", event.type);

  sendEvent("http://posts-clusterip-srv:4000/events", event);
  sendEvent("http://comments-clusterip-srv:4001/events", event);
  sendEvent("http://query-clusterip-srv:4002/events", event);
  sendEvent("http://moderation-clusterip-srv:4003/events", event);

  res.send({ status: "OK" });
});

app.get("/events", (req, res) => {
  res.send(events);
});

app.listen(4005, () => {
  console.log("Listening on 4005");
});
