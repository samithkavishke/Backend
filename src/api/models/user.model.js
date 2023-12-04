// const db = require("./db") // Import your database configuration
import db from "./db.js"
class User {
  constructor(customer_NIC, username, password_hash, user_type) {
    this.customer_NIC = customer_NIC
    this.username = username
    this.password_hash = password_hash
    this.user_type = user_type
    
  }

  static async createCustomerUser(username, password_hash,customer_NIC) {
    let message = ''
    const { rows } = await db.query(
      'CALL defaultdb.registerCustomerUser(?,?,?,@message)',
      [customer_NIC, username, password_hash]
    )
    const [[output_message]] = await db.query('SELECT @message AS output_message');
    message = output_message.output_message;
    // const message  = rows[0][0].output_message
    console.log(message)
    return message
    
  }
  static async createEmployeeUser(username, password_hash,customer_NIC) {
    const { rows } = await db.query(
      'CALL defaultdb.registerEmployeeUser(?,?,?)',
      [customer_NIC, username, password_hash]
  
    )
    
    const message  = rows? rows[0]: null
    return message
    
  }

  static async getUserByUserNIC(NIC) {
    const sqlQuery = 'SELECT * FROM defaultdb.user WHERE user_NIC = ?';
    
    try {
      // Log the final SQL query with the parameter value
      const finalQuery = db.format(sqlQuery, [NIC]);
      console.log('Final SQL Query:', finalQuery);
  
      const [rows, fields] = await db.execute(sqlQuery, [NIC ]);
      console.log(rows)
      console.log(fields)
      const user = rows ? rows[0] : null;
      //console.log(user)
      return new User(
        user.user_NIC,
        user.username,
        user.password_hash,
        user.user_type
      );
    } catch (error) {
      // Handle the database query error here
      console.error('Error fetching user by NIC:', error);
      throw error; // You can rethrow the error or handle it as needed
    }
  }
  
}

export default User