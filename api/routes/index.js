const router = require("express").Router();

const { route } = require("./public");
// const public = require("./public");
const {
  getStockData,
  getSimilarStockNames,
  getDateRangeData,
} = require("../controllers/getStockData");
const { addStockData } = require("../controllers/addStockData");
// const protected = require("./protected");

const public = require("./public");
const protected = require("./protected");

/**
 * @route   GET /
 * @desc    Home page
 *        Redirects to public route
 * @access  Public
 * @returns {object}
 */
router.use("/", public);
router.use("/", protected);

/**
 * @route GET /{stock}
 * @desc Route for a particular stock
 * @access Public
 * @returns {object} JSON object
 * @example
 * {
 *  "stock": "AAPL"
 * }
 */
router.get("/:stock", getStockData);
/**
 * Test route
 */
router.get("/", (req, res) => {
  return res
    .status(200)
    .json({ TEST: "Sucessfull", status: "Server is working" });
});

/**
 * @route GET /add_new_stock_data
 * @desc Route for adding new stock data
 * @access Public
 * @returns {object} JSON object
 */
router.get("/add_new_stock_data/:stock", addStockData);

/**
 * @route GET /get_date_range_data
 * @desc Route for getting date range data
 * @access Public
 * @returns {object} JSON object
 */
router.get("/get_date_range_data/:stock", getDateRangeData);

/**
 * @route GET /get_similar_stock_names
 * @desc Route for getting similar stock names
 * @access Public
 * @returns {object} JSON object
 */
router.get("/get_stocks/:stock_pattern", getSimilarStockNames);
module.exports = router;
