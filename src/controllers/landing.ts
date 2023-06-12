import { RequestHandler } from 'express';
//import createHttpError from 'http-errors';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const getNews: RequestHandler = async (req, res, next) => {
  const posts = await prisma.post.findMany({
    include: {
      admin: {
        select: {
          firstName: true,
          lastName: true,
        },
      },
      tags: {
        select: {
          tag: true,
        },
      },
    },
  });

  res.json(posts);
};
