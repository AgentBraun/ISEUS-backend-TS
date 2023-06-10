import express from 'express';
import * as landingController from '../controllers/landing';

const router = express.Router();

//parent route ->  /api/admin

router.get('/news', landingController.getNews);

export default router;
