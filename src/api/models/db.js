import mysql from "mysql2/promise";
import dotenv from "dotenv"

//const { Pool } = mysql.
dotenv.config()

const db = mysql.createPool({
  user: 'doadmin',
  password: 'AVNS_gJJ2cWco9i3zs_QHmbc',
  host: 'db-mysql-nyc1-58007-do-user-14522602-0.b.db.ondigitalocean.com',
  database: 'defaultdb',
  port: 25060,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  
})


process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0
// Call the example query function
// executeExampleQuery();


export default db
