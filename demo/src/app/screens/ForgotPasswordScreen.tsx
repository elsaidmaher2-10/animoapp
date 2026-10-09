import React, { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { ChevronLeft } from 'lucide-react';

export const ForgotPasswordScreen: React.FC = () => {
  const { navigate, back, showToast, notify } = useDemo();
  const [email, setEmail] = useState('elsaid.maher@example.com');
  const isEmailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!isEmailValid) {
      showToast('Please enter a valid email address', 'error');
      return;
    }

    showToast('OTP sent to ' + email, 'success');
    // Also trigger notification simulation
    notify({
      title: '🔐 Verification Code Sent',
      body: 'Your Animo security OTP code is 8492. Valid for 60 seconds.',
      route: '/optverivication',
      category: 'Auth',
    });

    navigate('/optverivication', { email, screen: 'ForgetPassword' });
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
          fontSize: '26px',
          fontWeight: 700,
          color: 'var(--kprimary)',
          marginBottom: '8px',
        }}
      >
        Forget Password
      </h1>

      <p
        style={{
          fontSize: '14px',
          color: 'var(--lightgrey2)',
          lineHeight: '1.5',
          marginBottom: '38px',
        }}
      >
        Please enter the email address associated with your account, and we'll send you OTP to reset your password.
      </p>

      <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column' }}>
        <label
          style={{
            fontSize: '15px',
            color: 'var(--lightgrey)',
            marginBottom: '6px',
            fontWeight: 500,
          }}
        >
          Email
        </label>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Enter your email address"
          style={{
            width: '100%',
            padding: '14px 16px',
            fontSize: '15px',
            border: '1.5px solid #E5E7EB',
            borderRadius: '12px',
            backgroundColor: '#FAFAFA',
            marginBottom: '40px',
          }}
        />

        <button
          type="submit"
          disabled={!isEmailValid}
          style={{
            width: '100%',
            padding: '14px',
            backgroundColor: isEmailValid ? 'var(--kprimary)' : '#A3B8B5',
            color: '#ffffff',
            fontSize: '16px',
            fontWeight: 600,
            borderRadius: '10px',
            border: 'none',
            cursor: isEmailValid ? 'pointer' : 'not-allowed',
          }}
        >
          Send Code
        </button>
      </form>
    </div>
  );
};
