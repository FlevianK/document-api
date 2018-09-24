# Documents APIs

Documents APIs is a simple document lists allows consumers to perform CRUD operations on document lists.
User can also add reviews and perform CRUD operations on them too.

## API Features

  1. User authentication with [JWT](http://jwt.io).
  2. User can perform CRUD operations on document lists and reviews resources
  3. API accepts paginated requests with page and limit e.g. `/documents?limit=10&page=1`

### Dependencies

  1. [Ruby](https://github.com/rbenv/rbenv)
  2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
  3. [Bundler](http://bundler.io/)
  4. [Ruby on Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
  5. [RSpec](http://rspec.info/)


## Getting Started

    1. git clone https://github.com/FlevianK/document-api.git

    2. cd document-api

    3. bundle install

    4. rails db:setup

    5. rails server


## Tests
    1. cd document-api
    2. rspec

## API Endpoints

All endpoints except `/signup` and `/login` require a token for `Authorization`, failure to which the API will return the error.

    {
        "message": "Missing token"
    }

An `Authorization` token looks like this

      {
        auth_token: "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1Mzc4OTc1NTd9.V3Z7AQEguUDLCoFEp1I1jQrjmJbm-LgV_ySmK6ymuS4"
    }

| EndPoint                                    |   Functionality                             |
| ------------------------------------------- | -------------------------------------------:|
| POST /signup                                | Signup a user                               |
| POST /login                                 | Login user                                  |
| POST /documents/                            | Create a new document list                  |
| GET /documents/                             | List all the created document lists         |
| GET /documents?page=1&limit=10              | List ten documents from page 1              |
| GET /documents/:document_id                 | Get single document list                    |
| PUT /documents/:document_id                 | Update this document list                   |
| DELETE /documents/:document_id              | Delete this single document list            |
| GET /documents/:document_id/reviews/        | List all created reviews in a document list |
| GET /documents/:document_id/reviews/:id     | Get a single review in a document           |
| PUT /documents/:document_id/reviews/        | Create a new review in document list        |
| PUT /documents/:document_id/reviews/:id     | Update a documentlist review                |
| DELETE /documents/:document_id/reviews/:id  | Delete an review in a document lists        |


## Limitations

  1. The API only responds with JSON

## Author
  1. Flevian Kanaiza
