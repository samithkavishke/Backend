import express from "express"

import transactionController from "../controllers/transaction.controller.js"

const { add_transaction,get_transaction_by_account_number,get_transaction_by_date, get_transaction_by_branch } = transactionController
const router = express.Router()
console.log("Transacton route")

router.get("/")
router.post("/transaction", add_transaction)
router.post("/my_transactions", get_transaction_by_account_number)
router.post("/date_transactions", get_transaction_by_date)
router.post("/branch_transactions", get_transaction_by_branch)

// module.exports = router

export default router
