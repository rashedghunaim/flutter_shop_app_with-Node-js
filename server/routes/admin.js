const express = require("express");
const adminRouter = express.Router();
const adminAuthorization = require("../middlewares/admin");
const { productModel } = require("../models/product");
const orderModel = require("../models/order");
const { findById } = require("../models/order");


// CREATING ADDING NEW PRODUCT API :
adminRouter.post("/admin/add_product", adminAuthorization, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category, userID } = req.body;
        let product = new productModel(
            {
                name,
                description,
                price,
                quantity,
                images,
                category,
                userID,
            }
        );
        product = await product.save();
        return res.status(200).json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });

    }
});
module.exports = adminRouter;


// FETCH ALL PRODUCTS API :
adminRouter.get("/admin/get_products", adminAuthorization, async (req, res) => {
    try {
        const products = await productModel.find({});
        return res.status(200).json(products);
    } catch (error) {

        return res.status(500).json({ msg: error.message });
    }
});



// DELEAT PRODUCT API  :
adminRouter.post("/admin/delete_product", adminAuthorization, async (req, res) => {
    try {
        const { productID: productID } = req.body;
        let product = await productModel.findByIdAndDelete(productID);
        res.status(200).json(product);

    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
});


//FETCH ALL USERS ORDERS API :
adminRouter.get("/admin/get_all_orders", adminAuthorization, async (rea, res) => {
    try {
        const orders = await orderModel.find({});
        return res.status(200).json(orders);

    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
});


// CHANGE ORDER STATUS API : 
adminRouter.post("/admin_change_order_status", adminAuthorization, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await orderModel.findById(id);
        order.status = status;
        order = await order.save();
        return res.status(200).json(order);

    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
});


// ANALYTICS API : 
adminRouter.get("/admin/collect_earnings", adminAuthorization, async (req, res) => {
    try {
        const orders = await orderModel.find({});
        //fetch all orders then get total earnings of products: 
        let totalEarnings = 0;
        for (let i = 0; i < orders.length; i++) {
            for (let j = 0; j < orders[i].products.length; j++) {
                totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }

        // CATEGORY WISE ORDER FETCHING : 
        let ArtEarnings = await fetchCategoryWiseProduct("Art");
        let BabyEarnings = await fetchCategoryWiseProduct("Baby");
        let BooksEarnings = await fetchCategoryWiseProduct("Books");
        let FashionEarnings = await fetchCategoryWiseProduct("Fashion");
        let HomeEarnings = await fetchCategoryWiseProduct("Home");
        let MobilesEarnings = await fetchCategoryWiseProduct("Mobiles");
        let SelfCareEarnings = await fetchCategoryWiseProduct("Self-Care");
        let SportsEarnings = await fetchCategoryWiseProduct("Sports");


        let earnings = {
            totalEarnings,
            ArtEarnings,
            BabyEarnings,
            BooksEarnings,
            FashionEarnings,
            HomeEarnings,
            MobilesEarnings,
            SelfCareEarnings,
            SportsEarnings,
        };

        return res.status(200).json(earnings);

    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
});

const fetchCategoryWiseProduct = async (category) => {
    let categoryOrders = await orderModel.find({
        'products.product.category': category
    });
    // fetch all orders by category then get total earnings of products: 
    let earnings = 0;
    for (let i = 0; i < categoryOrders.length; i++) {
        for (let j = 0; j < categoryOrders[i].products.length; j++) {
            earnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
        }
    }
    return earnings;
}

