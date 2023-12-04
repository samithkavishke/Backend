import express from "express"

import fixedDepositController from "../controllers/fixedDeposit.controller.js"


const { my_fd_list, getMaxLoanForFD } = fixedDepositController
const router = express.Router()
console.log("FD route")

router.get("/")
router.post("/my_fd_list", my_fd_list)
router.post("/getMaxLoanForFD", getMaxLoanForFD)

export default router
