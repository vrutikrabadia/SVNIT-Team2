/**
 * Module dependencies.
 */
const mongoose = require("mongoose");

const Schema = mongoose.Schema;

/**
 * Model: User
 * @description User model
 * @type {Schema}
 * @property {String} userId
 * @property {Array[{String}]} watchlist - to store the list of data the user has viewed
 */
const userModel = new Schema(
  {
    username: {
      type: String,
      required: true,
      unique: true,
    },
    password: {
      type: String,
      required: true
    },
    watchlist: [
      {
        type: String,
        required: true,
        default: [],
      },
    ],
  },
  {
    timestamp: true,
  }
);

// Create and export the model
module.exports = mongoose.model("User", userModel);
