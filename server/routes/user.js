const express = require("express");
const userRouter = express.Router();
const authorization = require("../middlewares/auth");
const { productModel } = require("../models/product");
const userModel = require("../models/user");
const orderModel = require("../models/order");

userRouter.post("/api/add_to_cart", authorization, async (req, res) => {
    try {
        const { productID } = req.body;
        const product = await productModel.findById(productID);

        let user = await userModel.findById(req.user);
        if (user.cart.length == 0) {

            user.cart.push({ product, quantity: 1 });
        } else {

            let isProductFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true;
                } else {
                    isProductFound = false;
                }
            }

            if (isProductFound == true) {
                let existingProduct = user.cart.find((item) => item.product._id.equals(product._id));
                existingProduct.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }


        }
        user = await user.save();
        return res.status(200).json(user);
    } catch (error) {
        console.log(error.message);
        res.status(500).json({ error: error.message });

    }
});



// DECREAING/deleting  CART QUANTITY API : 
userRouter.delete("/api/remove_from_cart/:productID", authorization, async (req, res) => {
    try {
        const { productID } = req.params;
        const product = await productModel.findById(productID);

        let user = await userModel.findById(req.user);


        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                if (user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1
                }

            }
        }

        user = await user.save();
        return res.status(200).json(user);
    } catch (error) {
        console.log(error.message);
        res.status(500).json({ error: error.message });

    }
});





// SAVE USER ADDRESS . 
userRouter.post("/api/save_user_address", authorization, async (req, res) => {
    try {
        const { address } = req.body;
        let user = await userModel.findById(req.user);
        user.address = address;
        user = await user.save();
        return res.status(200).json(user);
    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
});




// ORDER API : 
userRouter.post("/api/order", authorization, async (req, res) => {
    try {
        const { address, cart, totalPrice } = req.body;
        let user = await userModel.findById(req.user);

        let products = [];
        for (let i = 0; i < cart.length; i++) {
            let product = await productModel.findById(cart[i].product._id);
            if (product.quantity >= cart[i].quantity) {
                product.quantity -= cart[i].quantity;
                products.push({ product, quantity: cart[i].quantity });
                await product.save();
            } else {
                return res.status(400).json({ msg: `${product.name} is out of stock` });
            }
        }

        console.log(products[0]);

        user.cart = [];
        user = await user.save();

        let order = new orderModel({
            products,
            totalPrice,
            address,
            userID: req.user,
            date: new Date().getTime(),
        });


        order = await order.save();
        return res.status(200).json(order);

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({ msg: error.message });
    }
});





// FETCH ORDERS API : 
userRouter.get("/api/orders/me", authorization, async (req, res) => {
    try {
        let userOrders = await orderModel.find({ userID: req.user });
        return res.status(200).json(userOrders);
    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
});




module.exports = userRouter;

