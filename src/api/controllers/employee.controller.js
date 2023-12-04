import Employee from "../models/employee.model.js";


  const get_employee_branch_code = async (req, res) => {
    const NIC = req.body.NIC
    
    try{
    const branch_code = await Employee.getEmployeeBranch(NIC)
      console.log("Customer found")
      return res.send({ approved: true, branch_code:branch_code }) // Send the user object without password_hash
    } catch (err) {
      console.log(err)
      return res.send({ approved: false })
    }
  finally{
    console.log("Get branch code function")}
  }
  export default {get_employee_branch_code}