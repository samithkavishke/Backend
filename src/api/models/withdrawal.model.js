import db from "./db.js"
class Withdrawal {
    constructor(Withdrawal_id,account_number,withdrawal_amount,withdrawal_date,withdrawal_time) {
        this.Withdrawal_id = Withdrawal_id
        this.account_number = account_number
        this.withdrawal_amount = withdrawal_amount
        this.withdrawal_date = withdrawal_date
        this.withdrawal_time = withdrawal_time
    }

    static async createWithdrawal(account_number,withdrawal_amount) {
        const sqlQuery = 'CALL defaultdb.doWithdrawal(?,?)';
        //console.log(sqlQuery)
        
            const [rows,fields] = await db.execute(sqlQuery, [account_number,withdrawal_amount]);
            //console.log(rows)
            const output_message = rows ? rows[0] : null;
            //console.log(output_message)
            return output_message;
            
        
       
      }

    static async getWithdrawalByAccountNumber(account_number) {
        const sqlQuery = 'SELECT Withdrawal_id,account_number,withdrawal_amount,withdrawal_date,withdrawal_time FROM defaultdb.Withdrawal WHERE account_number = ?';
        try{
            const [rows,fields] = await db.execute(sqlQuery, [account_number]);

            const withdrawal = rows? rows.map(row=>({
                Withdrawal_id: row.Withdrawal_id,
                account_number: row.account_number,
                withdrawal_amount: row.withdrawal_amount,
                withdrawal_date: row.withdrawal_date,
                withdrawal_time: row.withdrawal_time
            })) : null;
            return withdrawal;
            
        }
        catch(error){
            console.error('Error fetching user by account_number :', error);
            throw error;
        }
    }

    static async getWithdrawalByDate(withdrawal_date) {
        const sqlQuery = 'SELECT Withdrawal_id,account_number,withdrawal_amount,withdrawal_date,withdrawal_time FROM defaultdb.Withdrawal WHERE withdrawal_date = ?';
        try{
            const [rows,fields] = await db.execute(sqlQuery, [withdrawal_date]);

            const withdrawal = rows? rows.map(row=>({
                Withdrawal_id: row.Withdrawal_id,
                account_number: row.account_number,
                withdrawal_amount: row.withdrawal_amount,
                withdrawal_date: row.withdrawal_date,
                withdrawal_time: row.withdrawal_time
            })) : null;
            return transaction;
        }
        catch(error){
            console.error('Error fetching user by transaction_date :', error);
            throw error;
        }
    }

    
}

export default Withdrawal
