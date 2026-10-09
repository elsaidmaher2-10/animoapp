import React, { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import logoSvg from '../assets/logo.svg';
import { Eye, EyeOff } from 'lucide-react';

export const LoginScreen: React.FC = () => {
  const { navigate, navigateNamedAndRemoveUntil, showQuickAlert, showToast, setIsLoggedIn } = useDemo();
  const [email, setEmail] = useState('elsaid.maher@example.com');
  const [password, setPassword] = useState('Password123!@#');
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(true);
  const [isLoading, setIsLoading] = useState(false);

  const isEmailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  const isPassValid = password.trim().length >= 6;
  const isFormValid = isEmailValid && isPassValid;

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    if (!isFormValid) {
      showToast('Please enter valid email and password', 'error');
      return;
    }

    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      setIsLoggedIn(true);
      showQuickAlert({
        type: 'success',
        title: 'Logged in successfully',
        text: 'Welcome back to ANIMOOO, El-said Maher!',
        confirmBtnText: 'Continue',
        onConfirm: () => {
          navigateNamedAndRemoveUntil('/');
        },
      });
    }, 600);
  };

  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        minHeight: '100%',
        backgroundColor: '#ffffff',
        padding: '0 18px',
        paddingTop: 'calc(var(--safe-top, 54px) + 12px)',
        paddingBottom: 'calc(var(--safe-bottom, 34px) + 16px)',
        position: 'relative',
      }}
    >
      {/* Header with SVG Logo */}
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          marginTop: '10px',
          marginBottom: '28px',
        }}
      >
        <img
          src={logoSvg}
          alt="ANIMOOO"
          style={{ width: '72px', height: '71px', objectFit: 'contain' }}
        />
        <div
          style={{
            fontFamily: 'var(--font-original-surfer)',
            fontSize: '11.5px',
            color: 'var(--kprimary)',
            fontWeight: 500,
            marginTop: '2px',
          }}
        >
          ANIMOOO
        </div>
        <h1
          style={{
            fontFamily: 'var(--font-otama)',
            fontSize: '38px',
            fontWeight: 600,
            color: 'var(--kprimary)',
            marginTop: '9px',
            lineHeight: 1.1,
          }}
        >
          Log In
        </h1>
      </div>

      {/* Form Fields */}
      <form onSubmit={handleLogin} style={{ display: 'flex', flexDirection: 'column' }}>
        {/* Email Field */}
        <label
          style={{
            fontSize: '16px',
            color: 'var(--lightgrey)',
            marginBottom: '6px',
            fontWeight: 500,
          }}
        >
          Email
        </label>
        <div style={{ position: 'relative', marginBottom: '16px' }}>
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
              outline: 'none',
              backgroundColor: '#FAFAFA',
              transition: 'border-color 0.15s ease',
            }}
            onFocus={(e) => (e.target.style.borderColor = 'var(--kprimary)')}
            onBlur={(e) => (e.target.style.borderColor = '#E5E7EB')}
          />
        </div>

        {/* Password Field */}
        <label
          style={{
            fontSize: '16px',
            color: 'var(--lightgrey)',
            marginBottom: '6px',
            fontWeight: 500,
          }}
        >
          Password
        </label>
        <div style={{ position: 'relative', marginBottom: '14px' }}>
          <input
            type={showPassword ? 'text' : 'password'}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="********"
            style={{
              width: '100%',
              padding: '14px 44px 14px 16px',
              fontSize: '15px',
              border: '1.5px solid #E5E7EB',
              borderRadius: '12px',
              outline: 'none',
              backgroundColor: '#FAFAFA',
              transition: 'border-color 0.15s ease',
            }}
            onFocus={(e) => (e.target.style.borderColor = 'var(--kprimary)')}
            onBlur={(e) => (e.target.style.borderColor = '#E5E7EB')}
          />
          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            style={{
              position: 'absolute',
              right: '12px',
              top: '50%',
              transform: 'translateY(-50%)',
              background: 'none',
              border: 'none',
              cursor: 'pointer',
              color: 'var(--lightgrey3)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            {showPassword ? <Eye size={20} /> : <EyeOff size={20} />}
          </button>
        </div>

        {/* Remember Me & Forgot Password */}
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            marginBottom: '30px',
          }}
        >
          <label
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
              cursor: 'pointer',
              fontSize: '13px',
              color: '#333333',
            }}
          >
            <input
              type="checkbox"
              checked={rememberMe}
              onChange={(e) => setRememberMe(e.target.checked)}
              style={{
                width: '18px',
                height: '18px',
                accentColor: 'var(--kprimary)',
                cursor: 'pointer',
              }}
            />
            remember me view
          </label>

          <button
            type="button"
            onClick={() => navigate('/forgetpassword')}
            style={{
              background: 'none',
              border: 'none',
              color: 'var(--kprimary)',
              fontSize: '12px',
              fontWeight: 600,
              cursor: 'pointer',
              padding: '4px',
            }}
          >
            Forget Your Password ?
          </button>
        </div>

        {/* Submit Button */}
        <button
          type="submit"
          disabled={!isFormValid || isLoading}
          style={{
            width: '100%',
            padding: '15px',
            backgroundColor: isFormValid ? 'var(--kprimary)' : '#A3B8B5',
            color: '#ffffff',
            fontSize: '16px',
            fontWeight: 600,
            borderRadius: '12px',
            border: 'none',
            cursor: isFormValid ? 'pointer' : 'not-allowed',
            transition: 'background-color 0.2s',
          }}
        >
          {isLoading ? 'Signing in...' : 'Log In'}
        </button>
      </form>

      {/* Footer Navigation */}
      <div
        style={{
          marginTop: 'auto',
          paddingTop: '24px',
          textAlign: 'center',
          fontSize: '14px',
        }}
      >
        <span style={{ color: 'var(--lightgrey2)' }}>Don’t have an account? </span>
        <button
          type="button"
          onClick={() => navigate('/register')}
          style={{
            background: 'none',
            border: 'none',
            color: 'var(--kprimary)',
            fontWeight: 700,
            cursor: 'pointer',
            padding: 0,
          }}
        >
          Sign up now
        </button>
      </div>
    </div>
  );
};
