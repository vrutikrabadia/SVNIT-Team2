const authenticateJWT = require("../../middleware/auth");
const User = require("../../models/user.model");

const router = require("express").Router();

router.use(authenticateJWT);

router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/",function(req,res){
    User.find({ username: req.user.username })
      .then((result) => {
        res.send(result[0].watchlist)
      })
      .catch((err) => {
        console.log(err);
      });
});

module.exports = router;