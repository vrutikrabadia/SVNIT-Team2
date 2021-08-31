const router = require("express").Router();

const { route } = require("./public");
// const public = require("./public");
const { getStockData } = require("../controllers/getStockData");
// const protected = require("./protected");

// router.use("/", public);
// router.use("/", protected);

/**
 * @route GET /
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
module.exports = router;
