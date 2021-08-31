const router = require("express").Router();

const login = require("./login");

/**
 * @route GET /public/login
 * @desc Login page
 * @access Public
 * @returns {Object}
 */
router.use("/login", login);


module.exports = router;