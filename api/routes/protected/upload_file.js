const { uploadDisk } = require("../../middleware");


const router = require("express").Router();


router.post("/", uploadDisk.single("file") , (req,res)=>{
    res.send(req.body);
})

module.exports = router;