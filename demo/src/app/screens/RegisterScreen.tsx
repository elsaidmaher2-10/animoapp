import React, { useState } from 'react';
import { useDemo } from '../../bridge/DemoContext';
import logoSvg from '../assets/logo.svg';
import subtractIcon from '../assets/Subtract.png';
import { Check, X, Eye, EyeOff, ChevronLeft } from 'lucide-react';

export const RegisterScreen: React.FC = () => {
  const { navigate, back, openImagePicker, showToast } = useDemo();

  const [fname, setFname] = useState('Ahmed');
  const [lname, setLname] = useState('El-said');
  const [email, setEmail] = useState('ahmed.elsaid@example.com');
  const [phone, setPhone] = useState('+201012345678');
  const [password, setPassword] = useState('SecurePass123!');
  const [confirmPassword, setConfirmPassword] = useState('SecurePass123!');
  const [showPass, setShowPass] = useState(false);
  const [showConfirmPass, setShowConfirmPass] = useState(false);
  const [image, setImage] = useState<string | null>(null);

  // 5 Password Rules from constantsmanager.dart:
  // 1. Minimum characters 12
  // 2. One uppercase character
  // 3. One lowercase character
  // 4. One special character
  // 5. One number
  const ruleLen = password.length >= 12;
  const ruleUpper = /[A-Z]/.test(password);
  const ruleLower = /[a-z]/.test(password);
  const ruleSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
  const ruleNumber = /[0-9]/.test(password);
  const allRulesMet = ruleLen && ruleUpper && ruleLower && ruleSpecial && ruleNumber;

  const isPasswordMatch = password === confirmPassword && confirmPassword.length > 0;
  const isFormValid =
    fname.trim().length > 0 &&
    lname.trim().length > 0 &&
    email.includes('@') &&
    phone.trim().length >= 8 &&
    allRulesMet &&
    isPasswordMatch &&
    image !== null;

  const handlePickImage = () => {
    openImagePicker((selectedUrl) => {
      setImage(selectedUrl);
      showToast('Profile image selected', 'success');
    });
  };

  const handleSignUp = (e: React.FormEvent) => {
    e.preventDefault();
    if (!image) {
      showToast('Please upload a profile photo', 'error');
      return;
    }
    if (!allRulesMet) {
      showToast('Please satisfy all password security rules', 'error');
      return;
    }
    if (!isPasswordMatch) {
      showToast('Passwords do not match', 'error');
      return;
    }

    // Go to OTP verification screen with arguments matching Flutter:
    navigate('/optverivication', { email, screen: 'signup' });
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
        overflowY: 'auto',
      }}
    >
      {/* Top Bar with Back Button */}
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: '8px' }}>
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

      {/* Header */}
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          marginBottom: '20px',
        }}
      >
        <img
          src={logoSvg}
          alt="ANIMOOO"
          style={{ width: '60px', height: '60px', objectFit: 'contain' }}
        />
        <div
          style={{
            fontFamily: 'var(--font-original-surfer)',
            fontSize: '11px',
            color: 'var(--kprimary)',
            marginTop: '2px',
          }}
        >
          ANIMOOO
        </div>
        <h1
          style={{
            fontFamily: 'var(--font-otama)',
            fontSize: '32px',
            fontWeight: 600,
            color: 'var(--kprimary)',
            marginTop: '4px',
          }}
        >
          Sign Up
        </h1>
      </div>

      <form onSubmit={handleSignUp} style={{ display: 'flex', flexDirection: 'column', gap: '14px' }}>
        {/* First & Last Name */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px' }}>
          <div>
            <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
              First Name
            </label>
            <input
              type="text"
              value={fname}
              onChange={(e) => setFname(e.target.value)}
              placeholder="First Name"
              style={{
                width: '100%',
                padding: '12px 14px',
                fontSize: '14px',
                border: '1.5px solid #E5E7EB',
                borderRadius: '10px',
                backgroundColor: '#FAFAFA',
                marginTop: '4px',
              }}
            />
          </div>
          <div>
            <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
              Last Name
            </label>
            <input
              type="text"
              value={lname}
              onChange={(e) => setLname(e.target.value)}
              placeholder="Last Name"
              style={{
                width: '100%',
                padding: '12px 14px',
                fontSize: '14px',
                border: '1.5px solid #E5E7EB',
                borderRadius: '10px',
                backgroundColor: '#FAFAFA',
                marginTop: '4px',
              }}
            />
          </div>
        </div>

        {/* Email */}
        <div>
          <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
            Email
          </label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Enter your email address"
            style={{
              width: '100%',
              padding: '12px 14px',
              fontSize: '14px',
              border: '1.5px solid #E5E7EB',
              borderRadius: '10px',
              backgroundColor: '#FAFAFA',
              marginTop: '4px',
            }}
          />
        </div>

        {/* Phone */}
        <div>
          <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
            Phone
          </label>
          <input
            type="tel"
            value={phone}
            onChange={(e) => setPhone(e.target.value)}
            placeholder="Enter your Phone"
            style={{
              width: '100%',
              padding: '12px 14px',
              fontSize: '14px',
              border: '1.5px solid #E5E7EB',
              borderRadius: '10px',
              backgroundColor: '#FAFAFA',
              marginTop: '4px',
            }}
          />
        </div>

        {/* Password */}
        <div>
          <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
            Password
          </label>
          <div style={{ position: 'relative', marginTop: '4px' }}>
            <input
              type={showPass ? 'text' : 'password'}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="********"
              style={{
                width: '100%',
                padding: '12px 42px 12px 14px',
                fontSize: '14px',
                border: '1.5px solid #E5E7EB',
                borderRadius: '10px',
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

        {/* Live Password Rules from constantsmanager.dart */}
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
              fontSize: '11.5px',
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
          <div style={{ position: 'relative', marginTop: '4px' }}>
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
                  confirmPassword && !isPasswordMatch ? 'var(--red)' : '#E5E7EB'
                }`,
                borderRadius: '10px',
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

        {/* Upload Image Box */}
        <div style={{ marginTop: '4px' }}>
          <label style={{ fontSize: '14px', color: 'var(--lightgrey)', fontWeight: 500 }}>
            Profile Photo
          </label>
          <div
            onClick={handlePickImage}
            style={{
              marginTop: '6px',
              border: '2px dashed #CBD5E1',
              borderRadius: '12px',
              padding: '16px',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              justifyContent: 'center',
              cursor: 'pointer',
              backgroundColor: '#F8FAFC',
              transition: 'background-color 0.2s',
            }}
          >
            {image ? (
              <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                <img
                  src={image}
                  alt="Avatar"
                  style={{
                    width: '54px',
                    height: '54px',
                    borderRadius: '50%',
                    objectFit: 'cover',
                    border: '2px solid var(--kprimary)',
                  }}
                />
                <span style={{ fontSize: '13px', color: 'var(--kprimary)', fontWeight: 600 }}>
                  Change Image
                </span>
              </div>
            ) : (
              <>
                <img
                  src={subtractIcon}
                  alt="Upload"
                  style={{ width: '28px', height: '28px', opacity: 0.7, marginBottom: '6px' }}
                />
                <span style={{ fontSize: '13px', color: 'var(--lightgrey2)' }}>
                  Tap to upload profile picture
                </span>
              </>
            )}
          </div>
        </div>

        {/* Sign Up Button */}
        <button
          type="submit"
          disabled={!isFormValid}
          style={{
            marginTop: '10px',
            width: '100%',
            padding: '14px',
            backgroundColor: isFormValid ? 'var(--kprimary)' : '#A3B8B5',
            color: '#ffffff',
            fontSize: '15px',
            fontWeight: 600,
            borderRadius: '10px',
            border: 'none',
            cursor: isFormValid ? 'pointer' : 'not-allowed',
          }}
        >
          Sign Up
        </button>
      </form>

      {/* Footer */}
      <div style={{ textAlign: 'center', marginTop: '18px', fontSize: '13px' }}>
        <span style={{ color: 'var(--lightgrey2)' }}>Already have an account? </span>
        <button
          type="button"
          onClick={() => navigate('/Login')}
          style={{
            background: 'none',
            border: 'none',
            color: 'var(--kprimary)',
            fontWeight: 700,
            cursor: 'pointer',
          }}
        >
          Log In
        </button>
      </div>
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
