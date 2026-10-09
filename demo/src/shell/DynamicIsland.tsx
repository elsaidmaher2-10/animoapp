import React from 'react';
import { useDemo } from '../bridge/DemoContext';
import logoSvg from '../app/assets/logo.svg';

export const DynamicIsland: React.FC = () => {
  const { activeBanner } = useDemo();

  return (
    <div
      className={`dynamic-island ${activeBanner ? 'expanded' : 'compact'}`}
      style={{
        cursor: 'pointer',
      }}
    >
      {activeBanner ? (
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            width: '100%',
            overflow: 'hidden',
          }}
        >
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <img
              src={logoSvg}
              alt="Animo"
              style={{
                width: '36px',
                height: '36px',
                borderRadius: '8px',
                backgroundColor: 'rgba(255,255,255,0.15)',
                padding: '2px',
              }}
            />
            <div style={{ display: 'flex', flexDirection: 'column' }}>
              <span
                style={{
                  fontSize: '13px',
                  fontWeight: 700,
                  color: '#ffffff',
                  whiteSpace: 'nowrap',
                }}
              >
                {activeBanner.title}
              </span>
              <span
                style={{
                  fontSize: '11px',
                  color: '#A0AEC0',
                  whiteSpace: 'nowrap',
                  maxWidth: '220px',
                  overflow: 'hidden',
                  textOverflow: 'ellipsis',
                }}
              >
                {activeBanner.body}
              </span>
            </div>
          </div>
          <span
            style={{
              fontSize: '10px',
              color: 'var(--klightgreen)',
              fontWeight: 700,
              textTransform: 'uppercase',
            }}
          >
            NOW
          </span>
        </div>
      ) : (
        <>
          {/* Subtle camera lens & sensor dots */}
          <div
            style={{
              width: '10.5px',
              height: '10.5px',
              borderRadius: '50%',
              backgroundColor: '#0a0a0a',
              boxShadow: 'inset 0 0 2px #1f2937',
            }}
          />
          <div
            style={{
              width: '10px',
              height: '10px',
              borderRadius: '50%',
              backgroundColor: '#0a0a0a',
              boxShadow: 'inset 0 0 1px #223',
            }}
          />
        </>
      )}
    </div>
  );
};
