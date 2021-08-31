require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const fs = require('fs');
const mongoose = require("mongoose");


const routes = require("./routes");

/**
 * Express server setup
 * @type {Express}
 * @returns {Express} app - Express server
 */
const app = express();

/**
 * Middleware
 * Add the middlewares to express server
 */


mongoose.connect('mongodb://localhost:27017/nt_team2', {useNewUrlParser: true});
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.json());
app.use(express.static("public"));
app.use("/", routes); //  Connect all our routes to our application


var dir = './uploads';

if (!fs.existsSync(dir)){
    fs.mkdirSync(dir);
}


/**
 * Start the server
 * @param port: port to start the server on
 * @returns {Promise<void>}
 */
app.listen(3001, () => {
  console.log("App listening on port 3001");
});
