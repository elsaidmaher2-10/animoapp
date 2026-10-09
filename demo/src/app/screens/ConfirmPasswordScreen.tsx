import React, { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import { ChevronLeft, Eye, EyeOff, Check, X } from 'lucide-react';

export const ConfirmPasswordScreen: React.FC = () => {
  const { navigate, back, showQuickAlert, showToast } = useDemo();
  const [newPassword, setNewPassword] = useState('NewSecure123!@#');
  const [confirmPassword, setConfirmPassword] = useState('NewSecure123!@#');
  const [showPass, setShowPass] = useState(false);
  const [showConfirmPass, setShowConfirmPass] = useState(false);

  const ruleLen = newPassword.length >= 12;
  const ruleUpper = /[A-Z]/.test(newPassword);
  const ruleLower = /[a-z]/.test(newPassword);
  const ruleSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(newPassword);
  const ruleNumber = /[0-9]/.test(newPassword);
  const allRulesMet = ruleLen && ruleUpper && ruleLower && ruleSpecial && ruleNumber;

  const isMatch = newPassword === confirmPassword && confirmPassword.length > 0;
  const isFormValid = allRulesMet && isMatch;

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!isFormValid) {
      showToast('Please fulfill all password requirements and match passwords', 'error');
      return;
    }

    showQuickAlert({
      type: 'success',
      title: 'Password Updated',
      text: 'Your new password has been set successfully! Please log in with your new credentials.',
      confirmBtnText: 'Go to Login',
      onConfirm: () => {
        navigate('/Login');
      },
    });
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
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: '18px' }}>
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
          fontSize: '28px',
          fontWeight: 700,
          color: 'var(--kprimary)',
          marginBottom: '18px',
        }}
      >
        Create New Password
      </h1>

      <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '14px' }}>
        {/* New Password */}
        <div>
          <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
            New Password
          </label>
          <div style={{ position: 'relative', marginTop: '6px' }}>
            <input
              type={showPass ? 'text' : 'password'}
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              placeholder="********"
              style={{
                width: '100%',
                padding: '12px 42px 12px 14px',
                fontSize: '14px',
                border: '1.5px solid #E5E7EB',
                borderRadius: '12px',
                backgroundColor: '#FAFAFA',
              }}
            />
            <button
              type="button"
              onClick={() => setShowPass(!showPass)}
              style={{
                position: 'absolute',
                right: '12px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'none',
                border: 'none',
                cursor: 'pointer',
                color: 'var(--lightgrey3)',
              }}
            >
              {showPass ? <Eye size={18} /> : <EyeOff size={18} />}
            </button>
          </div>
        </div>

        {/* Live Password Rules */}
        <div
          style={{
            backgroundColor: '#F9FAFB',
            padding: '10px 12px',
            borderRadius: '10px',
            border: '1px solid #ECECEC',
          }}
        >
          <div
            style={{
              fontSize: '11px',
              fontWeight: 600,
              color: 'var(--lightgrey)',
              marginBottom: '6px',
            }}
          >
            Please add all necessary characters to create safe password:
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', fontSize: '11px' }}>
            <RuleRow satisfied={ruleLen} label="Minimum characters 12" />
            <RuleRow satisfied={ruleUpper} label="One uppercase character" />
            <RuleRow satisfied={ruleLower} label="One lowercase character" />
            <RuleRow satisfied={ruleSpecial} label="One special character" />
            <RuleRow satisfied={ruleNumber} label="One number" />
          </div>
        </div>

        {/* Confirm Password */}
        <div>
          <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
            Confirm Password
          </label>
          <div style={{ position: 'relative', marginTop: '6px' }}>
            <input
              type={showConfirmPass ? 'text' : 'password'}
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder="********"
              style={{
                width: '100%',
                padding: '12px 42px 12px 14px',
                fontSize: '14px',
                border: `1.5px solid ${
                  confirmPassword && !isMatch ? 'var(--red)' : '#E5E7EB'
                }`,
                borderRadius: '12px',
                backgroundColor: '#FAFAFA',
              }}
            />
            <button
              type="button"
              onClick={() => setShowConfirmPass(!showConfirmPass)}
              style={{
                position: 'absolute',
                right: '12px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'none',
                border: 'none',
                cursor: 'pointer',
                color: 'var(--lightgrey3)',
              }}
            >
              {showConfirmPass ? <Eye size={18} /> : <EyeOff size={18} />}
            </button>
          </div>
        </div>

        <button
          type="submit"
          disabled={!isFormValid}
          style={{
            marginTop: '20px',
            width: '100%',
            height: '46px',
            backgroundColor: isFormValid ? 'var(--kprimary)' : '#A3B8B5',
            color: '#ffffff',
            fontSize: '16px',
            fontWeight: 600,
            borderRadius: '12px',
            border: 'none',
            cursor: isFormValid ? 'pointer' : 'not-allowed',
          }}
        >
          Submit
        </button>
      </form>
    </div>
  );
};

const RuleRow: React.FC<{ satisfied: boolean; label: string }> = ({ satisfied, label }) => (
  <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
    {satisfied ? (
      <Check size={14} color="var(--green)" strokeWidth={3} />
    ) : (
      <X size={14} color="var(--lightgrey2)" strokeWidth={2.5} />
    )}
    <span
      style={{
        color: satisfied ? 'var(--green)' : 'var(--lightgrey2)',
        fontWeight: satisfied ? 600 : 400,
      }}
    >
      {label}
    </span>
  </div>
);
