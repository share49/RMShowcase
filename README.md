# RMShowcase

## Intro

This showcase project gets the Rick and Morty characters from rickandmortyapi.com and shows a view with all the information of the selected character.

## Technical considerations for scalability

- I created Request as a middle layer to have flexibility to customize requests, either by adding headers or extra parameters.
- Although ResponseErrorHelper only returns an error message, it's designed to be extensible to localize error messages, parse error codes, or provide additional information.

## Contributing

### Commit message structure

One commit message per line, prefixed with one of the following:
- `!` Fix for a bug or issue
- `+` A feature, file or something that was *added*
- `-` A feature, file or something that was *removed*
- `/` Change, changes or refactor

## Authors

Roger Pintó
