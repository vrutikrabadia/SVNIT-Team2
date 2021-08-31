const { uploadDisk } = require("../../middleware");


const router = require("express").Router();

/**
 * @route POST /api/protected/upload_file
 * @group protected - Protected routes
 * @param {file} file.formData - file to upload
 * @returns {object} 200 - Successful upload
 */
router.post("/", uploadDisk.single("file") , (req,res)=>{
    res.send(req.body);
})

module.exports = router;