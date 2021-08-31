/**
 * Module dependencies.
 */
const mongoose = require("mongoose");
const Stock = require("../models/stock.model");

/**
 * @api {get} /stock/:symbol Get stock data
 * @param {req} req - request object containing stock symbol in path
 * @param {res} res - response object containing stock data
 */
exports.getStockData = async function (req, res) {
  console.log("getStockData");
  console.log(req.params.stock);
  // Delete below line and uncomment the line below to test the function
  Stock.find({}, (err, stocks) => {
    if (err) {
      console.log(err);
      return res.status(404).json({
        status: "error",
        message: "No stock was found with this company code!",
      });
    } else {
      return res.status(200).json({ status: "success", stocks: stocks });
    }
  });
  // console.log(stocks);
  // return res.status(200).json({
  //   status: "success",
  // });
};

exports.getSimilarStockNames = async function (req, res) {
  let stocks = await Stock.find({
    symbol: { $regex: req.params.stock_pattern },
  }).select("symbol name");
  if (stocks.length > 0)
    res.status(200).json({ status: "success", message: stocks });
  else res.status(404).json({ status: "error", message: "No stocks found" });
};
