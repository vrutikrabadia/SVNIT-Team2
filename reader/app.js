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
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.json());
app.use(express.static("public"));
app.use("/", routes);

/**
 * Middleware
 * Add the middlewares to express server
 */


/**
 * Database setup
 */
 const users_ATLAS_URI = require("./config/db.js").users_mongo_uri;
 const uri = users_ATLAS_URI;
 mongoose.connect(uri, {
   useNewUrlParser: true,
   useUnifiedTopology: true,
 });
 const connection = mongoose.connection;
 connection.once("open", () => {
   console.log("Mongoose database connection established successfully");
   // console.log(uri);				// This line exposes the ATLAS URI to terminal, to be used only during debugging
 });//  Connect all our routes to our application


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
