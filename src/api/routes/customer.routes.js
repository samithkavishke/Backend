import express from "express"

import customerController from "../controllers/customer.controller.js"

const { add_customer, get_customer } = customerController
const router = express.Router()
console.log("Customer route")

router.get("/")
router.post("/add_customer", add_customer)
router.post("/get_customer", get_customer)

// module.exports = router

export default router
