import express from "express"

import userController from "../controllers/user.controller.js"

const { login, registerCustomer,registerEmployee, check_eligibility } = userController

const router = express.Router()

router.get("/")
router.post("/login", login)
router.post("/registerCustomer", registerCustomer)
router.post("/check_eligibility", check_eligibility)
router.post("/registerEmployee", registerEmployee)


// module.exports = router

export default router
