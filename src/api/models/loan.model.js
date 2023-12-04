import db from "./db.js"
class Loan {
    constructor(loan_id,amount,loan_period,approved,request_type,customer_NIC,remaining_installments,branch_code,starting_date,description) {
        this.loan_id = loan_id
        this.amount = amount
        this.loan_period = loan_period
        this.approved = approved
        this.request_type = request_type
        this.customer_NIC = customer_NIC
        this.remaining_installments = remaining_installments
        this.branch_code = branch_code
        this.starting_date = starting_date
        this.description = description
      
    }

    static async createLoan(amount,loan_period,request_type,customer_NIC,branch_code,description) {
        const { rows } = await db.query(
          'CALL defaultdb.insertToLoan( UUID(),?, ?, ?, ?, ?, ?, ?)',
            [amount,loan_period,0,request_type,customer_NIC,branch_code, description]
      
        )
        const output_message = rows ? rows[0] : null;
        return output_message;
      }

    

    static async getLoanByCustomerNIC(customer_NIC) {
        const sqlQuery = 'SELECT * FROM loan WHERE customer_NIC =?  and approved = 1';
        try{
            const [rows] = await db.execute(sqlQuery, [customer_NIC]);
            const loan = rows? rows.map(
                row=>({
                loan_id: row.loan_id,
                amount: row.amount,
                interest_rate: row.interest_rate,
                loan_period: row.loan_period,
                approved: row.approved,
                request_type: row.request_type,
                remaining_installments: row.remaining_installments,
                branch_code: row.branch_code,
                starting_date: row.starting_date
            }))
             : null;
            return loan;
            
            }
            
        
        catch(error){
            console.error('error whicle fetching data', error);
            throw error;
        }
    }
    
    
}



export default Loan;
