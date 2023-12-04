import Installment from "../models/installments.model.js"





const getMyInstallments = async (req, res) => {
    const NIC = req.body.NIC
    
    try{
    const installment = await Installment.getMyInstallments(NIC)
        console.log("Installment list fetched")
        console.log(installment)
        return res.send({ installment: installment })
    
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("get user installment list function")
    }

   // console.log("Get Account list function")
}

const getLateInstallmentsByBranch = async (req, res) => {
    const branch_code = req.body.branch_code
    
    try{
    const installment = await Installment.getLateInstallmentsByBranch(branch_code)
        console.log("Installment list fetched")
        console.log(installment)
        return res.send({ approved:true,installment: installment })
    
    } catch (err) {
        console.log(err)
        return res.send({ approved: false })
    }
    finally{
        console.log("get late installment list function")
    }

   // console.log("Get Account list function")
}


export default { getMyInstallments, getLateInstallmentsByBranch}


 