const router = require("express").Router();

const upload_file = require("./upload_file");


router.use("/", upload_file);


module.exports = router;
