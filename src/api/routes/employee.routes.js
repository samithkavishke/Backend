import express from "express"

import employeeController from "../controllers/employee.controller.js"

const { get_employee_branch_code } = employeeController
const router = express.Router()
console.log("Employee route")

router.get("/")
router.post("/get_employee_branch_code", get_employee_branch_code)

// module.exports = router

export default router
