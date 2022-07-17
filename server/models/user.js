const mongoose = require("mongoose");
const { productSchema } = require("./product");
const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validator: (value) => {
            const regex =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
            return value.match(regex);

        },
        message: "please enter a valid email address",
    },
    password: {
        required: true,
        trim: true,
        type: String,
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "user",
    },
    token: {
        type: String,
        default: "",
    },

    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            }
        }
    ],




});



const userModel = mongoose.model("User", userSchema);
module.exports = userModel; 
