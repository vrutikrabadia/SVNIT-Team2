const admin = require("./../config/firebase");
const User = require("./../models/user.model"); 

function authenticate(req,res, callback){
    // console.log(req.headers);
    var token = req.headers.authorization.split(" ")[1];
    admin
        .auth()
        .verifyIdToken(token)
        .then((user) => {
            let u = new User(user.uid);

            // u.getRole((err,role)=>{
            //     if(err){
            //         return res.sendStatus(500);
            //     }

            //     req.user = user;
            //     req.user.role = role[0].role;
            //     // res.write(req.user);
            //     callback();
            // })

            
        })
        .catch((error) => {
            return res.sendStatus(401);
        });
}

module.exports = authenticate;