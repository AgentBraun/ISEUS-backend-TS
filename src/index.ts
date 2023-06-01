import 'dotenv/config';
import express from 'express';
import { PrismaClient } from '@prisma/client';

const app = express();
const prisma = new PrismaClient();

app.use(express.json);
app.use(express.urlencoded({ extended: true }));

app.listen(3000, () => {
  console.log('Data base online on port 3000');
});
