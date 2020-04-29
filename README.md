# Curatorial

Curatorial is an artworks API. It was built with Ruby on Rails and seeded with artworks from Artsy's public API at the `/artworks` endpoint. Each artwork was then submitted to the Google Vision API to be analysed for its content. The response from Google Vision has been stored at the `/contents` endpoint. 

## Seeding the database
The database has been seeded through calls to [Artsy's Public API](https://developers.artsy.net/). Images were saved in an s3 bucket so they were able to be continually accessed by the app.

It was originally seeded with Harvard Art Museum's API, by running `Artwork.get_harvard_images(start_page, end_page)` from the console, replacing the `start` and `end` page with where the call should start and stop. It was changed to Artsy after this API structure change and image tags were no longer valid. 

Once the artwork has been successfully created, the `image_url` and the newly-created artwork's id is then automatically submitted to Google Vision API's through the method `Content.google_cloud_vision(artwork.image_url, artwork.id)`. Each image annotation returned from Google is stored as a `Content`, and the join, `ArtworkContent`, additionally stores the score, confidence and topicality alongside the foreign keys from `Artwork` and `Content`. 

There is a sleep timer of 5 seconds between each 'page' on the Harvard Art API so as not to overload it with requests. 

The database has then been dumped and imported into Heroku for the [online demo](https://curatorial-app.herokuapp.com/). These seeds can be imported locally using the file `curatorial_seeds.dump`. There is also a [video demo of the original app in use](https://youtu.be/5UTHCuM9oL0).

## Key User Stories
Users can view search for and view artworks without creating an account. By signing up, users can save artworks to exhibitions that they create (by ticking it as 'public' it will appear on /exhibitions). Other users can 'like' the exhibition which will save onto their user dashboard (one or more likes gives it the 'popular' flag on the exhibitions index page). 

Users are also able to follow other users. By following another user, each time an exhibition is made it will appear on your user dashboard.

## Curatorial_backend

* Ruby version ruby-2.6.1

