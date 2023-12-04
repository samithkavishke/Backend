import Withdrawal from "../models/withdrawal.model.js"
const add_withdrawal = async (req, res) => {
    const account_number = req.body.account_number
    try{
    const withdrawal = await Withdrawal.createWithdrawal(account_number)
      console.log(withdrawal)
        return res.send({ withdrawal: withdrawal })
    } catch (err) {
      console.log(err)
      return res.send({ approved: false })
    }
  
    
  }

    const get_withdrawals_by_account_number = async (req, res) => {
        const account_number = req.body.account_number
    
        try{
        const withdrawal = await Withdrawal.getWithdrawalByAccountNumber(account_number)
          console.log(" Withdrawal fetched")
          return res.send({ withdrawal: withdrawal })
        } catch (err) {
          console.log(err)
          return res.send({ approved: false })
        }
      
        //console.log("Get Transaction function")
      }

        const get_withdrawal_by_date = async (req, res) => {
            const withdrawal_date = req.body.withdrawal_date
            try{
            const withdrawal = await Withdrawal.getWithdrawalByDate(withdrawal_date)
            
              console.log("Withdrawal fetched")
              return res.send({ withdrawal: withdrawal })
            } catch (err) {
              console.log(err)
              return res.send({ approved: false })
            }
          
            //console.log("Get Transaction function")
          }

    export default {add_withdrawal,get_withdrawals_by_account_number,get_withdrawal_by_date}
