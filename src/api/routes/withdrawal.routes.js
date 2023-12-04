import express from "express"
import withdrawalController from "../controllers/withdrawal.controller.js"



const { add_withdrawal,get_withdrawals_by_account_number,get_withdrawal_by_date } = withdrawalController
const router = express.Router()
console.log("Transacton route")

router.get("/")
router.post("/withdrawal", add_withdrawal)
router.post("/my_withdrawals", get_withdrawals_by_account_number)
router.post("/date_withdrawals", get_withdrawal_by_date)

// module.exports = router

export default router
