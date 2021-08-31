const multer = require('multer');
const mime = require('mime');


var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, "./uploads/"); 
    },
    filename: function (req, file, cb) {
        console.log(file);

        cb(null, "data."+mime.getExtension(file.mimetype)); 
    }
});

var uploadDisk = multer({
    storage: storage
});


module.exports = uploadDisk;