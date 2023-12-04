import db from "./db.js"
class Account {
    constructor(account_number, type,customer_NIC, branch_code, balance) {
        this.account_number = account_number
        this.type = type
        this.customer_NIC = customer_NIC
        this.branch_code = branch_code
        this.balance = balance
      
    }

    static async createCurrentAccount(account_number, type,customer_NIC, branch_code, balance) {
        const { rows } = await db.query(
          'CALL defaultdb.createBankAccount(?,?,?,?,?)',
          [account_number, type,customer_NIC, branch_code, balance]
      
        )
        const output_message = rows ? rows[0] : null;
        return output_message;
      }

    static async getAccountsByNICAndType(NIC, type) {
        const sqlQuery = 'SELECT account_number, balance FROM defaultdb.account WHERE customer_NIC = ? and type = ?';
        try{
            const [rows,fields] = await db.execute(sqlQuery, [NIC, type]);

            const account = rows? rows.map(row=>({
                account_number: row.account_number,
                balance: row.balance
            })) : null;
            return account;
        }
        catch(error){
            console.error('Error fetching user by NIC and type:', error);
            throw error;
        }
    }

    static async getAccountByAccountNumber(account_number) {
        const sqlQuery = 'SELECT balance FROM defaultdb.account WHERE account_number = ? and type = ?';
        try{
            const [rows] = await db.execute(sqlQuery, [account_number,'current']);

            const account = rows? rows[0] : null;
            return account;
            
            }
            
        
        catch(error){
            console.error('Error fetching user by account number:', error);
            throw error;
        }
    }
    
    static async updateBalance(account_number, balance) {
        const sqlQuery = 'call defaultdb.updateBalance(?,?)';
        try{
            const [rows] = await db.execute(sqlQuery, [account_number,balance]);

            const account = rows? rows[0] : null;
            return account;
            
            }
            
        
        catch(error){
            console.error('Error fetching user by account number:', error);
            throw error;
        }
    }
}



export default Account
