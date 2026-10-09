import React, { useState, useEffect } from 'react';
import { Wifi } from 'lucide-react';

export const StatusBar: React.FC<{ isDarkContent?: boolean }> = ({ isDarkContent = true }) => {
  const [time, setTime] = useState('9:41');

  useEffect(() => {
    const updateTime = () => {
      const now = new Date();
      const hours = now.getHours();
      const minutes = now.getMinutes().toString().padStart(2, '0');
      setTime(`${hours % 12 || 12}:${minutes}`);
    };
    updateTime();
    const interval = setInterval(updateTime, 10000);
    return () => clearInterval(interval);
  }, []);

  const color = isDarkContent ? '#000000' : '#ffffff';

  return (
    <div
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        height: '48px',
        padding: '0 28px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        zIndex: 960,
        pointerEvents: 'none',
        color,
      }}
    >
      {/* Time on left */}
      <span
        style={{
          fontSize: '14.5px',
          fontWeight: 700,
          letterSpacing: '-0.2px',
          fontFamily: '-apple-system, BlinkMacSystemFont, sans-serif',
        }}
      >
        {time}
      </span>

      {/* Status icons on right */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
        {/* Cell signal */}
        <div style={{ display: 'flex', alignItems: 'flex-end', gap: '1.5px', height: '11px' }}>
          <div style={{ width: '3px', height: '3px', backgroundColor: color, borderRadius: '0.5px' }} />
          <div style={{ width: '3px', height: '5px', backgroundColor: color, borderRadius: '0.5px' }} />
          <div style={{ width: '3px', height: '8px', backgroundColor: color, borderRadius: '0.5px' }} />
          <div style={{ width: '3px', height: '11px', backgroundColor: color, borderRadius: '0.5px' }} />
        </div>

        {/* Wifi */}
        <Wifi size={14} color={color} strokeWidth={2.4} />

        {/* Battery */}
        <div
          style={{
            width: '22px',
            height: '11.5px',
            border: `1.5px solid ${color}`,
            borderRadius: '3.5px',
            padding: '1.5px',
            display: 'flex',
            alignItems: 'center',
            position: 'relative',
          }}
        >
          <div
            style={{
              width: '80%',
              height: '100%',
              backgroundColor: color,
              borderRadius: '1.5px',
            }}
          />
          <div
            style={{
              position: 'absolute',
              right: '-3.5px',
              top: '3px',
              width: '1.5px',
              height: '4px',
              backgroundColor: color,
              borderRadius: '0 1px 1px 0',
            }}
          />
        </div>
      </div>
    </div>
  );
};
