const router = require("express").Router();

/**
 * @route GET /public/login
 * @desc Login page
 * @access Public
 * @returns {Object}
 */
router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

/**
 * @route post /public/login
 * @desc login user
 * @access public
 * @returns {object} user
 */
router.post("/", (req,res)=>{
    res.send(req.body);
})

module.exports = router;