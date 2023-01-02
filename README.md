# RMShowcase

## Intro

This showcase project gets the Rick and Morty characters from rickandmortyapi.com and shows a view with all the information of the selected character. It is also possible to search for a specific character.

## Technical considerations for scalability

In this project, I chose an MVVM-C architecture with Constructor-based Dependency Injection for testing purposes. Although the coordinator is not used in this demo project, it may need to handle some navigation interactions that SwiftUI cannot handle at this time.

- I created Request as a middle layer to have flexibility to customize requests, either by adding headers or extra parameters.
- Although ResponseErrorHelper only returns an error message, it is designed to be extensible to localize error messages, parse error codes, or provide additional information.
- I use a View extension to set the text's font style in one place for easy maintenance and making changes.

## Possible improvements

- Unit test remaining parts.
- Retry network requests once on failure.
- Improve the UI.

## Contributing

### Commit message structure

One commit message per line, prefixed with one of the following:
- `!` Fix for a bug or issue
- `+` A feature, file or something that was *added*
- `-` A feature, file or something that was *removed*
- `/` Change, changes or refactor

## Authors

Roger Pintó
