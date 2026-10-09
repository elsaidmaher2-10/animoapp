import React from 'react';
import { useDemo } from '../bridge/DemoContext';
import { StatusBar } from './StatusBar';
import { DynamicIsland } from './DynamicIsland';
import { NotificationBanner } from './NotificationBanner';
import { LockScreen } from './LockScreen';
import { QuickAlertModal } from '../app/components/QuickAlertModal';
import { ImagePickerSheet } from '../app/components/ImagePickerSheet';
import { ToastSnackbar } from '../app/components/ToastSnackbar';

import { MainScreen } from '../app/screens/MainScreen';
import { SeeAllScreen } from '../app/screens/SeeAllScreen';
import { LoginScreen } from '../app/screens/LoginScreen';
import { RegisterScreen } from '../app/screens/RegisterScreen';
import { ForgotPasswordScreen } from '../app/screens/ForgotPasswordScreen';
import { OtpScreen } from '../app/screens/OtpScreen';
import { ConfirmPasswordScreen } from '../app/screens/ConfirmPasswordScreen';

export const PhoneFrame: React.FC = () => {
  const { currentRoute, frameColor, zoom, navigate } = useDemo();

  const renderActiveScreen = () => {
    switch (currentRoute) {
      case '/':
        return <MainScreen />;
      case '/SeeAll':
        return <SeeAllScreen />;
      case '/Login':
        return <LoginScreen />;
      case '/register':
        return <RegisterScreen />;
      case '/forgetpassword':
        return <ForgotPasswordScreen />;
      case '/optverivication':
        return <OtpScreen />;
      case '/ConfirmPassword':
        return <ConfirmPasswordScreen />;
      default:
        return (
          <div
            style={{
              padding: '80px 24px',
              textAlign: 'center',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              gap: '16px',
            }}
          >
            <h3>Route not available in demo: {currentRoute}</h3>
            <button
              onClick={() => navigate('/')}
              style={{
                padding: '10px 18px',
                backgroundColor: 'var(--kprimary)',
                color: '#fff',
                border: 'none',
                borderRadius: '8px',
                cursor: 'pointer',
              }}
            >
              Return Home
            </button>
          </div>
        );
    }
  };

  return (
    <div
      className="phone-viewport-container"
      style={{
        transform: `scale(${zoom})`,
      }}
    >
      <div className={`iphone-frame ${frameColor}`}>
        {/* Hardware Side Buttons */}
        <div className="side-button action" />
        <div className="side-button vol-up" />
        <div className="side-button vol-down" />
        <div className="side-button power" />

        {/* High Resolution Screen */}
        <div className="phone-screen">
          {/* iOS Status Bar */}
          <StatusBar isDarkContent={true} />

          {/* Interactive Dynamic Island */}
          <DynamicIsland />

          {/* Slide-down Push Notification Banner */}
          <NotificationBanner />

          {/* iOS Lock Screen Overlay */}
          <LockScreen />

          {/* Active Screen Render */}
          <div style={{ flex: 1, position: 'relative', overflow: 'hidden' }}>
            {renderActiveScreen()}
          </div>

          {/* Simulated Native Sheets & Modals */}
          <ImagePickerSheet />
          <QuickAlertModal />
          <ToastSnackbar />

          {/* Home Indicator */}
          <div className="home-indicator-bar" />
        </div>
      </div>
    </div>
  );
};
