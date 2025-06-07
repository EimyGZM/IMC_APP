
const sql = require('mssql');
require('dotenv').config(); 
const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,/// 192.168.1.10
    database: process.env.DB_DATABASE,
    options: {
        encrypt: process.env.DB_ENCRYPT === 'true', 
        trustServerCertificate: process.env.DB_TRUST_SERVER_CERTIFICATE === 'true'
    },
    pool: {
        max: 10,
        min: 0,
        idleTimeoutMillis: 30000
    }
};

let pool; 
async function connectDb() {
    try {
        if (!pool) {
            pool = new sql.ConnectionPool(config);
            await pool.connect();
            console.log('Conexión a SQL Server exitosa.');
        }
        return pool;
    } catch (err) {
        console.error('Error al conectar a SQL Server:', err.message);
        throw err; 
    }
}

async function closeDb() {
    if (pool) {
        await pool.close();
        pool = null; 
        console.log('Conexión a SQL Server cerrada.');
    }
}

module.exports = {
    connectDb,
    closeDb,
    sql 
};