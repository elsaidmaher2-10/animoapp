import React, { createContext, useContext, useState, useReducer, ReactNode } from 'react';
import { INITIAL_CATEGORIES, INITIAL_ANIMALS, CategoryItem, AnimalItem, CURRENT_USER } from '../app/data/initialData';
import { DEMO_CONFIG, DemoNotification } from '../demo.config';

export interface RouteStackItem {
  route: string;
  args?: Record<string, any>;
}

export interface InAppNotification {
  id: string;
  title: string;
  body: string;
  route: string;
  time: string;
  read: boolean;
}

export interface QuickAlertOptions {
  type: 'success' | 'error' | 'warning' | 'info';
  title?: string;
  text: string;
  confirmBtnText?: string;
  onConfirm?: () => void;
}

export interface ToastMessage {
  id: string;
  message: string;
  type?: 'success' | 'error' | 'info';
}

interface DemoContextType {
  // Navigation
  currentRoute: string;
  currentArgs: Record<string, any>;
  routeHistory: RouteStackItem[];
  navigate: (route: string, args?: Record<string, any>) => void;
  navigateNamedAndRemoveUntil: (route: string, args?: Record<string, any>) => void;
  back: () => boolean;
  activeMainTab: number;
  setActiveMainTab: (tab: number) => void;

  // Lock Screen & Notification Shell
  isLocked: boolean;
  lock: () => void;
  unlock: (targetRoute?: string) => void;
  activeBanner: DemoNotification | null;
  dismissBanner: () => void;
  pendingNotifications: DemoNotification[];
  notify: (notif: { title: string; body: string; route: string; category?: string }) => void;
  clearNotifications: () => void;

  // In-app Notifications
  inAppNotifications: InAppNotification[];
  markNotificationRead: (id: string) => void;
  unreadCount: number;

  // Simulated Special Features & Hardware
  isImagePickerOpen: boolean;
  openImagePicker: (onSelect: (url: string) => void) => void;
  closeImagePicker: () => void;
  imagePickerCallback: ((url: string) => void) | null;

  // Dialogs & SnackBar / Toast
  quickAlert: QuickAlertOptions | null;
  showQuickAlert: (opts: QuickAlertOptions) => void;
  closeQuickAlert: () => void;
  toasts: ToastMessage[];
  showToast: (message: string, type?: 'success' | 'error' | 'info') => void;
  removeToast: (id: string) => void;

  // App Data & CRUD State
  categories: CategoryItem[];
  animals: AnimalItem[];
  editingCategory: CategoryItem | null;
  setEditingCategory: (cat: CategoryItem | null) => void;
  editingAnimal: AnimalItem | null;
  setEditingAnimal: (animal: AnimalItem | null) => void;
  saveCategory: (category: Partial<CategoryItem>) => void;
  deleteCategory: (id: number) => void;
  saveAnimal: (animal: Partial<AnimalItem>) => void;
  deleteAnimal: (id: number) => void;
  toggleLikeAnimal: (id: number) => void;

  // Shell Controls
  frameColor: 'midnight' | 'titanium' | 'starlight' | 'purple';
  setFrameColor: (color: 'midnight' | 'titanium' | 'starlight' | 'purple') => void;
  zoom: number;
  setZoom: (zoom: number) => void;

  // Generic Action Dispatcher
  runAction: (actionName: string, data?: any) => void;

  // Authentication State
  isLoggedIn: boolean;
  setIsLoggedIn: (status: boolean) => void;
  user: typeof CURRENT_USER;
}

const DemoContext = createContext<DemoContextType | null>(null);

