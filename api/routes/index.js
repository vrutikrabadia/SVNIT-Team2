const router = require("express").Router();

const { route } = require("./public");
const public = require("./public");
const getStockData = require("../controllers/getStockData");
// const protected = require("./protected");

// router.use("/", public);
// router.use("/", protected);

route.get("/:stock", getStockData, (req, res) => {
  return res.status(200).json(res.locals.stockData);
});

module.exports = router;
