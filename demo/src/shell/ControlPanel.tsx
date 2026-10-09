import React, { useState } from 'react';
import { useDemo } from '../bridge/DemoContext';
import { DEMO_CONFIG } from '../demo.config';
import {
  Bell,
  Smartphone,
  Navigation,
  Sparkles,
  Lock,
  Unlock,
  Camera,
  Layers,
  ZoomIn,
  ZoomOut,
  Send,
  ExternalLink,
} from 'lucide-react';

export const ControlPanel: React.FC = () => {
  const {
    notify,
    navigate,
    currentRoute,
    isLocked,
    lock,
    unlock,
    frameColor,
    setFrameColor,
    zoom,
    setZoom,
    runAction,
    categories,
    animals,
  } = useDemo();

  const [customTitle, setCustomTitle] = useState('');
  const [customBody, setCustomBody] = useState('');
  const [customRoute, setCustomRoute] = useState('/');

  const handleSendCustomNotif = (e: React.FormEvent) => {
    e.preventDefault();
    if (!customTitle.trim() || !customBody.trim()) return;
    notify({
      title: customTitle,
      body: customBody,
      route: customRoute,
    });
    setCustomTitle('');
    setCustomBody('');
  };

  return (
    <aside className="control-panel">
      {/* App Header Badge */}
      <div>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <h2 style={{ fontSize: '18px', fontWeight: 800, color: '#ffffff', letterSpacing: '-0.3px' }}>
            ANIMOOO Showcase
          </h2>
          <span
            style={{
              fontSize: '11px',
              backgroundColor: 'rgba(22, 169, 159, 0.2)',
              color: 'var(--klightgreen)',
              padding: '2px 8px',
              borderRadius: '6px',
              fontWeight: 700,
            }}
          >
            v1.0.0
          </span>
        </div>
        <p style={{ fontSize: '12px', color: '#94a3b8', marginTop: '4px', lineHeight: '1.4' }}>
          Interactive Flutter app rebuild in React 19 + TypeScript inside iPhone 16 Pro shell.
        </p>
      </div>

      {/* Push Notification Simulator */}
      <div>
        <div className="panel-section-title">
          <Bell size={14} color="var(--klightgreen)" />
          Simulate Push Notifications
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
          {DEMO_CONFIG.notifications.map((item) => (
            <button
              key={item.id}
              className="chip-btn"
              onClick={() => notify(item)}
              style={{ justifyContent: 'space-between', width: '100%' }}
            >
              <span style={{ fontWeight: 600 }}>{item.title}</span>
              <span style={{ fontSize: '11px', opacity: 0.7 }}>Trigger</span>
            </button>
          ))}
        </div>

        {/* Custom Notification Input */}
        <form onSubmit={handleSendCustomNotif} style={{ marginTop: '10px' }}>
          <div style={{ display: 'flex', gap: '6px', marginBottom: '6px' }}>
            <input
              type="text"
              placeholder="Title..."
              value={customTitle}
              onChange={(e) => setCustomTitle(e.target.value)}
              style={{
                flex: 1,
                padding: '6px 10px',
                fontSize: '12px',
                borderRadius: '8px',
                border: '1px solid rgba(255,255,255,0.15)',
                backgroundColor: 'rgba(0,0,0,0.25)',
                color: '#fff',
                outline: 'none',
              }}
            />
            <select
              value={customRoute}
              onChange={(e) => setCustomRoute(e.target.value)}
              style={{
                padding: '6px 8px',
                fontSize: '11px',
                borderRadius: '8px',
                border: '1px solid rgba(255,255,255,0.15)',
                backgroundColor: '#1E293B',
                color: '#fff',
                outline: 'none',
              }}
            >
              <option value="/">Home</option>
              <option value="/SeeAll">See All</option>
              <option value="/Login">Login</option>
              <option value="/register">Register</option>
              <option value="/optverivication">OTP</option>
            </select>
          </div>
          <div style={{ display: 'flex', gap: '6px' }}>
            <input
              type="text"
              placeholder="Message body..."
              value={customBody}
              onChange={(e) => setCustomBody(e.target.value)}
              style={{
                flex: 1,
                padding: '6px 10px',
                fontSize: '12px',
                borderRadius: '8px',
                border: '1px solid rgba(255,255,255,0.15)',
                backgroundColor: 'rgba(0,0,0,0.25)',
                color: '#fff',
                outline: 'none',
              }}
            />
            <button
              type="submit"
              className="chip-btn"
              style={{ padding: '6px 10px', backgroundColor: 'var(--kprimary)' }}
            >
              <Send size={12} />
            </button>
          </div>
        </form>
      </div>

      {/* Screen Deep Links / Navigation */}
      <div>
        <div className="panel-section-title">
          <Navigation size={14} color="var(--klightgreen)" />
          Screen Shortcuts & Deep Links
        </div>
        <div style={{ display: 'flex', flexWrap: 'wrap', gap: '6px' }}>
          {DEMO_CONFIG.features.map((feat) => {
            const isActive = feat.route && currentRoute === feat.route;
            return (
              <button
                key={feat.id}
                className={`chip-btn ${isActive ? 'active' : ''}`}
                onClick={() => {
                  if (feat.route) navigate(feat.route);
                  if (feat.action) runAction(feat.action);
                }}
              >
                {feat.label}
              </button>
            );
          })}
        </div>
      </div>

      {/* Simulated Hardware Actions */}
      <div>
        <div className="panel-section-title">
          <Sparkles size={14} color="var(--klightgreen)" />
          Hardware & Native Simulator
        </div>
        <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap' }}>
          <button
            className="chip-btn"
            onClick={() => (isLocked ? unlock() : lock())}
            style={{ flex: 1, justifyContent: 'center' }}
          >
            {isLocked ? <Unlock size={14} /> : <Lock size={14} />}
            {isLocked ? 'Unlock Phone' : 'Lock Phone'}
          </button>

          <button
            className="chip-btn"
            onClick={() => runAction('trigger_picker')}
            style={{ flex: 1, justifyContent: 'center' }}
          >
            <Camera size={14} />
            Camera Sheet
          </button>
        </div>
      </div>

      {/* Frame Appearance Controls */}
      <div>
        <div className="panel-section-title">
          <Smartphone size={14} color="var(--klightgreen)" />
          Device Appearance & Scale
        </div>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
          <span style={{ fontSize: '12px', color: '#94a3b8' }}>Frame Finish:</span>
          <div style={{ display: 'flex', gap: '6px' }}>
            {(['midnight', 'titanium', 'starlight', 'purple'] as const).map((col) => (
              <button
                key={col}
                onClick={() => setFrameColor(col)}
                title={col}
                style={{
                  width: '20px',
                  height: '20px',
                  borderRadius: '50%',
                  border: frameColor === col ? '2px solid #ffffff' : '1px solid rgba(255,255,255,0.2)',
                  cursor: 'pointer',
                  backgroundColor:
                    col === 'midnight'
                      ? '#1e2430'
                      : col === 'titanium'
                      ? '#8a8d91'
                      : col === 'starlight'
                      ? '#e4e2dd'
                      : '#372847',
                }}
              />
            ))}
          </div>
        </div>

        {/* Zoom controls */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <span style={{ fontSize: '12px', color: '#94a3b8' }}>Zoom: {Math.round(zoom * 100)}%</span>
          <div style={{ display: 'flex', gap: '6px' }}>
            <button
              className="chip-btn"
              onClick={() => setZoom(Math.max(0.7, zoom - 0.1))}
              disabled={zoom <= 0.7}
              style={{ padding: '4px 8px' }}
            >
              <ZoomOut size={13} />
            </button>
            <button
              className="chip-btn"
              onClick={() => setZoom(1)}
              style={{ padding: '4px 8px' }}
            >
              100%
            </button>
            <button
              className="chip-btn"
              onClick={() => setZoom(Math.min(1.2, zoom + 0.1))}
              disabled={zoom >= 1.2}
              style={{ padding: '4px 8px' }}
            >
              <ZoomIn size={13} />
            </button>
          </div>
        </div>
      </div>
    </aside>
  );
};
