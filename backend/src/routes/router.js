import { Router } from 'express';
const router = Router();

router.get('teste', (req, res) => {
    res.json({ message: 'Rota de teste funcionando!' });
});

//ROTAS

export default router;