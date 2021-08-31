/**
 * Module dependencies.
 */
const mongoose = require("mongoose");
const Stock = require("../models/stock.model");

/**
 * Function to fet stock data of a particular stock symbol
 * @api {get} /{stock} Get stock data
 * @param {object} req - request object containing stock symbol in path
 * @param {object} res - response object containing stock data
 */
exports.getStockData = async function (req, res) {
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
};

/**
 * @api {get} /get_stocks/{stock_pattern} Get stock names with company name for a given pattern
 * @param {object} req Request object containing pattern of stock symbol to be searched in path
 * @param {object} res List of matching stock symbols
 */
exports.getSimilarStockNames = async function (req, res) {
  let stocks = await Stock.find({
    symbol: { $regex: req.params.stock_pattern },
  }).select("symbol name");
  if (stocks.length > 0)
    res.status(200).json({ status: "success", message: stocks });
  else res.status(404).json({ status: "error", message: "No stocks found" });
};

/**
 * @api {get} /stock/:symbol/:date Get stock data for a given date
 * @param {object} req Request object containing stock symbol in path
 * @param {object} res Response object containing stock data within a given range of dates
 */
exports.getDateRangeData = async function (req, res) {
  let stocks = await Stock.find({
    symbol: req.params.stock,
  });
  let startDate = new Date(req.body.start_date);
  let endDate = new Date(req.body.end_date);
  let data = [];
  console.log(stocks[0].prices);
  let highest = 0;
  let lowest = Infinity;
  for (let i = 0; i < stocks[0].prices.length; i++) {
    let date = new Date(stocks[0].prices[i].date);
    if (date >= startDate && date <= endDate) {
      let price = stocks[0].prices[i];
      data.push(price);
      if (price.high > highest) highest = price.high;
      if (price.low < lowest) lowest = price.low;
    }
  }
  if (stocks.length > 0)
    res.status(200).json({
      status: "success",
      message: data,
      highest: data[0].high,
      lowest: data[0].low,
    });
  else res.status(404).json({ status: "error", message: "No stocks found" });
};
