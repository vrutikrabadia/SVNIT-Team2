/**
 * Module dependencies.
 */
const mongoose = require("mongoose");
const Stock = require("../models/stock");

exports.getStockData = async function (req, res) {
  Stock.find({}, function (err, stocks) {
    if (err) {
      res.send(err);
    }
    // Set the response header to JSON
    res.setHeader("Content-Type", "application/json");
    // Set the locals for the response
    res.locals = {
      stocks: stocks,
    };
    // res.json(stocks);
  });
};
