const admin = require("./../config/firebase");
const User = require("./../models/user.model"); 

function authenticate(req,res, callback){
    // console.log(req.headers);
    var token = req.headers.authorization.split(" ")[1];
    admin
        .auth()
        .verifyIdToken(token)
        .then((user) => {

            User.findOne({userId: user.uid}, (err, found)=>{
                if(err){
                    return res.sendStatus(500);
                }
                if(found){
                    req.user = { id: found._id, uid: found.userId};
                }
                else{
                    let user = new userModel({userId: req.body.userId});

                    user.save((err, id)=>{
                        if(err){
                            return res.sendStatus(500);
                        }
                        else{
                            req.user = { id: found._id, uid: found.userId};
                        }
                    })
                    
                }
            })

            
        })
        .catch((error) => {
            return res.sendStatus(401);
        });
}

module.exports = authenticate;