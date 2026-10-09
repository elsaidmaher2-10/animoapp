import React, { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import logoSvg from '../assets/logo.svg';
import profileAvatar from '../assets/Ellipse 11.png';
import subtractIcon from '../assets/Subtract.png';
import {
  Home,
  Search,
  Grid,
  Heart,
  User,
  MoreVertical,
  Globe,
  Bell,
  Trash2,
  Check,
  Plus,
  Share2,
} from 'lucide-react';

export const MainScreen: React.FC = () => {
  const {
    activeMainTab,
    setActiveMainTab,
    categories,
    animals,
    user,
    navigate,
    unreadCount,
    setEditingCategory,
    editingCategory,
    saveCategory,
    deleteCategory,
    setEditingAnimal,
    editingAnimal,
    saveAnimal,
    deleteAnimal,
    toggleLikeAnimal,
    openImagePicker,
    showToast,
    setIsLoggedIn,
  } = useDemo();

  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        height: '100%',
        backgroundColor: '#ffffff',
        position: 'relative',
        overflow: 'hidden',
      }}
    >
      {/* Body Area */}
      <div
        style={{
          flex: 1,
          overflowY: 'auto',
          paddingTop: 'calc(var(--safe-top, 54px) + 6px)',
          paddingBottom: 'calc(var(--safe-bottom, 34px) + 64px)',
        }}
      >
        {activeMainTab === 0 && <HomeTab />}
        {activeMainTab === 1 && <SearchTab />}
        {activeMainTab === 2 && <CategoryTab />}
        {activeMainTab === 3 && <AnimalTab />}
        {activeMainTab === 4 && <MeTab />}
      </div>

      {/* Flutter-style BottomNavigationBar */}
      <div
        style={{
          position: 'absolute',
          bottom: 0,
          left: 0,
          right: 0,
          backgroundColor: 'rgba(255, 255, 255, 0.95)',
          backdropFilter: 'blur(20px)',
          borderTop: '1px solid #EEEEEE',
          display: 'flex',
          justifyContent: 'space-around',
          alignItems: 'center',
          height: 'calc(var(--safe-bottom, 34px) + 54px)',
          paddingBottom: 'var(--safe-bottom, 34px)',
          zIndex: 800,
        }}
      >
        <NavButton
          active={activeMainTab === 0}
          icon={<Home size={22} />}
          label="Home"
          onClick={() => setActiveMainTab(0)}
        />
        <NavButton
          active={activeMainTab === 1}
          icon={<Search size={22} />}
          label="Search"
          onClick={() => setActiveMainTab(1)}
        />
        <NavButton
          active={activeMainTab === 2}
          icon={<Grid size={22} />}
          label="Category"
          onClick={() => {
            setEditingCategory(null);
            setActiveMainTab(2);
          }}
        />
        <NavButton
          active={activeMainTab === 3}
          icon={<Heart size={22} />}
          label="Animal"
          onClick={() => {
            setEditingAnimal(null);
            setActiveMainTab(3);
          }}
        />
        <NavButton
          active={activeMainTab === 4}
          icon={<User size={22} />}
          label="Me"
          onClick={() => setActiveMainTab(4)}
        />
      </div>
    </div>
  );
};

