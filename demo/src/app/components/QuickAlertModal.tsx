import React from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { Check, AlertCircle, Info, AlertTriangle } from 'lucide-react';

export const QuickAlertModal: React.FC = () => {
  const { quickAlert, closeQuickAlert } = useDemo();

  if (!quickAlert) return null;

  const handleConfirm = () => {
    if (quickAlert.onConfirm) {
      quickAlert.onConfirm();
    }
    closeQuickAlert();
  };

  const getIcon = () => {
    switch (quickAlert.type) {
      case 'success':
        return <Check size={36} color="#ffffff" strokeWidth={3} />;
      case 'error':
        return <AlertCircle size={36} color="#ffffff" strokeWidth={2.5} />;
      case 'warning':
        return <AlertTriangle size={36} color="#ffffff" strokeWidth={2.5} />;
      default:
        return <Info size={36} color="#ffffff" strokeWidth={2.5} />;
    }
  };

  const getHeaderBg = () => {
    switch (quickAlert.type) {
      case 'success':
        return 'var(--kprimary)';
      case 'error':
        return 'var(--red)';
      case 'warning':
        return '#f59e0b';
      default:
        return 'var(--klightgreen)';
    }
  };

  return (
    <div
      style={{
        position: 'absolute',
        inset: 0,
        backgroundColor: 'rgba(0,0,0,0.5)',
        backdropFilter: 'blur(4px)',
        zIndex: 1000,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '24px',
        animation: 'fadeIn 0.2s ease',
      }}
      onClick={closeQuickAlert}
    >
      <div
        style={{
          width: '100%',
          maxWidth: '300px',
          backgroundColor: '#ffffff',
          borderRadius: '24px',
          overflow: 'hidden',
          boxShadow: '0 20px 40px rgba(0,0,0,0.25)',
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          textAlign: 'center',
          animation: 'scaleUp 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275)',
        }}
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header circular icon badge */}
        <div
          style={{
            width: '100%',
            height: '90px',
            backgroundColor: getHeaderBg(),
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            position: 'relative',
          }}
        >
          <div
            style={{
              width: '64px',
              height: '64px',
              borderRadius: '50%',
              backgroundColor: 'rgba(255,255,255,0.2)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              border: '2px solid rgba(255,255,255,0.4)',
            }}
          >
            {getIcon()}
          </div>
        </div>

        {/* Body Text */}
        <div style={{ padding: '24px 20px 20px', width: '100%' }}>
          <h3
            style={{
              fontSize: '18px',
              fontWeight: 700,
              color: 'var(--text-dark)',
              marginBottom: '10px',
              textTransform: 'capitalize',
            }}
          >
            {quickAlert.title || (quickAlert.type === 'success' ? 'Success' : 'Notice')}
          </h3>
          <p
            style={{
              fontSize: '14px',
              color: 'var(--lightgrey2)',
              lineHeight: '1.5',
              marginBottom: '22px',
            }}
          >
            {quickAlert.text}
          </p>

          <button
            onClick={handleConfirm}
            style={{
              width: '100%',
              padding: '12px 16px',
              backgroundColor: 'var(--kprimary)',
              color: '#ffffff',
              fontSize: '15px',
              fontWeight: 600,
              borderRadius: '12px',
              border: 'none',
              cursor: 'pointer',
              transition: 'transform 0.15s ease',
            }}
          >
            {quickAlert.confirmBtnText || 'Okay'}
          </button>
        </div>
      </div>
    </div>
  );
};
