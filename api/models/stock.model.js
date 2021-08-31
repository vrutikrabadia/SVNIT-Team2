/**
 * Module dependencies.
 */
const mongoose = require("mongoose");

const Schema = mongoose.Schema;

/**
 * Stcok Schema	{Schema}
 * @param {String} symbol - symbol of the stock
 * @param {String} name - name of the stock
 * @param {Array} price - array of stock price data
 * @return {Schema} stockSchema - Mongo schema
 */
const stockSchema = new Schema(
  {
    symbol: {
      type: String,
      required: true,
      unique: true,
    },
    name: {
      type: String,
      required: true,
    },
    prices: [
      {
        date: {
          type: Date,
          required: true,
        },
        open: {
          type: Number,
          required: true,
        },
        high: {
          type: Number,
          required: true,
        },
        low: {
          type: Number,
          required: true,
        },
        close: {
          type: Number,
          required: true,
        },
        volume: {
          type: Number,
          required: true,
        },
      },
    ],
  },
  {
    timestamps: true,
    collection: "stocks",
  }
);

// Create and export the model
module.exports = mongoose.model("Stock", stockSchema);
