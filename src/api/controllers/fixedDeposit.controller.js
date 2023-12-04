import FixedDeposit from "../models/fixedDeposit.model.js"




const my_fd_list = async (req, res) => {
    const NIC = req.body.NIC
    
    try{
    const FDs = await FixedDeposit.getFDByNIC(NIC)
        console.log("FD list fetched")
        console.log(FDs)
        return res.send({ approved:true,FDs: FDs })
    
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("get loan list function")
    }

   // console.log("Get Account list function")
}
const getMaxLoanForFD = async (req, res) => {
    const FD_id = req.body.FD_id
    
    try{
    const loan_amount = await FixedDeposit.getMaxLoanForFD(FD_id)
        console.log("Loan amount fetched")
        console.log(loan_amount)
        return res.send({approved:true, loan_amount: loan_amount })
    
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("get loan amount function")
    }

   // console.log("Get Account list function")
}


export default {my_fd_list, getMaxLoanForFD}


 