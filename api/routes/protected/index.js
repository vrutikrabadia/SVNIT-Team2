const router = require("express").Router();

const upload = require("./upload_file");

router.use("/upload", upload)


module.exports = router;