const authenticateJWT = require("../../middleware/auth");
const User = require("../../models/user.model");

const router = require("express").Router();

router.use(authenticateJWT);
router.get("/", (req,res)=>{
    res.send("welcome to nt");
})

router.post("/",function(req,res){
    var stock = req.body.stock;

    User.find({ username: req.user.username })
     .then((result) => {
    //    console.log(result);
       if (result.length ==0) {
         const newData = new User({
           userId: user,
           watchlist: [
             stock
           ]
         })
         newData.save()
           .then((result1) => {
             res.send(result1)
           })
           .catch((err) => {
             console.log(err);
           });
       }
       else {
         if(result[0].watchlist.length<20){
             User.update(
                { username: req.user.username },
               { $addToSet: { watchlist: stock } }
             )
               .then((result1) => {
                 res.send(result1)
               })
               .catch((err) => {
                 console.log(err);
               });
           }
           else{
             var arr=result[0].watchlist;
             arr.shift();
             arr.push(stock);
             User.updateOne(
               { userId: user },
               { watchlist:arr}
             )
               .then((result1) => {
                 res.send(result1)
               })
               .catch((err) => {
                 console.log(err);
               });
           }
       }

     })
     .catch((err) => {
       console.log(err);
     });
});

module.exports = router;