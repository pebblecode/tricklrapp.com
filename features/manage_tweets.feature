Feature: Manage Statues
    In order to enter statuses into Tricklr
    As a Tricklr user
    I want to view and manage statuses

    Background:
        Given I am logged into Tricklr

    Scenario: Adding a new statuse to the queue
        When I go to the homepage
        And I fill in "Status" with "buildin da internetz"
        And I press "Trickle it!"
        Then I should see "Hurray! Your tweet was scheduled for delivery"
        And I should see "buildin da internetz"

    Scenario: Viewing queued statuses
        Given there are queued statuses of "can haz cheezburger?, oh hai"
        When I go to the homepage
        Then I should see "can haz cheezburger?"
        And I should see "oh hai"

    Scenario: Viewing published statuses
        Given there are published statuses of "I'm in ur computer testin ur app, can haz fish plz?"
        When I go to the published page
        Then I should see "I'm in ur computer testin ur app"
        And I should see "can haz fish plz?"
