const User = require("../../models/user.model");
const bcrypt = require("bcrypt");
const jwt = require('jsonwebtoken');

const router = require("express").Router();

router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/",function(req,res){
    let username = req.body.username;
    let password = req.body.password;

    User.findOne({username: username}, function(err,found){
        if(!found){
            res.send("User not found");
        }
        if(err){
            console.log(err);
            res.send("Error! Please try again");
        }
        if(found){
            console.log(found);
            if(bcrypt.compareSync(password, found.password)){
                const accessToken = jwt.sign({ username: found.username }, process.env.SECRET,{expiresIn: '3000000000'});

                res.json({
                    accessToken
                });
            }

            else{
                res.send("Incorrect password");
            }
        }
    })
});

module.exports = router;