// ==================== 1. HOME TAB ====================
const HomeTab: React.FC = () => {
  const { categories, animals, navigate, setActiveMainTab, setEditingCategory, toggleLikeAnimal, showToast, unreadCount } =
    useDemo();

  return (
    <div style={{ display: 'flex', flexDirection: 'column' }}>
      {/* Homepage App Bar */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          padding: '0 17px',
          marginBottom: '14px',
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center', gap: '14px' }}>
          <img
            src={logoSvg}
            alt="Logo"
            style={{ width: '48px', height: '48px', objectFit: 'contain' }}
          />
          <h1
            style={{
              fontFamily: 'var(--font-original-surfer)',
              fontSize: '22px',
              color: 'var(--kprimary)',
              fontWeight: 500,
              margin: 0,
            }}
          >
            Hello in ANIMOOO
          </h1>
        </div>

        {/* Bell with Badge */}
        <div
          onClick={() => showToast(`You have ${unreadCount} unread notification(s)`)}
          style={{ position: 'relative', cursor: 'pointer', padding: '6px' }}
        >
          <Bell size={22} color="var(--kprimary)" />
          {unreadCount > 0 && (
            <span
              style={{
                position: 'absolute',
                top: '2px',
                right: '2px',
                width: '18px',
                height: '18px',
                backgroundColor: 'var(--kprimary)',
                color: '#fff',
                fontSize: '10px',
                fontWeight: 700,
                borderRadius: '50%',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                border: '2px solid #fff',
              }}
            >
              {unreadCount}
            </span>
          )}
        </div>
      </div>

      {/* Homepagecategory Header */}
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          padding: '12px 17px',
        }}
      >
        <span
          style={{
            fontFamily: 'var(--font-poppins)',
            fontWeight: 800,
            fontSize: '16px',
            color: 'var(--black)',
          }}
        >
          Categories ( {categories.length} )
        </span>
        <button
          onClick={() => {
            setEditingCategory(null);
            setActiveMainTab(2);
          }}
          style={{
            fontFamily: 'var(--font-poppins)',
            fontWeight: 800,
            fontSize: '12px',
            color: 'var(--black)',
            background: 'none',
            border: 'none',
            cursor: 'pointer',
          }}
        >
          Add New Category
        </button>
      </div>

      {/* Horizontal Category Carousel */}
      <div
        style={{
          display: 'flex',
          overflowX: 'auto',
          gap: '12px',
          padding: '4px 17px 16px',
          alignItems: 'center',
        }}
      >
        {categories.map((cat) => (
          <div
            key={cat.id}
            onClick={() => {
              setEditingCategory(cat);
              setActiveMainTab(2);
            }}
            style={{
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              cursor: 'pointer',
              flexShrink: 0,
            }}
          >
            <div style={{ position: 'relative' }}>
              <div
                style={{
                  width: '74px',
                  height: '74px',
                  borderRadius: '50%',
                  overflow: 'hidden',
                  border: '2px solid #E5E7EB',
                }}
              >
                <img
                  src={cat.imagepath}
                  alt={cat.name}
                  style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                />
              </div>
              <span
                style={{
                  position: 'absolute',
                  top: '-4px',
                  right: '-6px',
                  backgroundColor: 'var(--kprimary)',
                  color: '#ffffff',
                  fontSize: '10px',
                  fontWeight: 700,
                  padding: '3px 6px',
                  borderRadius: '10px',
                  border: '2px solid #ffffff',
                }}
              >
                {cat.count}
              </span>
            </div>
            <span
              style={{
                fontSize: '13px',
                fontWeight: 600,
                color: 'var(--black)',
                marginTop: '6px',
                maxWidth: '74px',
                textAlign: 'center',
                overflow: 'hidden',
                textOverflow: 'ellipsis',
                whiteSpace: 'nowrap',
              }}
            >
              {cat.name}
            </span>
          </div>
        ))}

        {/* See All Button */}
        <div style={{ flexShrink: 0, padding: '0 8px' }}>
          <button
            onClick={() => navigate('/SeeAll')}
            style={{
              backgroundColor: '#155F45',
              color: '#ffffff',
              padding: '10px 16px',
              borderRadius: '20px',
              border: 'none',
              fontWeight: 700,
              fontSize: '13px',
              cursor: 'pointer',
              whiteSpace: 'nowrap',
            }}
          >
            See All
          </button>
        </div>
      </div>

      {/* Animalcategory Header */}
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          padding: '12px 17px',
        }}
      >
        <span
          style={{
            fontFamily: 'var(--font-poppins)',
            fontWeight: 800,
            fontSize: '16px',
            color: 'var(--black)',
          }}
        >
          All Animal ( {animals.length} )
        </span>
        <button
          onClick={() => setActiveMainTab(3)}
          style={{
            fontFamily: 'var(--font-poppins)',
            fontWeight: 800,
            fontSize: '12px',
            color: 'var(--black)',
            background: 'none',
            border: 'none',
            cursor: 'pointer',
          }}
        >
          Add New Animal
        </button>
      </div>

      {/* Animals Feed Cards (AnimalWidget) */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '16px', padding: '0 17px' }}>
        {animals.map((animal) => (
          <div
            key={animal.animalId}
            style={{
              backgroundColor: 'var(--lightgrey4)',
              borderRadius: '12px',
              overflow: 'hidden',
              boxShadow: '0 2px 8px rgba(0,0,0,0.04)',
            }}
          >
            {/* Card Header */}
            <div
              style={{
                padding: '10px 14px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
              }}
            >
              <div>
                <div
                  style={{
                    fontFamily: 'var(--font-poppins)',
                    fontWeight: 800,
                    fontSize: '14px',
                    color: 'var(--black)',
                  }}
                >
                  {animal.animalName}
                </div>
                <div style={{ fontSize: '11px', color: '#999999' }}>
                  create by {animal.authorName}
                </div>
              </div>

              <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                <span
                  style={{
                    fontFamily: 'var(--font-poppins)',
                    fontWeight: 800,
                    fontSize: '14px',
                    color: 'var(--kprimary)',
                  }}
                >
                  {animal.animalPrice}$
                </span>
                <button
                  onClick={() => showToast(`Options for ${animal.animalName}`)}
                  style={{
                    background: 'none',
                    border: 'none',
                    cursor: 'pointer',
                    color: '#666666',
                    padding: '2px',
                  }}
                >
                  <MoreVertical size={18} />
                </button>
              </div>
            </div>

            {/* Photo */}
            <div style={{ width: '100%', height: '200px', overflow: 'hidden' }}>
              <img
                src={animal.animalImage}
                alt={animal.animalName}
                style={{ width: '100%', height: '100%', objectFit: 'cover' }}
              />
            </div>

            {/* Description */}
            <div style={{ padding: '12px 14px 10px' }}>
              <p
                style={{
                  fontFamily: 'var(--font-original-surfer)',
                  fontSize: '13px',
                  color: 'var(--black)',
                  lineHeight: '1.45',
                  margin: 0,
                }}
              >
                {animal.animalDescription}
              </p>
            </div>

            {/* Interactive Footer */}
            <div
              style={{
                padding: '8px 14px 12px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                borderTop: '1px solid rgba(0,0,0,0.05)',
              }}
            >
              <button
                onClick={() => toggleLikeAnimal(animal.animalId)}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '6px',
                  background: 'none',
                  border: 'none',
                  cursor: 'pointer',
                  color: animal.isLiked ? 'var(--red)' : '#666666',
                  fontSize: '13px',
                  fontWeight: 600,
                }}
              >
                <Heart size={18} fill={animal.isLiked ? 'var(--red)' : 'none'} />
                {animal.isLiked ? 'Loved' : 'Like'}
              </button>

              <button
                onClick={() => showToast('Listing link copied to clipboard!', 'success')}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '6px',
                  background: 'none',
                  border: 'none',
                  cursor: 'pointer',
                  color: 'var(--kprimary)',
                  fontSize: '13px',
                  fontWeight: 600,
                }}
              >
                <Share2 size={16} />
                Share
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

