# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Challenge Summary

St Charles Automotive would like to begin taking service reservations over the phone. Their current software does not allow them to capture all of the information in a single step, so would like to build a custom solution.


## Requirements

Construct a simple reservation API, that allows an agent to capture customer information, vehicle information, and secure a time slot. Feel free to use any gems that compliment your solution. Additionally include a readme file in your delivery, should include instructions on how to setup and run your project and unit tests that demonstrate functionality.

You do not need to construct a UI, this is intended to be an assessment of your back end skills. As for time commitment, we will leave that up to you. Please deliver a solution in a zipped folder to us when you finish.

We are leaving the details intentionally vague, curious to see the assumptions you make and how you interpret the requirements.

- VehicleReservation
- Agent
- Customer
- Vehicle

--------------

An agent is going to submit a post request to the API with the time of the reservation, the vehicle information and the custom information. With this, if there is an spot available secure the spot.

- Endpoint to reserve a time.
- Endpoint to retrieve reservations by user's email.
- API authentication will be the agent code. If no agent is found with the agent code sent. The API will give an unathorization header.

- Dont forget the seeder
- Don't forget the rspecs