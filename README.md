# Curatorial

Curatorial is an artworks API. It was built with Ruby on Rails and seeded with artworks from the Harvard Art Museum's API at the `/artworks` endpoint. Each artwork was then submitted to the Google Vision API to be analysed for its content. The response from Google Vision has been stored at the `/contents` endpoint. 

## Seeding the database
The database has been seeded through calls to Harvard Art Museum's API, by running `Artwork.get_harvard_images(start_page, end_page)` from the console, replacing the `start` and `end` page with where you would like to start and stop. Once the artwork has been successfully created, the `image_url` and the newly-created artwork's id is then automatically submitted to Google Vision API's through the method `Content.google_cloud_vision(artwork.image_url, artwork.id)`. Each image annotation returned from Google is stored as a `Content`, and the join, `ArtworkContent`, additionally stores the score, confidence and topicality alongside the foreign keys from `Artwork` and `Content`. 

There is a sleep timer of 5 seconds between each 'page' on the Harvard Art API so as not to overload it with requests. 

The database has then been dumped and imported into Heroku. 

## Key User Stories


## Curatorial_backend

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

