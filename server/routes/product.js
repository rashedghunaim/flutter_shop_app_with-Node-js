const express = require("express");
const productRouter = express.Router();
const authorization = require("../middlewares/auth");
const { productModel } = require("../models/product");


// FETCH PRODUCT BY CATEGORY API : 
productRouter.get("/api/get_products", authorization, async (req, res) => {
    try {
        const products = await productModel.find({ category: req.query.category });
        return res.status(200).json(products);

    } catch (error) {
        res.status(500).json({ msg: error.message });
    }

});



// SEARCHPRODUCTS API : 
productRouter.get("/api/products/search/:name", authorization, async (req, res) => {
    try {
        const products = await productModel.find({
            name: { $regex: req.params.name, $options: "i" }
        });
        return res.status(200).json(products);

    } catch (error) {
        res.status(500).json({ msg: error.message });
    }

});



// RATING API : 
productRouter.post("/api/rate_product", authorization, async (req, res) => {
    try {
        const { productId, rating } = req.body;
        let product = await productModel.findById({ _id: productId })
        console.log(product);

        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userID == req.user) {
                product.ratings.splice(i, 1);
                break;
            }

        }
        const ratingSchema = {
            userID: req.user,
            ratings: rating
        }
        product.ratings.push(ratingSchema);
        product = await product.save();
        return res.status(200).json(product);


    } catch (error) {
        return res.status(500).json({ msg: error.message });

    }
});


// FETCH TODAYS DEAL PRODUCT : 
productRouter.get("/api/todays_deal", authorization, async (rea, res) => {
    try {
        let products = await productModel.find({});

        const sortedProducts = products.sort((productA, productB) => {
            let aSum = 0;
            let bSum = 0;

            for (let i = 0; i < productA.ratings.length; i++) {
                aSum += productA.ratings[i].ratings;
            }

            for (let i = 0; i < productB.ratings.length; i++) {
                bSum += productB.ratings[i].ratings;
            }
            return aSum < bSum ? 1 : -1

        });

        return res.status(200).json(sortedProducts[0]);

    } catch (error) {
        return res.status(500).json({ msg: error.message });

    }
});


// FETCH ALL PRODUCTS API : 
productRouter.get("/api/get_all_products", authorization, async (rea, res) => {
    try {
        const products = await productModel.find({});

        return res.status(200).json(products);

    } catch (error) {
        return res.status(500).json({ msg: error.message });

    }
});

module.exports = productRouter;



