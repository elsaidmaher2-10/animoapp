import React from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { Camera, Image as ImageIcon, X } from 'lucide-react';

const SAMPLE_IMAGES = [
  'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=600&q=80',
  'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=600&q=80',
  'https://images.unsplash.com/photo-1548767797-d8c844163c4c?auto=format&fit=crop&w=600&q=80',
  'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2?auto=format&fit=crop&w=600&q=80',
];

export const ImagePickerSheet: React.FC = () => {
  const { isImagePickerOpen, closeImagePicker, imagePickerCallback } = useDemo();

  if (!isImagePickerOpen) return null;

  const handleSelect = (url: string) => {
    if (imagePickerCallback) {
      imagePickerCallback(url);
    }
    closeImagePicker();
  };

  const handleCameraSimulation = () => {
    const randomImg = SAMPLE_IMAGES[Math.floor(Math.random() * SAMPLE_IMAGES.length)];
    handleSelect(randomImg);
  };

  return (
    <div
      style={{
        position: 'absolute',
        inset: 0,
        backgroundColor: 'rgba(0,0,0,0.45)',
        zIndex: 999,
        display: 'flex',
        alignItems: 'flex-end',
        justifyContent: 'center',
        padding: '16px',
        animation: 'fadeIn 0.2s ease',
      }}
      onClick={closeImagePicker}
    >
      <div
        style={{
          width: '100%',
          maxWidth: '360px',
          display: 'flex',
          flexDirection: 'column',
          gap: '8px',
          animation: 'slideUp 0.25s cubic-bezier(0.16, 1, 0.3, 1)',
        }}
        onClick={(e) => e.stopPropagation()}
      >
        <div
          style={{
            backgroundColor: 'rgba(255,255,255,0.92)',
            backdropFilter: 'blur(20px)',
            borderRadius: '16px',
            overflow: 'hidden',
            display: 'flex',
            flexDirection: 'column',
            boxShadow: '0 8px 30px rgba(0,0,0,0.12)',
          }}
        >
          <div
            style={{
              padding: '12px 16px 8px',
              fontSize: '12px',
              fontWeight: 600,
              color: '#828282',
              textAlign: 'center',
              textTransform: 'uppercase',
              letterSpacing: '0.5px',
            }}
          >
            Select Photo Source
          </div>

          <button
            onClick={() => handleSelect(SAMPLE_IMAGES[0])}
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '10px',
              padding: '16px',
              fontSize: '16px',
              fontWeight: 600,
              color: 'var(--kprimary)',
              background: 'none',
              border: 'none',
              cursor: 'pointer',
              borderTop: '1px solid rgba(0,0,0,0.06)',
            }}
          >
            <ImageIcon size={20} color="var(--kprimary)" />
            Photo Gallery
          </button>

          <button
            onClick={handleCameraSimulation}
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '10px',
              padding: '16px',
              fontSize: '16px',
              fontWeight: 600,
              color: 'var(--kprimary)',
              background: 'none',
              border: 'none',
              cursor: 'pointer',
              borderTop: '1px solid rgba(0,0,0,0.06)',
            }}
          >
            <Camera size={20} color="var(--kprimary)" />
            Camera (Simulate Snap)
          </button>
        </div>

        <button
          onClick={closeImagePicker}
          style={{
            backgroundColor: 'var(--white)',
            borderRadius: '16px',
            padding: '16px',
            fontSize: '16px',
            fontWeight: 700,
            color: 'var(--red)',
            border: 'none',
            cursor: 'pointer',
            textAlign: 'center',
            boxShadow: '0 4px 14px rgba(0,0,0,0.08)',
          }}
        >
          Cancel
        </button>
      </div>
    </div>
  );
};
