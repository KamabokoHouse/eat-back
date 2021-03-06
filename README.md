# For Development

## Env

| key | value |
| --- | --- |
| GOOGLE_API_PLACES_URL | [PlaceSearchRequestsURL](https://developers.google.com/places/web-service/search#PlaceSearchRequests) <br> e.g.: `https://maps.googleapis.com/maps/api/place/nearbysearch/json` |
| GOOGLE_API_PLACES_KEY | [Places API For Key](https://developers.google.com/places/web-service/get-api-key) <br> e.g.: `e5ae70ef¥43924f37_ab0dd14e087a6f40` |
| QUOTAGUARDSTATIC_URL | [QUOTAGUARD STATIC](https://elements.heroku.com/addons/quotaguardstatic) <br> e.g.: `http://username:pass@us-east-1-static-brooks.quotaguard.com:9293` |

## Build

```
docker-compose build
```

## Run

```
docker-compose up
```

e.g.: request

```
curl localhost:3000/restaurant?latitude=35.222514&longitude=139.888999
```

## Unit Test

```
bundle exec rspec -f d
```

## Integration test

```
git chekout dev

git merge <mybranch>

git push -f
```
