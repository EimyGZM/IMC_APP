const sql = require('mssql');

// Configuración de la conexión a SQL Server
const config = {
    user: 'sa',        
    password: 'EimyGuzman13', 
    server: 'EIMYG\MSSQLSERVER2',         
    database: 'IMC_APP_db',   
    options: {
        encrypt: false,            
        trustServerCertificate: true 
    }
};

async function connectToSqlServer() {
    try {

        await sql.connect(config);
        console.log('Conexión exitosa a SQL Server');


        const result = await sql.query`SELECT TOP 5 * FROM TuTabla`;
        console.log('Resultados de la consulta:');
        console.dir(result.recordset);

    } catch (err) {
        console.error('Error al conectar o consultar SQL Server:', err);
    } finally {
        sql.close();
        console.log('Conexión a SQL Server cerrada');
    }
}

connectToSqlServer();