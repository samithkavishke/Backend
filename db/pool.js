import pkg from 'pg'
import dotenv from 'dotenv'

dotenv.config()

const { Client } = pkg
const client = new Client({
  host: process.env.DB_HOST,
  user: process.env.DB_USERNAME,
  port: process.env.DB_PORT,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  ssl: {
    ca: '../../ca-certificate.crt'
  }
})
process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0

client.connect()

export default client
