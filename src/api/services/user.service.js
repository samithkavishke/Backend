import bcrypt from "bcrypt"
import Customer from "../models/customer.model.js"

export const comparePassword = async (password, hash) => {
  return await bcrypt.compare(password, hash)
}

export const generateHash = async (password) => {
  try{
    return await bcrypt.hash(password, 10)
  }
  catch(err){
    console.log("Error hashing the password:", err)
  }
  
}

export const is_Customer = async (NIC, name) => {
  const customer = await Customer.getCustomerByNIC(NIC,name)
  if (customer === null) {
    console.log("Customer not found")
    return false
  }
  return true
}
