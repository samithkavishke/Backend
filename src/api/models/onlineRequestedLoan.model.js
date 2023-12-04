import db from "./db.js"
class OnlineLoan {
    constructor(loan_id,amount, interest_rate,loan_period,approved,request_type,customer_NIC,remaining_installments,branch_code,starting_date, FD_id, description) {
        this.loan_id = loan_id
        this.amount = amount
        this.interest_rate = interest_rate
        this.loan_period = loan_period
        this.approved = approved
        this.request_type = request_type
        this.customer_NIC = customer_NIC
        this.remaining_installments = remaining_installments
        this.branch_code = branch_code
        this.starting_date = starting_date
        this.FD_id = FD_id
        this.description = description
      
    }

    static async createOnlineLoan(amount,loan_period,customer_NIC,saving_account_number, FD_id,max_loan) {
      let message = ''
      let balance = 0
        const { rows } = await db.query(
          'CALL defaultdb.insertToOnlineRequestedLoan(  ?, ?, ?, ?, ?, ? , ?,?, @balance,@message)',
            [amount,loan_period,'online',customer_NIC,saving_account_number, FD_id, max_loan,"online requested loan"]
        )
        const [[output_message]] = await db.query('SELECT @message AS output_message');
        const [[output_balance]] = await db.query('SELECT @balance AS output_balance');
        
        message = output_message.output_message;
        balance = output_balance.output_balance;
        console.log(message)
        return [message, balance];
      }


    

    
            
        
       
    
}



export default OnlineLoan;
