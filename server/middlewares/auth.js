const jwt = require("jsonwebtoken");

const authorization = async (req, res, next) => {
    try {
        const token = req.header("auth_token");
        if (!token) return res.status(401).json({ msg: "No token , access denied" });

        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.status(401).json({ msg: "Token verification  failed , Authorization denied ." });

        req.user = verified.id;
        req.token = token;
        next();
    } catch (error) {
        return res.status(500).json({ error: error.message });
    }
};


module.exports = authorization; 