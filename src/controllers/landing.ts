import { RequestHandler } from 'express';
//import createHttpError from 'http-errors';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const getNews: RequestHandler = async (req, res, next) => {
  try {
    const posts = await prisma.post.findMany();
    res.json(posts);
  } catch (error) {
    next(error);
  }
};
