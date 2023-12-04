import express, { json } from "express"
import pkg from "body-parser"
import session from "express-session"
import cors from "cors"
import cookieParser from "cookie-parser"

import UserRoute from "./routes/user.routes.js"
import CustomerRoute from "./routes/customer.routes.js"
import AccountRoute from "./routes/account.routes.js"
import TransactionRoute from "./routes/transaction.routes.js"
import FixedDepositRoute from "./routes/fixedDeposit.routes.js"
import InstallmentRoute from "./routes/installment.routes.js"
import EmployeeRoute from "./routes/employee.routes.js"
import LoanRoute from "./routes/loan.routes.js"
//console.log("hi")
const app = express()
const { urlencoded } = pkg
const PORT = process.env.PORT || 3002

app.listen(PORT, () => console.log(`Server live at http://localhost:${PORT}`))

app.use(cors())
app.use(urlencoded({ extended: false }))
app.use(session({ secret: "secret", resave: true, saveUninitialized: true }))
app.use(express.static("public"))
app.set("view engine", "ejs")
app.use(json())
app.use(cookieParser())

process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0
console.log("hi")
// Route for index

app.use("/user", UserRoute)
app.use("/customer", CustomerRoute)
app.use("/account", AccountRoute)
app.use("/transaction", TransactionRoute)
app.use("/FD",FixedDepositRoute)
app.use("/loan",LoanRoute)
app.use("/installment",InstallmentRoute)
app.use("/employee",EmployeeRoute)


