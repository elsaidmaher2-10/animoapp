import React from 'react';
import { useDemo } from '../../bridge/DemoContext';

export const ToastSnackbar: React.FC = () => {
  const { toasts, removeToast } = useDemo();

  if (toasts.length === 0) return null;

  return (
    <div
      style={{
        position: 'absolute',
        bottom: 'var(--safe-bottom, 34px)',
        left: 0,
        right: 0,
        zIndex: 950,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: '8px',
        padding: '0 12px',
        pointerEvents: 'none',
      }}
    >
      {toasts.map((toast) => (
        <div
          key={toast.id}
          onClick={() => removeToast(toast.id)}
          style={{
            pointerEvents: 'auto',
            width: '100%',
            backgroundColor: 'var(--kprimary)',
            color: 'var(--white)',
            padding: '14px 18px',
            borderRadius: '8px 8px 0 0',
            fontSize: '15px',
            fontWeight: 500,
            boxShadow: '0 -4px 16px rgba(0,0,0,0.18)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            cursor: 'pointer',
            animation: 'slideUp 0.25s ease',
          }}
        >
          <span>{toast.message}</span>
        </div>
      ))}
    </div>
  );
};
