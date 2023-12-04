import db from "./db.js"
class FixedDeposit {
    constructor(FD_id,saving_account_number,amount,plan_id,starting_date ) {
        this.FD_id = FD_id
        this.saving_account_number = saving_account_number
        this.amount = amount
        this.plan_id = plan_id
        this.starting_date = starting_date
    }

    

    static async getFDByNIC(NIC) {
        let FdList  = ''
        const sqlQuery = 'select *  from fixedDeposit where saving_account_number in (select  account_number from saving_account where account_number in (select account_number  from account where customer_NIC = ?))';
        try{
            const [rows,fields] = await db.execute(sqlQuery, [NIC]);

            const FD = rows? rows.map(row=>({
                FD_id: row.FD_id,
                saving_account_number: row.saving_account_number,
                amount: row.amount,
                plan_id: row.plan_id,
                starting_date:new Date(row.starting_date).toLocaleDateString()

            })) : null;
            return FD;
        }
        catch(error){
            console.error('Error fetching user by NIC and type:', error);
            throw error;
        }
    }

    static async getMaxLoanForFD(FD_id) {
        let loan_amount  = ''
        const sqlQuery = 'CALL defaultdb.getMaxLoanForFD(?,@loan_amount)';
        try{
            const [rows] = await db.execute(sqlQuery, [FD_id]);
            const [[output]] = await db.query('SELECT @loan_amount AS output');
            

           
            loan_amount = output.output;
            return loan_amount;
            
            }
            
        
        catch(error){
            console.error('Error fetching user by FD_id:', error);
            throw error;
        }
    }
    
}



export default FixedDeposit