// ==================== 2. SEARCH TAB ====================
const SearchTab: React.FC = () => {
  const { categories, animals, toggleLikeAnimal } = useDemo();
  const [selectedCatId, setSelectedCatId] = useState<number | null>(null);
  const [query, setQuery] = useState('');

  const filteredAnimals = animals.filter((a) => {
    const matchesCat = selectedCatId === null || a.categoryId === selectedCatId;
    const matchesQuery =
      a.animalName.toLowerCase().includes(query.toLowerCase()) ||
      a.animalDescription.toLowerCase().includes(query.toLowerCase());
    return matchesCat && matchesQuery;
  });

  return (
    <div style={{ padding: '0 17px' }}>
      <h2
        style={{
          fontFamily: 'var(--font-poppins)',
          fontSize: '20px',
          fontWeight: 700,
          color: 'var(--kprimary)',
          marginBottom: '14px',
        }}
      >
        Discover Animals
      </h2>

      {/* Search Input */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '10px',
          padding: '10px 14px',
          backgroundColor: '#F3F4F6',
          borderRadius: '12px',
          marginBottom: '14px',
        }}
      >
        <Search size={18} color="#9CA3AF" />
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search by breed, name or description..."
          style={{ background: 'none', border: 'none', outline: 'none', width: '100%', fontSize: '14px' }}
        />
      </div>

      {/* Category Filter Chips */}
      <div
        style={{
          display: 'flex',
          gap: '8px',
          overflowX: 'auto',
          paddingBottom: '12px',
          marginBottom: '12px',
        }}
      >
        <button
          onClick={() => setSelectedCatId(null)}
          style={{
            padding: '6px 14px',
            borderRadius: '20px',
            fontSize: '12px',
            fontWeight: 600,
            border: 'none',
            backgroundColor: selectedCatId === null ? 'var(--kprimary)' : '#F3F4F6',
            color: selectedCatId === null ? '#ffffff' : '#333333',
            cursor: 'pointer',
            whiteSpace: 'nowrap',
          }}
        >
          All
        </button>
        {categories.map((c) => (
          <button
            key={c.id}
            onClick={() => setSelectedCatId(c.id)}
            style={{
              padding: '6px 14px',
              borderRadius: '20px',
              fontSize: '12px',
              fontWeight: 600,
              border: 'none',
              backgroundColor: selectedCatId === c.id ? 'var(--kprimary)' : '#F3F4F6',
              color: selectedCatId === c.id ? '#ffffff' : '#333333',
              cursor: 'pointer',
              whiteSpace: 'nowrap',
            }}
          >
            {c.name}
          </button>
        ))}
      </div>

      {/* Results */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
        {filteredAnimals.map((a) => (
          <div
            key={a.animalId}
            style={{
              display: 'flex',
              gap: '12px',
              backgroundColor: '#FAFAFA',
              borderRadius: '12px',
              padding: '10px',
              border: '1px solid #ECECEC',
            }}
          >
            <img
              src={a.animalImage}
              alt={a.animalName}
              style={{ width: '84px', height: '84px', borderRadius: '10px', objectFit: 'cover' }}
            />
            <div style={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <h4 style={{ fontSize: '14px', fontWeight: 700, margin: 0 }}>{a.animalName}</h4>
                <span style={{ fontSize: '13px', fontWeight: 700, color: 'var(--kprimary)' }}>
                  {a.animalPrice}$
                </span>
              </div>
              <p
                style={{
                  fontSize: '11.5px',
                  color: '#666666',
                  marginTop: '4px',
                  display: '-webkit-box',
                  WebkitLineClamp: 2,
                  WebkitBoxOrient: 'vertical',
                  overflow: 'hidden',
                }}
              >
                {a.animalDescription}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

// ==================== 3. CATEGORY TAB (Create / Edit Category) ====================
const CategoryTab: React.FC = () => {
  const {
    editingCategory,
    setEditingCategory,
    saveCategory,
    deleteCategory,
    openImagePicker,
    showToast,
    setActiveMainTab,
  } = useDemo();

  const [name, setName] = useState(editingCategory ? editingCategory.name : 'Exotic Felines');
  const [desc, setDesc] = useState(
    editingCategory
      ? editingCategory.description
      : 'Rare, majestic exotic cat breeds that require specialized care, affectionate companionship, and spacious indoor living spaces.'
  );
  const [image, setImage] = useState<string | null>(
    editingCategory
      ? editingCategory.imagepath
      : 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?auto=format&fit=crop&w=300&q=80'
  );

  // Flutter validations from category.dart:
  // name.length > 12 && desc.length > 100
  const isNameValid = name.trim().length > 12;
  const isDescValid = desc.trim().length > 100;
  const isFormValid = isNameValid && isDescValid && image !== null;

  const handleSave = () => {
    if (!isFormValid) {
      showToast('Name must be > 12 chars and Description > 100 chars', 'error');
      return;
    }
    saveCategory({
      name,
      description: desc,
      imagepath: image!,
    });
    setActiveMainTab(0);
  };

  const handleDelete = () => {
    if (editingCategory) {
      deleteCategory(editingCategory.id);
      setActiveMainTab(0);
    }
  };

  return (
    <div style={{ padding: '0 18px' }}>
      <h2
        style={{
          fontFamily: 'var(--font-otama)',
          fontSize: '22px',
          color: 'var(--kprimary)',
          marginBottom: '12px',
        }}
      >
        {editingCategory ? 'Edit Category' : 'Create New Category'}
      </h2>

      {/* Author Row */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px' }}>
        <img
          src={profileAvatar}
          alt="Author"
          style={{ width: '48px', height: '48px', borderRadius: '50%', objectFit: 'cover' }}
        />
        <div>
          <div style={{ fontSize: '13px', fontWeight: 600, color: 'var(--black)' }}>
            El-said Maher
          </div>
          <div
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: '4px',
              backgroundColor: 'rgba(22, 169, 159, 0.08)',
              padding: '3px 8px',
              borderRadius: '8px',
              marginTop: '4px',
            }}
          >
            <Globe size={13} color="var(--klightgreen)" />
            <span style={{ fontSize: '11px', fontWeight: 600, color: 'var(--klightgreen)' }}>
              Public
            </span>
          </div>
        </div>
      </div>

      {/* Category Name */}
      <div style={{ marginBottom: '18px' }}>
        <label style={{ fontSize: '15px', color: '#3C3C3C', fontWeight: 500 }}>Category Name</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Enter your Category Name"
          style={{
            width: '100%',
            padding: '12px 14px',
            fontSize: '14px',
            border: `1.5px solid ${name && !isNameValid ? 'var(--red)' : '#E5E7EB'}`,
            borderRadius: '10px',
            backgroundColor: '#FAFAFA',
            marginTop: '6px',
          }}
        />
        {!isNameValid && (
          <span style={{ fontSize: '11px', color: 'var(--red)', marginTop: '4px', display: 'block' }}>
            Value must be more than 12 characters ({name.length}/13)
          </span>
        )}
      </div>

      {/* Category Description */}
      <div style={{ marginBottom: '18px' }}>
        <label style={{ fontSize: '15px', color: '#3C3C3C', fontWeight: 500 }}>
          Category Description
        </label>
        <textarea
          rows={3}
          value={desc}
          onChange={(e) => setDesc(e.target.value)}
          placeholder="Enter your Description"
          style={{
            width: '100%',
            padding: '12px 14px',
            fontSize: '14px',
            border: `1.5px solid ${desc && !isDescValid ? 'var(--red)' : '#E5E7EB'}`,
            borderRadius: '10px',
            backgroundColor: '#FAFAFA',
            marginTop: '6px',
            resize: 'none',
          }}
        />
        {!isDescValid && (
          <span style={{ fontSize: '11px', color: 'var(--red)', marginTop: '4px', display: 'block' }}>
            Value must be more than 100 characters ({desc.length}/101)
          </span>
        )}
      </div>

      {/* Upload Image */}
      <div style={{ marginBottom: '22px' }}>
        <div
          onClick={() => openImagePicker((url) => setImage(url))}
          style={{
            border: '2px dashed #CBD5E1',
            borderRadius: '12px',
            padding: '14px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '12px',
            cursor: 'pointer',
            backgroundColor: '#F8FAFC',
          }}
        >
          {image ? (
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
              <img
                src={image}
                alt="Selected"
                style={{ width: '48px', height: '48px', borderRadius: '10px', objectFit: 'cover' }}
              />
              <span style={{ fontSize: '13px', fontWeight: 600, color: 'var(--kprimary)' }}>
                {editingCategory ? 'Change Category Image' : 'Image Loaded'}
              </span>
            </div>
          ) : (
            <>
              <img src={subtractIcon} alt="Upload" style={{ width: '24px', height: '24px' }} />
              <span style={{ fontSize: '13px', color: 'var(--lightgrey2)' }}>
                Tap to select category photo
              </span>
            </>
          )}
        </div>
      </div>

      {/* Action Buttons */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
        <button
          onClick={handleSave}
          disabled={!isFormValid}
          style={{
            width: '100%',
            padding: '14px',
            backgroundColor: isFormValid ? 'var(--kprimary)' : '#A3B8B5',
            color: '#ffffff',
            fontSize: '16px',
            fontWeight: 600,
            borderRadius: '10px',
            border: 'none',
            cursor: isFormValid ? 'pointer' : 'not-allowed',
          }}
        >
          {editingCategory ? 'Edit' : 'Save'}
        </button>

        {editingCategory && (
          <button
            onClick={handleDelete}
            style={{
              width: '100%',
              padding: '14px',
              backgroundColor: 'var(--red)',
              color: '#ffffff',
              fontSize: '16px',
              fontWeight: 600,
              borderRadius: '10px',
              border: 'none',
              cursor: 'pointer',
            }}
          >
            Delete
          </button>
        )}
      </div>
    </div>
  );
};

// ==================== 4. ANIMAL TAB (Create / Edit Animal) ====================
const AnimalTab: React.FC = () => {
  const {
    categories,
    editingAnimal,
    setEditingAnimal,
    saveAnimal,
    deleteAnimal,
    openImagePicker,
    showToast,
    setActiveMainTab,
  } = useDemo();

  const [name, setName] = useState(editingAnimal ? editingAnimal.animalName : 'Siberian Husky Puppy');
  const [desc, setDesc] = useState(
    editingAnimal
      ? editingAnimal.animalDescription
      : 'Playful, healthy, and affectionate husky puppy looking for a warm and caring home. Very social with kids and other animals.'
  );
  const [price, setPrice] = useState(editingAnimal ? editingAnimal.animalPrice.toString() : '950');
  const [catId, setCatId] = useState(editingAnimal ? editingAnimal.categoryId : 1);
  const [image, setImage] = useState<string | null>(
    editingAnimal
      ? editingAnimal.animalImage
      : 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=600&q=80'
  );

  const isNameValid = name.trim().length > 12;
  const isDescValid = desc.trim().length > 100;
  const isPriceValid = Number(price) > 0;
  const isFormValid = isNameValid && isDescValid && isPriceValid && image !== null;

  const handleSave = () => {
    if (!isFormValid) {
      showToast('Name must be > 12 chars, Desc > 100 chars, and valid price', 'error');
      return;
    }
    saveAnimal({
      animalName: name,
      animalDescription: desc,
      animalPrice: Number(price),
      categoryId: catId,
      animalImage: image!,
    });
    setActiveMainTab(0);
  };

  const handleDelete = () => {
    if (editingAnimal) {
      deleteAnimal(editingAnimal.animalId);
      setActiveMainTab(0);
    }
  };

  return (
    <div style={{ padding: '0 18px' }}>
      <h2
        style={{
          fontFamily: 'var(--font-otama)',
          fontSize: '22px',
          color: 'var(--kprimary)',
          marginBottom: '12px',
        }}
      >
        {editingAnimal ? 'Edit Animal' : 'Create New Animal'}
      </h2>

      {/* Author Row */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '10px', marginBottom: '20px' }}>
        <img
          src={profileAvatar}
          alt="Author"
          style={{ width: '48px', height: '48px', borderRadius: '50%', objectFit: 'cover' }}
        />
        <div>
          <div style={{ fontSize: '13px', fontWeight: 600, color: 'var(--black)' }}>
            El-said Maher
          </div>
          <div
            style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: '4px',
              backgroundColor: 'rgba(22, 169, 159, 0.08)',
              padding: '3px 8px',
              borderRadius: '8px',
              marginTop: '4px',
            }}
          >
            <Globe size={13} color="var(--klightgreen)" />
            <span style={{ fontSize: '11px', fontWeight: 600, color: 'var(--klightgreen)' }}>
              Public
            </span>
          </div>
        </div>
      </div>

      {/* Animal Name */}
      <div style={{ marginBottom: '16px' }}>
        <label style={{ fontSize: '15px', color: '#3C3C3C', fontWeight: 500 }}>Animal Name</label>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Enter your Animal Name"
          style={{
            width: '100%',
            padding: '12px 14px',
            fontSize: '14px',
            border: `1.5px solid ${name && !isNameValid ? 'var(--red)' : '#E5E7EB'}`,
            borderRadius: '10px',
            backgroundColor: '#FAFAFA',
            marginTop: '6px',
          }}
        />
        {!isNameValid && (
          <span style={{ fontSize: '11px', color: 'var(--red)', marginTop: '4px', display: 'block' }}>
            Value must be more than 12 characters ({name.length}/13)
          </span>
        )}
      </div>

      {/* Animal Description */}
      <div style={{ marginBottom: '16px' }}>
        <label style={{ fontSize: '15px', color: '#3C3C3C', fontWeight: 500 }}>
          Animal Description
        </label>
        <textarea
          rows={3}
          value={desc}
          onChange={(e) => setDesc(e.target.value)}
          placeholder="Enter your Description"
          style={{
            width: '100%',
            padding: '12px 14px',
            fontSize: '14px',
            border: `1.5px solid ${desc && !isDescValid ? 'var(--red)' : '#E5E7EB'}`,
            borderRadius: '10px',
            backgroundColor: '#FAFAFA',
            marginTop: '6px',
            resize: 'none',
          }}
        />
        {!isDescValid && (
          <span style={{ fontSize: '11px', color: 'var(--red)', marginTop: '4px', display: 'block' }}>
            Value must be more than 100 characters ({desc.length}/101)
          </span>
        )}
      </div>

      {/* Upload Image */}
      <div style={{ marginBottom: '16px' }}>
        <div
          onClick={() => openImagePicker((url) => setImage(url))}
          style={{
            border: '2px dashed #CBD5E1',
            borderRadius: '12px',
            padding: '14px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            gap: '12px',
            cursor: 'pointer',
            backgroundColor: '#F8FAFC',
          }}
        >
          {image ? (
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
              <img
                src={image}
                alt="Selected"
                style={{ width: '48px', height: '48px', borderRadius: '10px', objectFit: 'cover' }}
              />
              <span style={{ fontSize: '13px', fontWeight: 600, color: 'var(--kprimary)' }}>
                Change Animal Photo
              </span>
            </div>
          ) : (
            <>
              <img src={subtractIcon} alt="Upload" style={{ width: '24px', height: '24px' }} />
              <span style={{ fontSize: '13px', color: 'var(--lightgrey2)' }}>
                Tap to upload animal image
              </span>
            </>
          )}
        </div>
      </div>

      {/* Price */}
      <div style={{ marginBottom: '16px' }}>
        <label style={{ fontSize: '15px', color: '#3C3C3C', fontWeight: 500 }}>Animal Price ($)</label>
        <input
          type="number"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
          placeholder="Enter your Animal Price"
          style={{
            width: '100%',
            padding: '12px 14px',
            fontSize: '14px',
            border: '1.5px solid #E5E7EB',
            borderRadius: '10px',
            backgroundColor: '#FAFAFA',
            marginTop: '6px',
          }}
        />
      </div>

      {/* Category Selection Choice Chips (CategorytabchoiceCheap) */}
      <div style={{ marginBottom: '22px' }}>
        <label style={{ fontSize: '14px', color: '#3C3C3C', fontWeight: 600, marginBottom: '8px', display: 'block' }}>
          Select Category:
        </label>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>
          {categories.map((cat) => (
            <button
              key={cat.id}
              type="button"
              onClick={() => setCatId(cat.id)}
              style={{
                padding: '6px 14px',
                borderRadius: '18px',
                fontSize: '12px',
                fontWeight: 600,
                cursor: 'pointer',
                border: '1px solid #CBD5E1',
                backgroundColor: catId === cat.id ? 'var(--kprimary)' : '#ffffff',
                color: catId === cat.id ? '#ffffff' : 'var(--black)',
              }}
            >
              {cat.name}
            </button>
          ))}
        </div>
      </div>

      {/* Submit Button */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
        <button
          onClick={handleSave}
          disabled={!isFormValid}
          style={{
            width: '100%',
            padding: '14px',
            backgroundColor: isFormValid ? 'var(--kprimary)' : '#A3B8B5',
            color: '#ffffff',
            fontSize: '16px',
            fontWeight: 600,
            borderRadius: '10px',
            border: 'none',
            cursor: isFormValid ? 'pointer' : 'not-allowed',
          }}
        >
          {editingAnimal ? 'Edit' : 'Add'}
        </button>

        {editingAnimal && (
          <button
            onClick={handleDelete}
            style={{
              width: '100%',
              padding: '14px',
              backgroundColor: 'var(--red)',
              color: '#ffffff',
              fontSize: '16px',
              fontWeight: 600,
              borderRadius: '10px',
              border: 'none',
              cursor: 'pointer',
            }}
          >
            Delete
          </button>
        )}
      </div>
    </div>
  );
};

// ==================== 5. ME TAB (Profile) ====================
const MeTab: React.FC = () => {
  const { user, animals, categories, navigate, showToast, setIsLoggedIn } = useDemo();

  const handleLogout = () => {
    setIsLoggedIn(false);
    showToast('Logged out of ANIMOOO', 'info');
    navigate('/Login');
  };

  return (
    <div style={{ padding: '0 18px' }}>
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          padding: '20px 0',
        }}
      >
        <img
          src={user.avatar}
          alt={user.name}
          style={{
            width: '88px',
            height: '88px',
            borderRadius: '50%',
            objectFit: 'cover',
            border: '3px solid var(--kprimary)',
            marginBottom: '12px',
          }}
        />
        <h2 style={{ fontSize: '20px', fontWeight: 800, color: 'var(--kprimary)' }}>
          {user.name}
        </h2>
        <span style={{ fontSize: '13px', color: 'var(--lightgrey2)' }}>{user.email}</span>
        <span style={{ fontSize: '12px', color: 'var(--klightgreen)', fontWeight: 600, marginTop: '4px' }}>
          {user.role}
        </span>
      </div>

      {/* Stats Cards */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: '1fr 1fr',
          gap: '12px',
          margin: '16px 0 24px',
        }}
      >
        <div
          style={{
            backgroundColor: '#F8FAFC',
            padding: '14px',
            borderRadius: '14px',
            textAlign: 'center',
            border: '1px solid #ECECEC',
          }}
        >
          <div style={{ fontSize: '24px', fontWeight: 800, color: 'var(--kprimary)' }}>
            {animals.length}
          </div>
          <div style={{ fontSize: '12px', color: 'var(--lightgrey2)', marginTop: '2px' }}>
            Listed Animals
          </div>
        </div>

        <div
          style={{
            backgroundColor: '#F8FAFC',
            padding: '14px',
            borderRadius: '14px',
            textAlign: 'center',
            border: '1px solid #ECECEC',
          }}
        >
          <div style={{ fontSize: '24px', fontWeight: 800, color: 'var(--kprimary)' }}>
            {categories.length}
          </div>
          <div style={{ fontSize: '12px', color: 'var(--lightgrey2)', marginTop: '2px' }}>
            Categories
          </div>
        </div>
      </div>

      {/* Actions */}
      <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
        <button
          onClick={() => navigate('/SeeAll')}
          style={{
            width: '100%',
            padding: '14px',
            backgroundColor: '#F3F4F6',
            color: 'var(--black)',
            fontSize: '14px',
            fontWeight: 600,
            borderRadius: '12px',
            border: 'none',
            cursor: 'pointer',
            textAlign: 'left',
          }}
        >
          📂 Browse All Categories
        </button>

        <button
          onClick={() => showToast('App notifications enabled')}
          style={{
            width: '100%',
            padding: '14px',
            backgroundColor: '#F3F4F6',
            color: 'var(--black)',
            fontSize: '14px',
            fontWeight: 600,
            borderRadius: '12px',
            border: 'none',
            cursor: 'pointer',
            textAlign: 'left',
          }}
        >
          🔔 Notification Settings
        </button>

        <button
          onClick={handleLogout}
          style={{
            width: '100%',
            padding: '14px',
            backgroundColor: 'rgba(252, 27, 26, 0.08)',
            color: 'var(--red)',
            fontSize: '14px',
            fontWeight: 700,
            borderRadius: '12px',
            border: 'none',
            cursor: 'pointer',
            marginTop: '12px',
          }}
        >
          Log Out
        </button>
      </div>
    </div>
  );
};

// ==================== NAV BUTTON HELPER ====================
const NavButton: React.FC<{
  active: boolean;
  icon: React.ReactNode;
  label: string;
  onClick: () => void;
}> = ({ active, icon, label, onClick }) => (
  <button
    type="button"
    onClick={onClick}
    style={{
      background: 'none',
      border: 'none',
      cursor: 'pointer',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      gap: '2px',
      color: active ? 'var(--kprimary)' : 'var(--lightgrey)',
      fontWeight: active ? 700 : 500,
      fontSize: '11px',
      padding: '4px 8px',
      transition: 'color 0.15s ease',
    }}
  >
    <div style={{ transform: active ? 'scale(1.1)' : 'scale(1)', transition: 'transform 0.15s ease' }}>
      {icon}
    </div>
    <span>{label}</span>
  </button>
);
