const mongoose = require("mongoose");
const { productSchema } = require("./product");
const orderSchema = mongoose.Schema({

    products: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            }
        }
    ],

    totalPrice: {
        required: true,
        type: Number,
    },


    address: {
        type: String,
        required: true,
    },

    userID: {
        required: true,
        type: String,
    },


    date: {
        required: true,
        type: Number,
    },

    status: {
        type: Number,
        default: 0,
    }
    
});


const OrderModel = mongoose.model("Order", orderSchema);
module.exports = OrderModel; 