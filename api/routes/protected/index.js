const router = require("express").Router();

const upload = require("./upload_file");

/**
 * @route GET /protected/upload
 * @group protected
 * @returns {object} 200 - An array of uploads
 * @returns {Error}  default - Unexpected error
 */
router.use("/upload", upload);

module.exports = router;
