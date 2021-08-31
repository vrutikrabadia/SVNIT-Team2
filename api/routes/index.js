const router = require("express").Router();

const public = require("./public");
// const protected = require("./protected");

router.use("/", public);
// router.use("/", protected);

module.exports = router;