const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  // Create a dummy user for the registration check
  await page.evaluate(() => {
    localStorage.setItem('mission_users', JSON.stringify([{
      email: 'test@example.com',
      password: 'test'
    }]));
  });

  await page.goto('file://' + process.cwd() + '/login.html');

  console.log("Checking login error...");
  await page.fill('#login-email', 'wrong@example.com');
  await page.fill('#login-pwd', 'wrong');
  await page.click('#login-form button[type="submit"]');
  const loginError = await page.locator('#login-error').getAttribute('aria-live');
  console.log("Login error aria-live attribute:", loginError);

  console.log("Checking signup error...");
  await page.evaluate(() => switchTab('signup'));
  await page.fill('#reg-name', 'Test User');
  await page.fill('#reg-email', 'test@example.com');
  await page.fill('#reg-pwd', 'test');
  await page.fill('#reg-loc', 'Test City');
  await page.selectOption('#reg-role', 'Both');
  await page.click('#signup-form button[type="submit"]');
  const signupError = await page.locator('#signup-error').getAttribute('aria-live');
  console.log("Signup error aria-live attribute:", signupError);

  await browser.close();
})();