export const DemoProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  // Navigation stack
  const [routeStack, setRouteStack] = useState<RouteStackItem[]>([{ route: '/', args: {} }]);
  const [activeMainTab, setActiveMainTab] = useState<number>(0);
  const [isLocked, setIsLocked] = useState<boolean>(false);
  const [activeBanner, setActiveBanner] = useState<DemoNotification | null>(null);
  const [pendingNotifications, setPendingNotifications] = useState<DemoNotification[]>(
    DEMO_CONFIG.notifications
  );

  // Shell Presentation
  const [frameColor, setFrameColor] = useState<'midnight' | 'titanium' | 'starlight' | 'purple'>(
    DEMO_CONFIG.defaultFrameColor
  );
  const [zoom, setZoom] = useState<number>(1);

  // In-app Notifications
  const [inAppNotifications, setInAppNotifications] = useState<InAppNotification[]>([
    {
      id: 'init-1',
      title: 'Welcome to ANIMOOO',
      body: 'Explore cute pets and connect with adopters.',
      route: '/',
      time: '1h ago',
      read: false,
    },
    {
      id: 'init-2',
      title: 'Profile Verified',
      body: 'Your shelter identity has been approved.',
      route: '/SeeAll',
      time: '3h ago',
      read: true,
    },
  ]);

  // Dialogs & Toasts
  const [quickAlert, setQuickAlert] = useState<QuickAlertOptions | null>(null);
  const [toasts, setToasts] = useState<ToastMessage[]>([]);

  // Simulated Hardware Sheet
  const [isImagePickerOpen, setIsImagePickerOpen] = useState(false);
  const [imagePickerCallback, setImagePickerCallback] = useState<((url: string) => void) | null>(null);

  // CRUD Data Stores
  const [categories, setCategories] = useState<CategoryItem[]>(INITIAL_CATEGORIES);
  const [animals, setAnimals] = useState<AnimalItem[]>(INITIAL_ANIMALS);
  const [editingCategory, setEditingCategory] = useState<CategoryItem | null>(null);
  const [editingAnimal, setEditingAnimal] = useState<AnimalItem | null>(null);

  // Auth State
  const [isLoggedIn, setIsLoggedIn] = useState(true);

  const currentRouteItem = routeStack[routeStack.length - 1] || { route: '/', args: {} };
  const currentRoute = currentRouteItem.route;
  const currentArgs = currentRouteItem.args || {};

  const showToast = (message: string, type: 'success' | 'error' | 'info' = 'info') => {
    const id = Date.now().toString() + Math.random().toString().slice(2, 6);
    setToasts((prev) => [...prev, { id, message, type }]);
    setTimeout(() => {
      setToasts((prev) => prev.filter((t) => t.id !== id));
    }, 3500);
  };

  const removeToast = (id: string) => {
    setToasts((prev) => prev.filter((t) => t.id !== id));
  };

  const navigate = (route: string, args: Record<string, any> = {}) => {
    // If navigating to main tabs
    if (route === '/') {
      setActiveMainTab(0);
    }
    setRouteStack((prev) => [...prev, { route, args }]);
  };

  const navigateNamedAndRemoveUntil = (route: string, args: Record<string, any> = {}) => {
    setRouteStack([{ route, args }]);
    if (route === '/') {
      setActiveMainTab(0);
    }
  };

  const back = (): boolean => {
    if (routeStack.length > 1) {
      setRouteStack((prev) => prev.slice(0, prev.length - 1));
      return true;
    }
    return false;
  };

  const notify = ({
    title,
    body,
    route,
    category,
  }: {
    title: string;
    body: string;
    route: string;
    category?: string;
  }) => {
    const newNotif: DemoNotification = {
      id: `notif-${Date.now()}`,
      title,
      body,
      route,
      time: 'Just now',
      category: category || 'Alert',
    };

    // Show popup banner
    setActiveBanner(newNotif);

    // Add to lock screen queue
    setPendingNotifications((prev) => [newNotif, ...prev]);

    // Also sync with in-app notifications
    setInAppNotifications((prev) => [
      {
        id: newNotif.id,
        title: newNotif.title,
        body: newNotif.body,
        route: newNotif.route,
        time: 'Just now',
        read: false,
      },
      ...prev,
    ]);

    // Automatically hide banner after 4.5s
    setTimeout(() => {
      setActiveBanner((current) => (current?.id === newNotif.id ? null : current));
    }, 4500);
  };

  const dismissBanner = () => {
    setActiveBanner(null);
  };

  const clearNotifications = () => {
    setPendingNotifications([]);
  };

  const lock = () => {
    setIsLocked(true);
  };

  const unlock = (targetRoute?: string) => {
    setIsLocked(false);
    if (targetRoute) {
      navigate(targetRoute);
    }
  };

  const markNotificationRead = (id: string) => {
    setInAppNotifications((prev) =>
      prev.map((n) => (n.id === id ? { ...n, read: true } : n))
    );
  };

  const unreadCount = inAppNotifications.filter((n) => !n.read).length;

  const openImagePicker = (onSelect: (url: string) => void) => {
    setImagePickerCallback(() => onSelect);
    setIsImagePickerOpen(true);
  };

  const closeImagePicker = () => {
    setIsImagePickerOpen(false);
    setImagePickerCallback(null);
  };

  const showQuickAlert = (opts: QuickAlertOptions) => {
    setQuickAlert(opts);
  };

  const closeQuickAlert = () => {
    setQuickAlert(null);
  };

  // Data operations
  const saveCategory = (catData: Partial<CategoryItem>) => {
    if (editingCategory && editingCategory.id) {
      // Update
      setCategories((prev) =>
        prev.map((c) =>
          c.id === editingCategory.id
            ? { ...c, ...catData, updatedAt: new Date().toISOString().split('T')[0] }
            : c
        )
      );
      showToast('Category updated successfully!', 'success');
      setEditingCategory(null);
    } else {
      // Create new
      const newCat: CategoryItem = {
        id: Date.now(),
        name: catData.name || 'New Category',
        description: catData.description || '',
        imagepath:
          catData.imagepath ||
          'https://images.unsplash.com/photo-1548767797-d8c844163c4c?auto=format&fit=crop&w=300&q=80',
        count: 0,
        createAt: new Date().toISOString().split('T')[0],
        updatedAt: new Date().toISOString().split('T')[0],
        userId: 1,
      };
      setCategories((prev) => [newCat, ...prev]);
      showToast('New category created!', 'success');
    }
  };

  const deleteCategory = (id: number) => {
    setCategories((prev) => prev.filter((c) => c.id !== id));
    showToast('Category deleted', 'info');
    setEditingCategory(null);
  };

  const saveAnimal = (animalData: Partial<AnimalItem>) => {
    if (editingAnimal && editingAnimal.animalId) {
      setAnimals((prev) =>
        prev.map((a) =>
          a.animalId === editingAnimal.animalId ? { ...a, ...animalData } : a
        )
      );
      showToast('Animal details updated!', 'success');
      setEditingAnimal(null);
    } else {
      const newAnimal: AnimalItem = {
        animalId: Date.now(),
        animalName: animalData.animalName || 'Sweet Animal',
        animalDescription: animalData.animalDescription || '',
        animalImage:
          animalData.animalImage ||
          'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=600&q=80',
        animalPrice: animalData.animalPrice || 500,
        categoryId: animalData.categoryId || 1,
        userId: 1,
        authorName: CURRENT_USER.name,
        isLiked: false,
      };
      setAnimals((prev) => [newAnimal, ...prev]);
      showToast('New animal listed successfully!', 'success');
    }
  };

  const deleteAnimal = (id: number) => {
    setAnimals((prev) => prev.filter((a) => a.animalId !== id));
    showToast('Animal listing removed', 'info');
    setEditingAnimal(null);
  };

  const toggleLikeAnimal = (id: number) => {
    setAnimals((prev) =>
      prev.map((a) =>
        a.animalId === id ? { ...a, isLiked: !a.isLiked } : a
      )
    );
  };

  const runAction = (actionName: string, data?: any) => {
    switch (actionName) {
      case 'open_new_category':
        setEditingCategory(null);
        navigate('/');
        setActiveMainTab(2);
        break;
      case 'open_new_animal':
        setEditingAnimal(null);
        navigate('/');
        setActiveMainTab(3);
        break;
      case 'trigger_picker':
        openImagePicker((url) => {
          showToast('Image selected: ' + url.slice(0, 30) + '...', 'success');
        });
        break;
      default:
        showToast(`Action "${actionName}" executed`, 'info');
    }
  };

  return (
    <DemoContext.Provider
      value={{
        currentRoute,
        currentArgs,
        routeHistory: routeStack,
        navigate,
        navigateNamedAndRemoveUntil,
        back,
        activeMainTab,
        setActiveMainTab,
        isLocked,
        lock,
        unlock,
        activeBanner,
        dismissBanner,
        pendingNotifications,
        notify,
        clearNotifications,
        inAppNotifications,
        markNotificationRead,
        unreadCount,
        isImagePickerOpen,
        openImagePicker,
        closeImagePicker,
        imagePickerCallback,
        quickAlert,
        showQuickAlert,
        closeQuickAlert,
        toasts,
        showToast,
        removeToast,
        categories,
        animals,
        editingCategory,
        setEditingCategory,
        editingAnimal,
        setEditingAnimal,
        saveCategory,
        deleteCategory,
        saveAnimal,
        deleteAnimal,
        toggleLikeAnimal,
        frameColor,
        setFrameColor,
        zoom,
        setZoom,
        runAction,
        isLoggedIn,
        setIsLoggedIn,
        user: CURRENT_USER,
      }}
    >
      {children}
    </DemoContext.Provider>
  );
};

export const useDemo = () => {
  const ctx = useContext(DemoContext);
  if (!ctx) throw new Error('useDemo must be used within DemoProvider');
  return ctx;
};
