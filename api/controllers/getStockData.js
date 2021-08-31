/**
 * Module dependencies.
 */
const mongoose = require("mongoose");
const Stock = require("../models/stock.model");

exports.getStockData = async function (req, res) {
  console.log("getStockData");
  console.log(req.params.stock);
  // Delete below line and uncomment the line below to test the function
  Stock.find({}, (err, stocks) => {
    if (err) {
      console.log(err);
    } else {
      return res.json(stocks);
    }
  });
  // console.log(stocks);
  // return res.status(200).json({
  //   status: "success",
  // });
};
