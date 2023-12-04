import express from "express"

import loanController from "../controllers/loan.controller.js"


const { add_loan, my_loan_list, createOnlineLoan } = loanController
const router = express.Router()
console.log("Account route")

router.get("/")
router.post("/add_loan", add_loan)
router.post("/my_loan_list", my_loan_list)
router.post("/createOnlineLoan", createOnlineLoan)

// module.exports = router

export default router
