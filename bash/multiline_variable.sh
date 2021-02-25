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
