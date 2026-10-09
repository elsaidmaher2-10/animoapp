import React from 'react';
import { useDemo } from '../bridge/DemoContext';
import logoSvg from '../app/assets/logo.svg';

export const NotificationBanner: React.FC = () => {
  const { activeBanner, dismissBanner, navigate } = useDemo();

  if (!activeBanner) return null;

  const handleClick = () => {
    if (activeBanner.route) {
      navigate(activeBanner.route);
    }
    dismissBanner();
  };

  return (
    <div
      role="status"
      aria-live="polite"
      onClick={handleClick}
      style={{
        position: 'absolute',
        top: 'calc(var(--safe-top, 54px) + 24px)',
        left: '12px',
        right: '12px',
        backgroundColor: 'rgba(255, 255, 255, 0.88)',
        backdropFilter: 'blur(25px)',
        borderRadius: '20px',
        padding: '12px 14px',
        boxShadow: '0 10px 30px rgba(0, 0, 0, 0.18)',
        zIndex: 980,
        cursor: 'pointer',
        animation: 'slideDown 0.3s cubic-bezier(0.16, 1, 0.3, 1)',
        border: '1px solid rgba(255, 255, 255, 0.4)',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '6px' }}>
        <img
          src={logoSvg}
          alt="ANIMOOO"
          style={{
            width: '20px',
            height: '20px',
            borderRadius: '5px',
            backgroundColor: '#ffffff',
          }}
        />
        <span
          style={{
            fontSize: '12px',
            fontWeight: 700,
            color: 'var(--kprimary)',
            letterSpacing: '0.2px',
          }}
        >
          ANIMOOO
        </span>
        <span style={{ fontSize: '11px', color: '#888888', marginLeft: 'auto' }}>
          {activeBanner.time || 'now'}
        </span>
      </div>

      <div style={{ paddingLeft: '2px' }}>
        <h4
          style={{
            fontSize: '13.5px',
            fontWeight: 700,
            color: '#111827',
            marginBottom: '3px',
          }}
        >
          {activeBanner.title}
        </h4>
        <p
          style={{
            fontSize: '12.5px',
            color: '#4B5563',
            lineHeight: '1.35',
            margin: 0,
          }}
        >
          {activeBanner.body}
        </p>
      </div>
    </div>
  );
};
