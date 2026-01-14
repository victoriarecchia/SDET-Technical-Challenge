Feature: Room Inventory
    # Goal: Retrieve the list of available rooms.
  Background:
    * url baseUrl

  Scenario: Get All Rooms and Validate Price
    # Expectation: Verify the response is an array and that at least one room exists with a roomPrice greater than 0.
    Given path '/room'
    When method GET
    Then status 200
    And match response.rooms == '#[]'
    And match each response.rooms contains { roomPrice: '#? _ > 0' }