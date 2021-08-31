/**
 * Module dependencies.
 */
const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const userModel = new Schema(
  {
    userId: {
      type: String,
      required: true,
      unique: true,
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
