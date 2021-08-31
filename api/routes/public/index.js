const router = require("express").Router();

const new_user = require("./new_user");

/**
 * @route GET /public/login
 * @desc Login page
 * @access Public
 * @returns {Object}
 */
router.use("/login", login);
router.use("/new_user", new_user);


module.exports = router;