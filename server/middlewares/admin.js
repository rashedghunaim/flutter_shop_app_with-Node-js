const jwt = require("jsonwebtoken");
const userModel = require("../models/user")

const adminAuthorization = async (req, res, next) => {
    try {
        const token = req.header("auth_token");
        if (!token) return res.status(401).json({ msg: "No token , access denied" });
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.status(401).json({ msg: "Token verification  failed , Authorization denied ." });


        const user = await userModel.findById(verified.id);
        if (user.type == "user" || user.type == "seller") {
            return res.status(400).json({ msg: "Access Designed , you are not an Admin." });
        } else {
            console.log("client side user id is" + verified.id);
            req.user = verified.id;
            req.token = token;
            next();
        }

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({ msg: error.message });
    }
}


module.exports = adminAuthorization; 
