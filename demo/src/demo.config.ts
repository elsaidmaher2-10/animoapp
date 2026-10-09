export interface DemoNotification {
  id: string;
  title: string;
  body: string;
  route: string;
  time?: string;
  category?: string;
}

export interface DemoFeatureChip {
  id: string;
  label: string;
  route?: string;
  action?: string;
  iconName?: string;
}

export interface DemoConfig {
  appName: string;
  version: string;
  description: string;
  accent: string;
  accent2: string;
  cardBg: string;
  lang: string;
  dir: 'ltr' | 'rtl';
  statusBarStyle: 'dark' | 'light';
  defaultFrameColor: 'midnight' | 'titanium' | 'starlight' | 'purple';
  notifications: DemoNotification[];
  features: DemoFeatureChip[];
}

export const DEMO_CONFIG: DemoConfig = {
  appName: 'ANIMOOO',
  version: '1.0.0+1',
  description: 'Animal discovery, adoption listings, and category management mobile app',
  accent: '#04332D',
  accent2: '#16A99F',
  cardBg: '#F6F6F6',
  lang: 'en',
  dir: 'ltr',
  statusBarStyle: 'dark',
  defaultFrameColor: 'midnight',
  notifications: [
    {
      id: 'notif-1',
      title: '🐾 New Animal Listed!',
      body: 'Ahmed El-said just listed a Golden Retriever dog for adoption ($1000).',
      route: '/',
      time: 'Just now',
      category: 'Animal',
    },
    {
      id: 'notif-2',
      title: '🔐 Security Verification Code',
      body: 'Your Animo security verification code is 8492. Valid for 60 seconds.',
      route: '/optverivication',
      time: '2m ago',
      category: 'Auth',
    },
    {
      id: 'notif-3',
      title: '📁 Category "Rare Breeds" Created',
      body: 'El-said Maher created a new public category. Explore 10 animals inside!',
      route: '/SeeAll',
      time: '15m ago',
      category: 'Categories',
    },
    {
      id: 'notif-4',
      title: '🎉 Password Reset Successful',
      body: 'Your account password has been updated securely. Log in with your new credentials.',
      route: '/Login',
      time: '1h ago',
      category: 'Security',
    },
  ],
  features: [
    { id: 'f-home', label: '🏠 Home Feed', route: '/' },
    { id: 'f-seeall', label: '🗂️ Categories (See All)', route: '/SeeAll' },
    { id: 'f-newcat', label: '➕ New Category', action: 'open_new_category' },
    { id: 'f-newanimal', label: '🐶 New Animal', action: 'open_new_animal' },
    { id: 'f-login', label: '🔑 Login Screen', route: '/Login' },
    { id: 'f-register', label: '📝 Sign Up Screen', route: '/register' },
    { id: 'f-forgot', label: '❓ Forgot Password', route: '/forgetpassword' },
    { id: 'f-otp', label: '🔢 OTP Screen', route: '/optverivication' },
    { id: 'f-reset', label: '🛡️ Create Password', route: '/ConfirmPassword' },
    { id: 'f-photo', label: '📷 Simulate Camera/Picker', action: 'trigger_picker' },
  ],
};
