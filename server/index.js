// packages imports : 
const express = require("express");
const authRouter = require("./routes/auth")
const adminRouter = require("./routes/admin")
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const mongoose = require("mongoose");



// initializations : 
// const PORT =process.env.PORT || 3000;

const PORT = 3000;
const app = express();

const DBurl = "mongodb+srv://rashed:rashed.ghu@cluster0.vslls.mongodb.net/?retryWrites=true&w=majority";

//Routes : 
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// connections : 
app.listen(PORT, "0.0.0.0", () => {
    console.log("server connected at port " + PORT);
});


mongoose.connect(DBurl).then((promise) => {
    console.log("connected to mongoDB");
}).catch((error) => {
    console.log("mongo DB error " + error);
});

app.get("/" , async(res,res)=>{
    console.log("WORKING");
})

