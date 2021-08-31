require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
var cors = require("cors");

const routes = require("./routes");

/**
 * Express server setup
 * @type {Express}
 */
const app = express();

/**
 * Middleware
 * Add the middlewares to express server
 */
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.json());
app.use(express.static("public"));
app.use("/", routes); //  Connect all our routes to our application

/**
 * Start the server
 * @param port: port to start the server on
 * @returns {Promise<void>}
 */
app.listen(3000, () => {
  console.log("App listening on port 3000");
});
