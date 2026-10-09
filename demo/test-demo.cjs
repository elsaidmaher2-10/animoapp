const { chromium } = require('playwright');
const path = require('path');
const fs = require('fs');

async function run() {
  const screenshotDir = path.join(__dirname, 'screenshots');
  if (!fs.existsSync(screenshotDir)) {
    fs.mkdirSync(screenshotDir, { recursive: true });
  }

  console.log('Launching browser...');
  const browser = await chromium.launch({ headless: true, channel: 'msedge' });

  const contextDesktop = await browser.newContext({
    viewport: { width: 1440, height: 900 },
  });
  const page = await contextDesktop.newPage();

  const errors = [];
  page.on('console', (msg) => {
    if (msg.type() === 'error') {
      errors.push(`Console Error: ${msg.text()}`);
    }
  });
  page.on('pageerror', (err) => {
    errors.push(`Page Error: ${err.message}`);
  });

  console.log('Navigating to http://localhost:8080/ ...');
  await page.goto('http://localhost:8080/', { waitUntil: 'networkidle' });

  console.log('Taking desktop screenshot...');
  await page.screenshot({ path: path.join(screenshotDir, '01_desktop_home.png') });

  // Test triggering a notification
  console.log('Triggering notification...');
  const notifBtn = page.locator('button:has-text("🐾 New Animal Listed!")');
  if (await notifBtn.count() > 0) {
    await notifBtn.click();
    await page.waitForTimeout(600);
    await page.screenshot({ path: path.join(screenshotDir, '02_notification_banner.png') });
  }

  // Test deep link to See All
  console.log('Clicking Categories (See All)...');
  const seeAllChip = page.locator('button:has-text("🗂️ Categories (See All)")');
  if (await seeAllChip.count() > 0) {
    await seeAllChip.click();
    await page.waitForTimeout(400);
    await page.screenshot({ path: path.join(screenshotDir, '03_see_all_categories.png') });
  }

  // Test deep link to Login
  console.log('Clicking Login...');
  const loginChip = page.locator('button:has-text("🔑 Login Screen")');
  if (await loginChip.count() > 0) {
    await loginChip.click();
    await page.waitForTimeout(400);
    await page.screenshot({ path: path.join(screenshotDir, '04_login_screen.png') });
  }

  // Test deep link to Sign Up
  console.log('Clicking Sign Up...');
  const regChip = page.locator('button:has-text("📝 Sign Up Screen")');
  if (await regChip.count() > 0) {
    await regChip.click();
    await page.waitForTimeout(400);
    await page.screenshot({ path: path.join(screenshotDir, '05_signup_screen.png') });
  }

  // Test deep link to OTP
  console.log('Clicking OTP...');
  const otpChip = page.locator('button:has-text("🔢 OTP Screen")');
  if (await otpChip.count() > 0) {
    await otpChip.click();
    await page.waitForTimeout(400);
    await page.screenshot({ path: path.join(screenshotDir, '06_otp_screen.png') });
  }

  // Test Lock Screen
  console.log('Testing Lock Screen...');
  const lockBtn = page.locator('button:has-text("Lock Phone")');
  if (await lockBtn.count() > 0) {
    await lockBtn.click();
    await page.waitForTimeout(400);
    await page.screenshot({ path: path.join(screenshotDir, '07_lock_screen.png') });
    // Unlock
    const unlockBtn = page.locator('button:has-text("Unlock Phone")');
    if (await unlockBtn.count() > 0) {
      await unlockBtn.click();
      await page.waitForTimeout(400);
    }
  }

  // Mobile viewport screenshot (390x844)
  console.log('Testing mobile viewport 390x844...');
  const contextMobile = await browser.newContext({
    viewport: { width: 390, height: 844 },
  });
  const pageMobile = await contextMobile.newPage();
  await pageMobile.goto('http://localhost:8080/', { waitUntil: 'networkidle' });
  await pageMobile.screenshot({ path: path.join(screenshotDir, '08_mobile_view.png') });

  await browser.close();

  console.log('All tests finished!');
  if (errors.length > 0) {
    console.error('Errors found:', errors);
    process.exit(1);
  } else {
    console.log('No console or page errors detected! 100% clean!');
    process.exit(0);
  }
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});
