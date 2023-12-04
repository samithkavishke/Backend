import Account from "../models/account.model.js"
import SavingAccount from "../models/savingAccount.model.js"
let created_accounts = 10;
const add_current_account = async (req, res) => {
    const type = req.body.type
    const customer_NIC = req.body.customer_NIC
    const branch_code = req.body.branch_code
    const balance = req.body.balance
    
    
    
    try{
    created_accounts = created_accounts + 1;
    const account_number  = created_accounts.toString().padStart(10, '0');
    const account = await Account.createAccount(account_number, type,customer_NIC, branch_code, balance)
      console.log("Account created")
    } catch (err) {
      console.log(err)
      return res.send({ approved: false })
    }
  
    console.log("Add Account function")
  
}

const add_saving_account = async (req, res) => {
    
    const type = req.body.type
    const customer_NIC = req.body.customer_NIC
    const branch_code = req.body.branch_code
    const balance = req.body.balance
    const plan_id = req.body.plan_id

    if (type == "savings") {
        
    try{
    created_accounts = created_accounts + 1;
    const account_number  = created_accounts.toString().padStart(10, '0');
    const account = await SavingAccount.createSavingAccount(account_number, type,customer_NIC, branch_code, balance, plan_id)
      console.log("Account created")
    } catch (err) {
      console.log(err)
      return res.send({ approved: false })
    }
  
    console.log("Add Account function")
  }
}

const get_account_list = async (req, res) => {
    const NIC = req.body.NIC
    const type = req.body.type
    console.log("inside account controller",NIC, type)
    try{
    const account = await Account.getAccountsByNICAndType(NIC, type)
        console.log("Account list fetched")
        console.log("hi",account)
        return res.send({ approved:true, account: account })
        
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("Get Account list function")
    }

   // console.log("Get Account list function")
}

const get_account_details = async (req, res) => {
    const account_number = req.body.account_number
    try{
    const account = await Account.getAccountByAccountNumber(account_number)
        console.log("Account details fetched")
        return res.send({ approved:true, account: account })
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("Get Account details function")
    }

}

const get_saving_account_details = async (req, res) => {
    const account_number = req.body.account_number
    try{
    const account = await SavingAccount.getAccountByAccountNumber(account_number)
        console.log("Account details fetched")
        return res.send({ approved:true,account: account[0] })
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("Get Account details function")
    }

}

export default {add_current_account, add_saving_account, get_account_list, get_account_details, get_saving_account_details}


 