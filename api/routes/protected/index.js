const router = require("express").Router();

const get_stock = require("./get_stock");

router.use("/", get_stock);


module.exports = router;