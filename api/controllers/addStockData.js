/**
 * Module dependencies.
 */
const mongoose = require("mongoose");
const Stock = require("../models/stock.model");

/**
 * @api {post} /add_new_stock_data Add Stock Data
 * @param {object} req request containing the stock in the path
 * @param {object} res result in json having the updated stock data
 */
exports.addStockData = async function (req, res) {
  // Delete below line and uncomment the line below to test the function
  Stock.updateMany(
    {
      symbol: req.params.stock,
    },
    {
      $addToSet: {
        prices: {
          open: req.body.open,
          high: req.body.high,
          low: req.body.low,
          close: req.body.close,
          volume: req.body.volume,
          date: req.body.date,
        },
      },
    },
    {
      multi: true,
    },
    (err, updatedStocks) => {
      if (err) return res.status(400).json({ status: "error", error: err });
      else
        return res.status(200).json({ status: "success", data: updatedStocks });
    }
  );
};
