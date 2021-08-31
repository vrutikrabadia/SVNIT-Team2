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

exports.getDateRangeData = async function (req, res) {
  let stocks = await Stock.find({
    symbol: req.params.stock,
  });
  let startDate = new Date(req.body.start_date);
  let endDate = new Date(req.body.end_date);
  let data = [];
  console.log(stocks[0].prices);
  let returnObj = {};
  for (let i = 0; i < stocks[0].prices.length; i++) {
    let date = new Date(stocks[0].prices[i].date);
    if (date >= startDate && date <= endDate) {
      data.push(stocks[0].prices[i]);
    }
  }
  if (stocks.length > 0)
    res.status(200).json({ status: "success", message: data });
  else res.status(404).json({ status: "error", message: "No stocks found" });
};
