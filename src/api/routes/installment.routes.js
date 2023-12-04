import express from "express"

import installmentController from "../controllers/installment.controller.js"


const { getMyInstallments, getLateInstallmentsByBranch} = installmentController
const router = express.Router()
console.log("Installmentt route")

router.get("/")
router.post("/get_my_installments", getMyInstallments)
router.post("/get_late_installments_by_branch", getLateInstallmentsByBranch)


// module.exports = router

export default router
