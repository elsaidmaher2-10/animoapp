import React, { useState, useEffect, useRef } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { ChevronLeft } from 'lucide-react';

export const OtpScreen: React.FC = () => {
  const { navigate, back, currentArgs, showToast, showQuickAlert } = useDemo();
  const screenOrigin = currentArgs.screen || 'ForgetPassword';
  const email = currentArgs.email || 'elsaid.maher@example.com';

  const [digits, setDigits] = useState(['8', '4', '9', '2']);
  const [timer, setTimer] = useState(58);
  const inputRefs = [
    useRef<HTMLInputElement>(null),
    useRef<HTMLInputElement>(null),
    useRef<HTMLInputElement>(null),
    useRef<HTMLInputElement>(null),
  ];

  useEffect(() => {
    if (timer > 0) {
      const interval = setInterval(() => setTimer((t) => t - 1), 1000);
      return () => clearInterval(interval);
    }
  }, [timer]);

  const handleDigitChange = (index: number, val: string) => {
    if (val.length > 1) {
      val = val[val.length - 1];
    }
    const newDigits = [...digits];
    newDigits[index] = val;
    setDigits(newDigits);

    if (val && index < 3) {
      inputRefs[index + 1].current?.focus();
    }
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Backspace' && !digits[index] && index > 0) {
      inputRefs[index - 1].current?.focus();
    }
  };

  const handleResend = () => {
    if (timer > 0) return;
    setTimer(60);
    showToast('New OTP code sent (8492)', 'info');
  };

  const handleConfirm = () => {
    const code = digits.join('');
    if (code.length < 4) {
      showToast('Please enter all 4 digits', 'error');
      return;
    }

    showToast('Code verified successfully!', 'success');

    if (screenOrigin === 'signup') {
      showQuickAlert({
        type: 'success',
        title: 'Account Created',
        text: 'Your registration was completed successfully! You can now log in.',
        confirmBtnText: 'Go to Login',
        onConfirm: () => navigate('/Login'),
      });
    } else {
      navigate('/ConfirmPassword', { email });
    }
  };

  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        minHeight: '100%',
        backgroundColor: '#ffffff',
        padding: '0 18px',
        paddingTop: 'calc(var(--safe-top, 54px) + 8px)',
        paddingBottom: 'calc(var(--safe-bottom, 34px) + 20px)',
      }}
    >
      {/* App Bar */}
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: '24px' }}>
        <button
          type="button"
          onClick={() => back() || navigate('/Login')}
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
      </div>

      <h1
        style={{
          fontFamily: 'var(--font-otama)',
          fontSize: '24px',
          fontWeight: 700,
          color: 'var(--kprimary)',
          marginBottom: '8px',
        }}
      >
        OTP Verfication
      </h1>

      <p
        style={{
          fontSize: '14px',
          color: 'var(--lightgrey)',
          lineHeight: '1.4',
          marginBottom: '38px',
        }}
      >
        Please enter the 4 digit code sent your phone number or email ({email})
      </p>

      {/* 4 Digit Boxes */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(4, 1fr)',
          gap: '12px',
          marginBottom: '28px',
        }}
      >
        {digits.map((digit, index) => (
          <input
            key={index}
            ref={inputRefs[index]}
            type="text"
            inputMode="numeric"
            maxLength={1}
            value={digit}
            onChange={(e) => handleDigitChange(index, e.target.value)}
            onKeyDown={(e) => handleKeyDown(index, e)}
            style={{
              height: '58px',
              textAlign: 'center',
              fontSize: '22px',
              fontWeight: 700,
              color: 'var(--kprimary)',
              border: '2px solid #E2E8F0',
              borderRadius: '16px',
              outline: 'none',
              backgroundColor: '#F8FAFC',
              transition: 'border-color 0.15s ease',
            }}
            onFocus={(e) => (e.target.style.borderColor = 'var(--kprimary)')}
            onBlur={(e) => (e.target.style.borderColor = '#E2E8F0')}
          />
        ))}
      </div>

      {/* Confirm Button */}
      <button
        type="button"
        onClick={handleConfirm}
        style={{
          width: '100%',
          padding: '14px',
          backgroundColor: 'var(--kprimary)',
          color: '#ffffff',
          fontSize: '16px',
          fontWeight: 600,
          borderRadius: '10px',
          border: 'none',
          cursor: 'pointer',
          marginBottom: '16px',
        }}
      >
        Confirm
      </button>

      {/* Resend Timer */}
      <div style={{ textAlign: 'center' }}>
        <button
          type="button"
          onClick={handleResend}
          disabled={timer > 0}
          style={{
            background: 'none',
            border: 'none',
            fontSize: '13px',
            color: timer > 0 ? 'var(--lightgrey2)' : 'var(--kprimary)',
            fontWeight: 500,
            cursor: timer > 0 ? 'default' : 'pointer',
          }}
        >
          {timer > 0
            ? `Resend in 00:${timer.toString().padStart(2, '0')}`
            : 'Resend code'}
        </button>
      </div>
    </div>
  );
};
