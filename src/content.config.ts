// Schéma des pages du cours : Starlight + quelques champs pédagogiques.
import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';
import { docsLoader } from '@astrojs/starlight/loaders';
import { docsSchema } from '@astrojs/starlight/schema';

export const collections = {
	docs: defineCollection({
		loader: docsLoader(),
		schema: docsSchema({
			extend: z.object({
				// Lettre du parcours (A à H, ou X pour la salle d'entraînement) : sert aux couleurs et au tableau de bord.
				parcours: z.enum(['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'X']).optional(),
				// Code du module, par exemple « B3 ».
				module: z.string().optional(),
				// Durée réaliste pour un débutant, par exemple « 2 h 30 ».
				duree: z.string().optional(),
				// Où faire la leçon : portable, PC fixe ou les deux.
				ou: z.enum(['portable', 'pc', 'les-deux']).optional(),
				prerequis: z.string().optional(),
				resultat: z.string().optional(),
				objectifs: z.array(z.string()).optional(),
			}),
		}),
	}),
};
