import 'dotenv/config';

import app from './app.js';
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Servidor está rodando na porta ${PORT}`);
    console.log(`Acesse a aplicação em http://localhost:${PORT}`);
});