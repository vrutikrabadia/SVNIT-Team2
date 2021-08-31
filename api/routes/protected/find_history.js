const authenticateJWT = require("../../middleware/auth");
const User = require("../../models/user.model");

const router = require("express").Router();

router.use(authenticateJWT);

router.get("/", function(req, res) {
    User.find({ username: req.user.username })
        .then((result) => {
            res.send(result[0].watchlist)
        })
        .catch((err) => {
            console.log(err);
        });
});

module.exports = router;