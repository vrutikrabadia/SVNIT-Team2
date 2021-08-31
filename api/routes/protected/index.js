const router = require("express").Router();

const get_stock = require("./get_stock");
const add_history = require("./add_history");
const find_history = require("./find_history");

router.use("/get_stock_data", get_stock);
router.use("/add_history", add_history);
router.use("/find_history", find_history);


module.exports = router;
