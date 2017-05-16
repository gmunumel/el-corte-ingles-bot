# README

This project is for run a selenium script to retrieve information regarding discount in 
el corte ingles page. The script will be schedule to be execute every hour using sidekiq 
and sidekiq-scheduler gems. If its execution found useful information will be stored in a 
Product database and will be schedule to be send via email using sidekiq again. 

For send email we use gmail smtp server. Would be better configured mail trap or another
mail testing service (TODO).

To run the app:

* Run Redis server
```
redis-server
```

* Run Rails server
```
rails s
```

* Run Sidekiq
```
bundle exec sidekiq -q default -q mailers
```

* For testing purposes, send email via `rails console` 
```ruby
NotificationMailer.mailer('Bugs').deliver_later
```

* To add to queue stack
```
sidekiq -r ./app/jobs/check_discount_job.rb
```

* To run the queues jobs 
```ruby
bundle exec sidekiq -q default -q mailers
```

