const router = require("express").Router();

const new_user = require("./new_user");

router.use("/new_user", new_user);


module.exports = router;