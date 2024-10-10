import { z } from 'zod';

export const userSchema = z.object({
  id: z.number(),
  username: z.string().min(3),
  email: z.string().email(),
});

export type User = z.infer<typeof userSchema>;