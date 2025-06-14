import mysql from 'mysql2/promise';

const connection = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
});

connection.getConnection()
    .then(() => {
        console.log('Conectado ao banco de dados MySQL com sucesso!');
    })
    .catch((error) => {
        console.error('Erro ao conectar ao banco de dados MySQL:', error);
    });

export default connection;