/**
 * Module dependencies.
 */
const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const priceSchema = new Schema(
  {
    date: {
      type: Date,
    },
    open: {
      type: Number,
    },
    high: {
      type: Number,
    },
    low: {
      type: Number,
    },
    close: {
      type: Number,
    },
    volume: {
      type: Number,
    },
  },
  { timestamps: false, _id: false }
);
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
      required: false,
    },
    prices: [priceSchema],
  },
  {
    timestamps: true,
    collection: "stocks",
  }
);

// Create and export the model
module.exports = mongoose.model("Stock", stockSchema);
