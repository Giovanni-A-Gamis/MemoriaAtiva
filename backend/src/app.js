import express from 'express';
const app = express();

app.use(express.json());

import routes from './routes/router.js';
app.use('/api', routes);

app.get('/', (req, res) => {
    res.send('API MemóriaAtiva está funcionando!');
});

export default app;