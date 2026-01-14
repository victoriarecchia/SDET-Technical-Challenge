# SDET Technical Challenge: Shady Meadows B&B

This repository contains the automated test suite for the **Shady Meadows B&B** platform. The project is divided into two main layers: API testing using **Karate DSL** and UI testing using **Playwright**.

--
## Tech Stack
* **API Automation:** [Karate DSL](https://karatelabs.io/) 
* **UI Automation:** [Playwright](https://playwright.dev/) (TypeScript).
* **Target Site:** [Automation in Testing Online](https://automationintesting.online/)
---

# API Tests (Karate)
Navigate to the API directory and run the tests:
  cd karate-test
  mvn test

# UI Tests (Playwright)
Navigate to the UI directory, install dependencies, and run:
  cd playwright-tests
  npm install
  npx playwright install
  npx playwright test
Reports: View the interactive report using:
npx playwright show-report
