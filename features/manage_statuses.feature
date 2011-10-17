Feature: Manage Statues
    In order to enter tweets into Tricklr
    As a Tricklr user
    I want to view and manage tweets

    Background:
        Given I have authenticated against Twitter

    Scenario: Adding a new tweet to the queue
        When I go to the homepage
        And I fill in "status[status]" with "buildin da internetz"
        And I press "Trickle it!"
        Then I should see "Hurray! Your tweet was scheduled for delivery"
        And I should see "buildin da internetz"

    Scenario: Viewing queued tweets
        Given the user "shapeshed" has queued tweets of "can haz cheezburger?, oh hai"
        When I go to the homepage
        Then I should see "can haz cheezburger?"
        And I should see "oh hai"

    Scenario: Viewing published tweets
        Given the user "shapeshed" has published tweets of "I'm in ur computer testin ur app, can haz fish plz?"
        When I go to the published page
        Then I should see "I'm in ur computer testin ur app"
        And I should see "can haz fish plz?"

    Scenario: Deleting a queued tweets
        Given the user "shapeshed" has queued tweets of "plz delete thnx"
        When I go to the homepage
        Then I should see "plz delete thnx"
        And I press "Destroy"
        Then I should see "Gone! Your tweet is no more"
        And I should not see "plz delete thnx"

    Scenario: Editing a queued tweets
        Given the user "shapeshed" has queued tweets of "edit me thnx"
        When I go to the homepage
        Then I should see "edit me thnx"
        And I follow "Edit"
        And I fill in "status[status]" with "ok we iz edited"
        And I press "Trickle it"
        Then I should see "Your tweet was updated"
        And I should not see "edit me thnx"
        And I should see "ok we iz edited"

