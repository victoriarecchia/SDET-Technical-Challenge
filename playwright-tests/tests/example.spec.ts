import { test, expect } from '@playwright/test';
import dotenv from 'dotenv';
import path from 'path';

// Load environment variables from the .env file located in the test-data directory
dotenv.config({ path: path.resolve(__dirname, '../test-data/.env') });

// Helper function to get environment variables with error handling
function getEnv(name: string): string {
  const value = process.env[name];
  if (!value) throw new Error(`${name} not defined in .env`);
  return value;
}

// Retrieve admin credentials from environment variables
const ADMIN_USERNAME = getEnv('ADMIN_USERNAME');
const ADMIN_PASSWORD = getEnv('ADMIN_PASSWORD');

test.describe('Shady Meadows UI Tests', () => {
  
  test('1. Homepage Sanity', async ({ page }) => {
    //Navigate to the home page
    await page.goto('/');
    //Click on the "Contact" link in the navigation bar
    await page.locator('#navbarNav').getByRole('link', { name: 'Contact' }).click();
    //Assert that the "Contact" form is visible.
    await expect(page.getByText('Send Us a Message')).toBeVisible();
    //Verify that the "Book this room" buttons are present for the listed room types
    await expect(page.locator('#rooms').getByRole('link', { name: 'Book now' })).toHaveCount(3);
  });

  test('2. Admin Authentication & Dashboard', async ({ page }) => {
    //Navigate to the admin page
    await page.goto('/admin');
    //Enter with admin credentials
    await page.getByPlaceholder('Username').fill(ADMIN_USERNAME);
    await page.getByPlaceholder('Password').fill(ADMIN_PASSWORD);
    await page.getByRole('button', { name: 'Login' }).click();
    //Assert that the admin dashboard is displayed upon successful login
    await expect(page.getByText('Room details')).toBeVisible();
  });
});
