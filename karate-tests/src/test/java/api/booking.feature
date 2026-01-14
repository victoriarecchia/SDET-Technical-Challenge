    Feature: Booking creation
    # Goal: Create a new booking for a room and validate it

    Background:
        * url baseUrl
        * header Content-Type = 'application/json'

        # Function to generate a future date string in 'YYYY-MM-DD' format
        * def getFutureDate =
        """
        function(daysToAdd) {
        var date = new Date();
        date.setDate(date.getDate() + daysToAdd);
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);
        return year + '-' + month + '-' + day;
        }
        """

        # Function to generate random first/last names
        * def generateName =
        """
        function() {
        var cons = "bcdfghjklmnpqrstvwxyz";
        var vocs = "aeiou";
        var name = "";
        for (var i = 0; i < 3; i++) {
            name += cons.charAt(Math.floor(Math.random() * cons.length));
            name += vocs.charAt(Math.floor(Math.random() * vocs.length));
        }
        return name.charAt(0).toUpperCase() + name.slice(1);
        }
        """

    Scenario: Create a new booking successfully
        # Get a valid roomId first
        Given path '/room'
        When method GET
        Then status 200

        # Extract a random room ID
        * def roomsCount = response.rooms.length
        * def randomIndex = Math.floor(Math.random() * roomsCount)
        * def roomId = response.rooms[randomIndex].roomid
        # Generate random first and last names for the booking
        * def finalFirstname = generateName()
        * def finalLastname = generateName()

        # Generate safe checkin and checkout dates
        * def checkinDays = Math.floor(Math.random() * 30) + 1
        * def checkoutDays = checkinDays + Math.floor(Math.random() * 7) + 1
        * def checkin = getFutureDate(checkinDays)
        * def checkout = getFutureDate(checkoutDays)

        # Randomly decide if deposit is paid
        * def finalDepositPaid = Math.random() < 0.5

        # Create a new booking using the extracted roomId
        Given path '/booking'
        And request
        """
        {
            "roomid": #(roomId),
            "firstname": #(finalFirstname),
            "lastname": #(finalLastname),
            "depositpaid": #(finalDepositPaid),
            "bookingdates": {
            "checkin": #(checkin),
            "checkout": #(checkout)
            }
        }
        """
        When method POST
        Then status 201

        # Validate the response
        * match response.firstname == finalFirstname
        * match response.lastname == finalLastname
        * match response.depositpaid == '#boolean'
        * match response.roomid == roomId
        * match response.bookingdates.checkin == checkin
        * match response.bookingdates.checkout == checkout