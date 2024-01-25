# Client search CLI app

Minimalist command line application built with ruby, using Thor for interface and params management. Tests are written using Rspec.

## Instalation
- Make sure you are using ruby 3.2.2, e.g ```rbenv local 3.2.2```
- Clone the repo and ```cd``` to it
- Run: ```bundle install```
- Play with it! Try typing ```thor list``` to see the list of available commands with examples and params usage

## About the app
- Main App or "entry point" is ```app.thor```. In it, you'll find the commands that compose the application: ```search``` and ```duplicated_items```.
- Search accepts the value to look up and an optional params to specify a different evaluating field for the dataset.
    - ```thor app:search "John Doe"``` will search for partial matches on full name for John Doe
    - ```thor app:search John``` will search for partial matches on full name for John, note that without spaces, the quotation marks can be omitted
    - ```thor app:search John email``` will search for matches on the email attribute
    - If an invalid atrribute is passed, you should see an error message (```thor app:search John invalid```)
    - The search is case insensitive
- Duplicated items returns the duplicated values by the specified field and returns the list of them.
    - ```thor app:duplicated_items``` returns the list of duplicated items by email
    - ```thor app:duplicated_items full_name``` returns the list of duplicated items by full name
    - If no duplicated items, you should see a message indicating that no duplicates were found

## TODO
- Add some schema validation for the json file, to ensure integrity for the dataset, using (https://github.com/voxpupuli/json-schema) for example
- Accept the lookup file via options, to give more flexibility
- Do more fun things, maybe load the .json to Elasticsearch and do some interesting queries
- Definitely add some factory for the specs
- Certainly, so much more that can be done xD!

## Final thoughts
Feel free to change the .json file and play with the app!
