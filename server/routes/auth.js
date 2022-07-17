const express = require("express");
const userModel = require("../models/user")
const authRouter = express.Router();
const bcryptjs = require("bcryptjs")
const jwt = require("jsonwebtoken");
const authorization = require("../middlewares/auth");

// exports : 
module.exports = authRouter;

// SIGINUP API  : 
authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name: name, email: email, password: password } = req.body;
        console.log(req.body);

        const existingEmail = await userModel.findOne({ email: email });

        console.log(existingEmail);
        if (existingEmail) {
            return res.status(400).json({ msg: "email address already exsits", user: null, status: false });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new userModel({
            name: name,
            email: email,
            password: hashedPassword,
        });

        user = await user.save();
        return res.status(200).json({
            msg: 'Account has been created',
            status: true,
            user: user,

        });

    } catch (error) {
        req.status(500).json({
            msg: 'server side error',
            status: false,
            user: null,
        });
    }
});

// LOGIN API :
authRouter.post("/api/login", async (req, res) => {
    try {
        const { email: email, password: password } = req.body;
        user = await userModel.findOne({ email: email });
        if (!user) {
            // means if equal to null or empty . 
            return res.status(400).json({ msg: 'email does not exist!', status: false, user: null });
        } else {
            const isMatch = await bcryptjs.compare(password, user.password);
            if (!isMatch) {
                return res.status(400).json({ msg: 'Incorrect password', status: false, user: null });
            } else {
                const userToken = jwt.sign({ id: user._id }, 'passwordKey');
                user.token = userToken;
                return res.status(200).json({ msg: 'You have logged in successfully', status: true, user: user, },);
            }
        }
    } catch (error) {
        return res.status(500).json({ msg: 'server error', status: false, user: null })
    }
});


// TOKEN VALIDITY API CHECK :
authRouter.post('/token_validation', async (req, res) => {
    try {
        const token = req.header("auth_token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await userModel.findById(verified.id);
        if (!user) return res.json(false);
        return res.json(true);


    } catch (error) {
        return res.status(500).json({ error: error });
    }
});

// GET USER DATA API :
authRouter.get("/user_data", authorization , async (req, res) => {
    // this middleware will makesure that the user are authorized . 
    const user = await userModel.findById(req.user);
    return res.json({ ...user._doc, token: req.token });
});



