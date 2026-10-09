import dogImage from '../assets/Rectangle 45.png';
import avatarImage from '../assets/Ellipse 11.png';

export interface CategoryItem {
  id: number;
  name: string;
  description: string;
  imagepath: string;
  count: number;
  createAt: string;
  updatedAt: string;
  userId: number;
}

export interface AnimalItem {
  animalId: number;
  animalName: string;
  animalDescription: string;
  animalImage: string;
  animalPrice: number;
  categoryId: number;
  userId: number;
  authorName: string;
  isLiked?: boolean;
}

export const INITIAL_CATEGORIES: CategoryItem[] = [
  {
    id: 1,
    name: 'Dogs',
    description: 'Friendly domestic canines of all breeds and ages looking for loving families.',
    imagepath: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=300&q=80',
    count: 10,
    createAt: '2026-01-10',
    updatedAt: '2026-03-01',
    userId: 1,
  },
  {
    id: 2,
    name: 'Cats',
    description: 'Playful kittens and gentle cats ready for companionship and cuddle time.',
    imagepath: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=300&q=80',
    count: 8,
    createAt: '2026-01-12',
    updatedAt: '2026-02-28',
    userId: 1,
  },
  {
    id: 3,
    name: 'Birds',
    description: 'Canaries, parrots, cockatiels, and singing songbirds looking for good homes.',
    imagepath: 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?auto=format&fit=crop&w=300&q=80',
    count: 6,
    createAt: '2026-01-15',
    updatedAt: '2026-02-20',
    userId: 1,
  },
  {
    id: 4,
    name: 'Rabbits',
    description: 'Fluffy bunny rabbits, dwarfs and lops that love veggies and soft strokes.',
    imagepath: 'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?auto=format&fit=crop&w=300&q=80',
    count: 5,
    createAt: '2026-02-01',
    updatedAt: '2026-03-05',
    userId: 1,
  },
  {
    id: 5,
    name: 'Horses',
    description: 'Noble riding companions, mares and ponies needing ranch space.',
    imagepath: 'https://images.unsplash.com/photo-1553284965-83fd3e82fa5a?auto=format&fit=crop&w=300&q=80',
    count: 4,
    createAt: '2026-02-10',
    updatedAt: '2026-03-02',
    userId: 1,
  },
  {
    id: 6,
    name: 'Fish',
    description: 'Freshwater tropical fishes, aquascapes, and colorful betta breeds.',
    imagepath: 'https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?auto=format&fit=crop&w=300&q=80',
    count: 12,
    createAt: '2026-02-15',
    updatedAt: '2026-03-01',
    userId: 1,
  },
];

export const INITIAL_ANIMALS: AnimalItem[] = [
  {
    animalId: 1,
    animalName: 'Golden Retriever Pup',
    animalDescription:
      "I found this sweet dog and am looking for a loving home for them. If you're ready to welcome a new furry friend into your life, this adorable pup is waiting to bring joy and happiness to your family.",
    animalImage: dogImage,
    animalPrice: 1000,
    categoryId: 1,
    userId: 10,
    authorName: 'Ahmed El-said',
    isLiked: false,
  },
  {
    animalId: 2,
    animalName: 'Siberian Husky',
    animalDescription:
      'Energetic, loyal, and blue-eyed young Husky. Vaccinated, microchipped, and loves outdoor runs and games of fetch. Looking for an active owner.',
    animalImage:
      'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?auto=format&fit=crop&w=600&q=80',
    animalPrice: 1250,
    categoryId: 1,
    userId: 12,
    authorName: 'El-said Maher',
    isLiked: true,
  },
  {
    animalId: 3,
    animalName: 'British Shorthair Cat',
    animalDescription:
      'Calm and friendly silver tabby shorthair cat. Very quiet, clean, litter-trained, and great around kids and other pets.',
    animalImage:
      'https://images.unsplash.com/photo-1574158622682-e40e69881006?auto=format&fit=crop&w=600&q=80',
    animalPrice: 850,
    categoryId: 2,
    userId: 15,
    authorName: 'Sarah Jenkins',
    isLiked: false,
  },
  {
    animalId: 4,
    animalName: 'Holland Lop Bunny',
    animalDescription:
      'Miniature lop-eared rabbit, very gentle and affectionate. Comes with starter cage and organic hay. Perfect indoor apartment pet.',
    animalImage:
      'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?auto=format&fit=crop&w=600&q=80',
    animalPrice: 300,
    categoryId: 4,
    userId: 10,
    authorName: 'Ahmed El-said',
    isLiked: false,
  },
];

export const CURRENT_USER = {
  id: 1,
  name: 'El-said Maher',
  email: 'elsaid.maher@example.com',
  phone: '+20 102 345 6789',
  avatar: avatarImage,
  role: 'Animal Advocate & Admin',
};
