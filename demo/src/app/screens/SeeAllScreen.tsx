import React, { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { ChevronLeft, Plus, Search, Folder } from 'lucide-react';

export const SeeAllScreen: React.FC = () => {
  const { categories, back, navigate, setEditingCategory, setActiveMainTab } = useDemo();
  const [query, setQuery] = useState('');

  const filtered = categories.filter((c) =>
    c.name.toLowerCase().includes(query.toLowerCase()) ||
    c.description.toLowerCase().includes(query.toLowerCase())
  );

  const handleSelectCategory = (cat: any) => {
    setEditingCategory(cat);
    navigate('/');
    setActiveMainTab(2); // Go to Category tab in Edit mode
  };

  const handleAddNew = () => {
    setEditingCategory(null);
    navigate('/');
    setActiveMainTab(2);
  };

  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        minHeight: '100%',
        backgroundColor: '#ffffff',
        padding: '0 16px',
        paddingTop: 'calc(var(--safe-top, 54px) + 8px)',
        paddingBottom: 'calc(var(--safe-bottom, 34px) + 20px)',
        overflowY: 'auto',
      }}
    >
      {/* App Bar */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          marginBottom: '16px',
        }}
      >
        <button
          type="button"
          onClick={() => back() || navigate('/')}
          style={{
            background: 'none',
            border: 'none',
            cursor: 'pointer',
            padding: '4px',
            color: 'var(--kprimary)',
            display: 'flex',
            alignItems: 'center',
          }}
        >
          <ChevronLeft size={24} />
        </button>

        <h1
          style={{
            fontFamily: 'var(--font-poppins)',
            fontSize: '18px',
            fontWeight: 700,
            color: 'var(--kprimary)',
          }}
        >
          All Categories ({categories.length})
        </h1>

        <button
          onClick={handleAddNew}
          style={{
            background: 'none',
            border: 'none',
            color: 'var(--kprimary)',
            cursor: 'pointer',
            padding: '4px',
          }}
          title="Add New Category"
        >
          <Plus size={22} />
        </button>
      </div>

      {/* Search Input */}
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '10px',
          padding: '10px 14px',
          backgroundColor: '#F3F4F6',
          borderRadius: '12px',
          marginBottom: '20px',
        }}
      >
        <Search size={18} color="#9CA3AF" />
        <input
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          placeholder="Search categories..."
          style={{
            background: 'none',
            border: 'none',
            outline: 'none',
            width: '100%',
            fontSize: '14px',
          }}
        />
      </div>

      {/* Categories Grid */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(2, 1fr)',
          gap: '14px',
        }}
      >
        {filtered.map((cat) => (
          <div
            key={cat.id}
            onClick={() => handleSelectCategory(cat)}
            style={{
              backgroundColor: '#FAFAFA',
              borderRadius: '16px',
              border: '1px solid #E5E7EB',
              overflow: 'hidden',
              cursor: 'pointer',
              transition: 'transform 0.15s ease, box-shadow 0.15s ease',
              display: 'flex',
              flexDirection: 'column',
            }}
          >
            <div style={{ position: 'relative', width: '100%', height: '110px' }}>
              <img
                src={cat.imagepath}
                alt={cat.name}
                style={{ width: '100%', height: '100%', objectFit: 'cover' }}
              />
              <span
                style={{
                  position: 'absolute',
                  top: '8px',
                  right: '8px',
                  backgroundColor: 'var(--kprimary)',
                  color: '#ffffff',
                  fontSize: '11px',
                  fontWeight: 700,
                  padding: '3px 8px',
                  borderRadius: '12px',
                }}
              >
                {cat.count} pets
              </span>
            </div>

            <div style={{ padding: '12px' }}>
              <h3
                style={{
                  fontSize: '15px',
                  fontWeight: 700,
                  color: 'var(--black)',
                  marginBottom: '4px',
                }}
              >
                {cat.name}
              </h3>
              <p
                style={{
                  fontSize: '12px',
                  color: 'var(--lightgrey2)',
                  display: '-webkit-box',
                  WebkitLineClamp: 2,
                  WebkitBoxOrient: 'vertical',
                  overflow: 'hidden',
                  lineHeight: '1.4',
                }}
              >
                {cat.description}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
