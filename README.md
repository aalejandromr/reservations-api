# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 3.2.1

* Rails version: 7.0.8

* Database used is postgres. Ideally PG v14.

## Installation steps
- `cd reservations-api-main`
- `bundle install`
- `rake db:create`
- `rake db:migrate`
- `rake db:seed`
- `bundle exec rspec`
- `rails s`

## Challenge Summary

Construct a simple reservation API, that allows an agent to capture customer information, vehicle information, and secure a time slot. Feel free to use any gems that compliment your solution. Additionally include a readme file in your delivery, should include instructions on how to setup and run your project and unit tests that demonstrate functionality.

You do not need to construct a UI, this is intended to be an assessment of your back end skills. As for time commitment, we will leave that up to you. Please deliver a solution in a zipped folder to us when you finish.

We are leaving the details intentionally vague, curious to see the assumptions you make and how you interpret the requirements.

## Supported vehicle makes and models

I thought it would be fun to add some restrictions to this API and prevent requests from getting weird vehicle models and vehicle manufactures so I'm using this faker datasets for vehicle makes and models as a source of thruth. https://github.com/faker-ruby/faker/blob/main/lib/locales/en/vehicle.yml#L123

This API only supports makes defined in the `models_by_make` section and their corresponding models just for fun and to incorporate the idea that we will still need to make sure we don't receive bad data in the params.

## Agents and agent codes

In order to add some sort of authentication I decided to incorporate the idea of `agent_code` in the Agent model. This serves as an authentication layer and will only process requests of valid agents and their agent codes. You can pass this as a query parameteres. Ex: `http::localhost:3000/api/v1/reservations?agent_code=28392`

In the seeder there are 2 agents created. You can find an already existing valid agent code in seeds.rb:4

## Business hours

I also thought that `St Charles Automotive` will not be working 24/7 so I made the business hours to be Mon - Sunday from 8AM to 5PM

## Overlapping reservations

I created the constraint that a reservation cannot be created if another reservation already exists during the time the new reservation wants to be created. For instance if a reservation was created to be from 1 PM to 2 PM then another reservation cannot be created to start at 1:30 PM because the other reservation is still going.

## Seeder

All data required to run the API is already created for you. Please refer to the seeds.rb file if you have questions related to the data.

For initial API interactions you can find a valid agent code there as well as a customer email valid.

## Documentation

The documentation for this API can be found here https://documenter.getpostman.com/view/30658761/2s9YRCVAco