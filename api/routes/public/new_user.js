const userModel = require("../../models/user.model");

const router = require("express").Router();

router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/", (req,res)=>{
    let user = new userModel({userId: req.body.userId});

    user.save((err)=>{
        if(err){
            res.sendStatus(500);
            console.log(err);
        }
        else{
            res.sendStatus(200);
        }
    })

})

module.exports = router;