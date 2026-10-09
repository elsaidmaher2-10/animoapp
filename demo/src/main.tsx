import React from 'react';
import ReactDOM from 'react-dom/client';
import { DemoProvider } from './bridge/DemoContext';
import { PhoneFrame } from './shell/PhoneFrame';
import { ControlPanel } from './shell/ControlPanel';

import './app/theme.css';
import './shell/shell.css';

const App: React.FC = () => {
  return (
    <DemoProvider>
      <main className="demo-container">
        <PhoneFrame />
        <ControlPanel />
      </main>
    </DemoProvider>
  );
};

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
