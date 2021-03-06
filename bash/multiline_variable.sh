#!/bin/bash

read RAW <<EOD
{
    "url": "https://www.google.de",
    "value": 42
}
EOD

echo $RAW;

read -r -d '' DATA <<EOD
{
	"url": "https://www.google.de",
	"value": 42
}
EOD

echo $DATA;

read -r -d '' DATA <<EOD
{
  "token": "sdad9asd7as8d7as7d676as766ef76sf"
}
EOD

echo $DATA;

read -d '' RAW <<EOD
{
 "token": "asdasd9a)=Sd=87a8c78sC"
}
EOD

echo $RAW;

curl -q -XGET "https://swapi.dev/api/people/1"
