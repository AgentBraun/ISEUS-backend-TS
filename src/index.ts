import env from './utils/validateEnv';
import express from 'express';
import createHttpError from 'http-errors';

//routes import
import adminRoutes from './routes/admin';
import professorsRoutes from './routes/professor';
import studentsRoutes from './routes/students';
import landingRoutes from './routes/landing';

//const port = env.PORT;

const app = express();

app.use(express.json);
app.use(express.urlencoded({ extended: true }));

app.use('/api/landing', landingRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/professors', professorsRoutes);
app.use('/api/students', studentsRoutes);

app.use((req, res, next) => {
  next(createHttpError(404, 'endpoint not found!'));
});

app.listen(5000, () => {
  console.log('Data base online on port 5000');
});
