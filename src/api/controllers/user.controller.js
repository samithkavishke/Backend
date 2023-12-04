import {
  comparePassword,
  generateHash,
  is_Customer,
} from "../services/user.service.js"
import User from "../models/user.model.js"
import Customer from "../models/customer.model.js"

const login = async (req, res) => {
  const NIC = req.body.NIC
  const password = req.body.password
  try {
    const user = await User.getUserByUserNIC(NIC)
    const hash = user.password_hash
    console.log(hash)
    if (hash === null) {
      console.log("User not found")
      return res.send({ approved: false })
    }
     const password_hash = hash
    const match = await comparePassword(password, hash)
    console.log(NIC, password, hash)
    if (match) {
      console.log("Login successful")
      const { password_hash, ...userWithoutPassword } = user; // Exclude password_hash from the user object
      return res.send({ approved: true, user: userWithoutPassword }) // Send the user object without password_hash
    
    } else {
      console.log("Login failed")
      return res.send({ approved: false })
    }
  } catch (err) {
    console.log(err)
    return res.send({ approved: false })
  }
}
 
const registerCustomer = async (req, res) => {
  const NIC = req.body.NIC
  const username = req.body.username
  const password = req.body.password
  const hash = await generateHash(password)
  try {
    console.log(NIC, username, hash)
    const message = await User.createCustomerUser(username, hash,NIC)
    if (message == "successful") {
      console.log("User created")
      return res.send({ approved: true })  
    } else {
      console.log(message)
      console.log("User not created")
      return res.send({ approved: false })
    }
  } catch (err) {
    console.log(err)
    return res.send({ approved: false })
  }  
  finally{console.log("Registration function")}
}

const registerEmployee = async (req, res) => {
  const NIC = req.body.NIC
  const username = req.body.username
  const password = req.body.password
  const hash = await generateHash(password)
  try {
    const message = await User.createEmployeeUser(username, hash,NIC)
    if (message == "success") {
      console.log("User created")
      return res.send({ approved: true })  
    } else {
      console.log("User not created")
      return res.send({ approved: false })
    }
  } catch (err) {
    console.log(err)
    return res.send({ approved: false })
  }
  finally{console.log("Registration function")}
}


const check_eligibility = async (req, res) => {
  const NIC = req.body.NIC
  const name = req.body.name

  try {

    const customer = await Customer.getCustomerByNIC(NIC,name)
    
    if (customer) {
      console.log("Customer found")
      return res.send({ approved: true })
    } else {
      console.log("Customer not found")
      return res.send({ approved: false })
    }
  } catch (err) {
    console.log(err)
    return res.send({ approved: false })
  }
}

export default { login, registerCustomer ,registerEmployee, check_eligibility}
