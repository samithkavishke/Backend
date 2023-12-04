import db from "./db.js"
class SavingAccount {
    constructor(account_number, plan_id) {
        this.account_number = account_number
        this.plan_id = plan_id
      
    }

    static async createSavingAccount(account_number, type,customer_NIC, branch_code, initial_deposit, plan_id) {
        const { rows } = await db.query(
          'CALL defaultdb.createSavingBankAccount(?,?,?,?,?,?)',
          [account_number, type,customer_NIC, branch_code, initial_deposit, plan_id]
      
        )
        const output_message = rows ? rows[0] : null;
        return output_message;
      }

    

    static async getAccountByAccountNumber(account_number) {
        const sqlQuery = 'CALL defaultdb.getAccountByAccountNumber(?)';
        try{
            const [rows] = await db.execute(sqlQuery, [account_number]);

            const account = rows? rows[0] : null;
            return account;
            
        }
            
        
        catch(error){
            console.error('Error fetching user by account number:', error);
            throw error;
        }
    }
    
    
            
       
}



export default SavingAccount
