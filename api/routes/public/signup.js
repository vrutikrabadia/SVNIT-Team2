const User = require('../../models/user.model')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

const router = require('express').Router()

router.get('/', (req, res) => {
    res.send('welcome to nt')
})

router.post('/', function(req, res) {
    let username = req.body.username
    let password = req.body.password
    let confirm = req.body.confirm

    if (password === confirm) {
        User.findOne({ username: username }, function(err, found) {
            if (!found) {
                let hash_out = bcrypt.hashSync(password, 10)
                const user = new User({
                    username: username,
                    password: hash_out
                })
                user.save(function(err) {
                    if (err) {
                        console.log(err)
                        res.send('Error! Please try again')
                    } else {
                        const accessToken = jwt.sign({ username: username },
                            process.env.SECRET, { expiresIn: '3000000000' }
                        )

                        res.json({
                            accessToken
                        })
                    }
                })
            } else {
                res.send('Username already taken')
            }
            if (err) {
                console.log(err)
                res.send('Error! Please try again')
            }
        })
    } else {
        res.send('Error: confirmation does not matches the password')
    }
})

module.exports = router