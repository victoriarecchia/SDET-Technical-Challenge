Feature: Branding Verification
    # Goal: Validate that the B&B branding information (name, contact details, and descriptions) is returning correctly.

  Background:
    * url baseUrl

  Scenario: Verify branding name and contact email
    # Expectation: Verify that the name field is exactly "Shady Meadows B&B" and that the contact email matches a valid email regex.
    Given path '/branding'
    When method GET
    Then status 200
    And match response.name == 'Shady Meadows B&B'
    And match response.contact ==
    """
    {
    name: '#string',
    phone: '#string',
    email: '#regex ^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$'
    }
    """

