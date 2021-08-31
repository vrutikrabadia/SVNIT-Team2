const router = require("express").Router();

router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/", (req,res)=>{
    res.send(req.body);
})

module.exports = router;