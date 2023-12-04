import db from "./db.js"
class Branch {
    constructor(branch_code,branch_name, address) {
        this.branch_code = branch_code
        this.branch_name = branch_name
        this.address = address
    
    }

    static async createBranch(branch_code,branch_name, address) {
        const { rows } = await db.query(
          'INSERT INTO defaultdb.Branch (branch_code,branch_name, address) VALUES (?, ?, ?)',
          [branch_code,branch_name, address]
      
        )
      }

    static async getBranchByBranchName(branch_name) {
        const sqlQuery = 'SELECT branch_code FROM defaultdb.Branch WHERE branch_name = ?';
        try{
            const [rows,fields] = await db.execute(sqlQuery, [branch_name]);

            const branch = rows? rows.map(row=>({
                branch_code: row.branch_code,
            })) : null;
            return branch;
        }
        catch(error){
            console.error('Error fetching user by branch_name :', error);
            throw error;
        }
    }

    
    
}

export default Branch
