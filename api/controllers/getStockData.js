/**
 * Module dependencies.
 */
const mongoose = require("mongoose");
const Stock = require("../models/stocks.model");

exports.getStockData = async function (req, res) {
  console.log("getStockData");
  // Delete below line and uncomment the line below to test the function
  return res.status(200).json({
    status: "success",
  });
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
