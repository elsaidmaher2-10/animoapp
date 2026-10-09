import React from 'react';
import { useDemo } from '../bridge/DemoContext';
import { DemoNotification } from '../demo.config';
import logoSvg from '../app/assets/logo.svg';
import { Flashlight, Camera, Lock, Unlock } from 'lucide-react';

export const LockScreen: React.FC = () => {
  const { isLocked, unlock, pendingNotifications, clearNotifications } = useDemo();

  if (!isLocked) return null;

  return (
    <div
      style={{
        position: 'absolute',
        inset: 0,
        background: 'linear-gradient(180deg, #162a26 0%, #041f1a 100%)',
        color: '#ffffff',
        zIndex: 970,
        display: 'flex',
        flexDirection: 'column',
        padding: '0 20px',
        paddingTop: 'calc(var(--safe-top, 54px) + 20px)',
        paddingBottom: 'calc(var(--safe-bottom, 34px) + 16px)',
        animation: 'fadeIn 0.25s ease',
      }}
    >
      {/* Lock Icon */}
      <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '8px' }}>
        <Lock size={18} color="rgba(255,255,255,0.7)" />
      </div>

      {/* Date & Time */}
      <div style={{ textAlign: 'center', marginBottom: '28px' }}>
        <div style={{ fontSize: '15px', fontWeight: 500, color: 'rgba(255,255,255,0.85)' }}>
          Friday, October 9
        </div>
        <div
          style={{
            fontSize: '76px',
            fontWeight: 700,
            letterSpacing: '-2px',
            fontFamily: '-apple-system, BlinkMacSystemFont, sans-serif',
            lineHeight: 1,
            marginTop: '2px',
          }}
        >
          9:41
        </div>
      </div>

      {/* Notification Center on Lock Screen */}
      <div style={{ flex: 1, overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '10px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <span style={{ fontSize: '12px', fontWeight: 600, color: 'rgba(255,255,255,0.6)' }}>
            NOTIFICATIONS ({pendingNotifications.length})
          </span>
          {pendingNotifications.length > 0 && (
            <button
              onClick={clearNotifications}
              style={{
                background: 'none',
                border: 'none',
                color: 'rgba(255,255,255,0.6)',
                fontSize: '11px',
                cursor: 'pointer',
              }}
            >
              Clear all
            </button>
          )}
        </div>

        {pendingNotifications.map((notif: DemoNotification) => (
          <div
            key={notif.id}
            onClick={() => unlock(notif.route)}
            style={{
              backgroundColor: 'rgba(255, 255, 255, 0.16)',
              backdropFilter: 'blur(20px)',
              borderRadius: '16px',
              padding: '12px 14px',
              cursor: 'pointer',
              border: '1px solid rgba(255, 255, 255, 0.15)',
              transition: 'transform 0.15s ease',
            }}
          >
            <div style={{ display: 'flex', alignItems: 'center', gap: '6px', marginBottom: '4px' }}>
              <img src={logoSvg} alt="Logo" style={{ width: '16px', height: '16px' }} />
              <span style={{ fontSize: '11.5px', fontWeight: 600, color: 'rgba(255,255,255,0.9)' }}>
                ANIMOOO
              </span>
              <span style={{ fontSize: '10px', color: 'rgba(255,255,255,0.5)', marginLeft: 'auto' }}>
                {notif.time || 'now'}
              </span>
            </div>
            <div style={{ fontSize: '13px', fontWeight: 700, marginBottom: '2px' }}>
              {notif.title}
            </div>
            <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.8)', lineHeight: '1.3' }}>
              {notif.body}
            </div>
          </div>
        ))}
      </div>

      {/* Unlock CTA */}
      <div style={{ textAlign: 'center', margin: '14px 0' }}>
        <button
          onClick={() => unlock()}
          style={{
            background: 'none',
            border: 'none',
            color: 'rgba(255,255,255,0.7)',
            fontSize: '13px',
            fontWeight: 500,
            cursor: 'pointer',
            display: 'inline-flex',
            alignItems: 'center',
            gap: '6px',
          }}
        >
          <Unlock size={14} />
          Tap anywhere or click here to unlock
        </button>
      </div>

      {/* Lock Screen Bottom Tools (Flashlight & Camera) */}
      <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0 16px' }}>
        <div
          onClick={() => unlock()}
          style={{
            width: '46px',
            height: '46px',
            borderRadius: '50%',
            backgroundColor: 'rgba(255,255,255,0.2)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            cursor: 'pointer',
          }}
        >
          <Flashlight size={20} color="#ffffff" />
        </div>
        <div
          onClick={() => unlock('/')}
          style={{
            width: '46px',
            height: '46px',
            borderRadius: '50%',
            backgroundColor: 'rgba(255,255,255,0.2)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            cursor: 'pointer',
          }}
        >
          <Camera size={20} color="#ffffff" />
        </div>
      </div>
    </div>
  );
};
