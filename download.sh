# temporary file to store results, for history update to be atomic
tempFile=$(mktemp)

# define an error handler function
error_handler() {
  echo "${RED}An error occurred. Exiting.${NC}"
  rm -f "$tempFile"
  exit 1
}
set -o pipefail # need to catch errors from piped commands
trap error_handler ERR # call error_handler when an error occurs

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

downloadDate=$(date +"%Y-%m-%dT%H:%M:%S%z")

make_request() {
  local page=$1
  local modelName=$2
  local jsonRequest=$3

  curl -d "{\"page\":${page},\"properties\":${jsonRequest},\"sorting\":1}" \
  -H "Host: api.av.by" \
  -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:136.0) Gecko/20100101 Firefox/136.0" \
  -H "Accept: */*" \
  -H "Accept-Language: en-US,en;q=0.5" \
  -H "Accept-Encoding: gzip, deflate, br, zstd" \
  -H "Referer: https://cars.av.by/" \
  -H "x-device-type: web.desktop" \
  -H "Content-Type: application/json" \
  -H "Origin: https://cars.av.by" \
  -H "Connection: keep-alive" \
  -H "Sec-Fetch-Dest: empty" \
  -H "Sec-Fetch-Mode: cors" \
  -H "Sec-Fetch-Site: same-site" \
  -H "Priority: u=0" \
  -H "TE: trailers" \
  -X POST \
  'https://api.av.by/offer-types/cars/filters/main/apply' | \
  gunzip - | \
  jq --arg date "$downloadDate" --arg model "${modelName}" \
  -c '.adverts[] | . + {downloadDate: $date, model: $model}' >> "$tempFile"
}

# BMW F34
bmw_f34_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 8
        },
        {
          "name": "model",
          "value": 5863
        },
        {
          "name": "generation",
          "value": 12822
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  }
]'
make_request 1 "BMW F34" "${bmw_f34_request}"
make_request 2 "BMW F34" "${bmw_f34_request}"

# AUDI A4 B6
audi_a4_b6_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 6
        },
        {
          "name": "model",
          "value": 5810
        },
        {
          "name": "generation",
          "value": 4299
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  },
  {
    "name": "body_type",
    "value": [5]
  }
]'
make_request 1 "AUDI A4 B6" "${audi_a4_b6_request}"
make_request 2 "AUDI A4 B6" "${audi_a4_b6_request}"
make_request 3 "AUDI A4 B6" "${audi_a4_b6_request}"
make_request 4 "AUDI A4 B6" "${audi_a4_b6_request}"
make_request 5 "AUDI A4 B6" "${audi_a4_b6_request}"
make_request 6 "AUDI A4 B6" "${audi_a4_b6_request}"

# VOLVO XC60 I
volvo_xc60_i_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 1238
        },
        {
          "name": "model",
          "value": 2098
        },
        {
          "name": "generation",
          "value": 2780
        }
      ]
    ]
  },
  {
    "name": "year",
    "value": {
      "max": null,
      "min": 2014
    }
  },
  {
    "name": "price_currency",
    "value": 2
  },
  {
    "name": "engine_capacity",
    "value": {
      "max": 2400,
      "min": 2400
    }
  },
  {
    "name": "engine_type",
    "value": [
      5
    ]
  }
]'
make_request 1 "VOLVO XC60 I" "${volvo_xc60_i_request}"
make_request 2 "VOLVO XC60 I" "${volvo_xc60_i_request}"

# Ford S-MAX I
ford_smax_i_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 330
        },
        {
          "name": "model",
          "value": 1949
        },
        {
          "name": "generation",
          "value": 755
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  }
]'
make_request 1 "Ford S-MAX I" "${ford_smax_i_request}"
make_request 2 "Ford S-MAX I" "${ford_smax_i_request}"
make_request 3 "Ford S-MAX I" "${ford_smax_i_request}"
make_request 4 "Ford S-MAX I" "${ford_smax_i_request}"

# Kia Carnival III
kia_carnival_iii_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 545
        },
        {
          "name": "model",
          "value": 550
        },
        {
          "name": "generation",
          "value": 3805
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  }
]'
make_request 1 "Kia Carnival III" "${kia_carnival_iii_request}"
make_request 2 "Kia Carnival III" "${kia_carnival_iii_request}"

# Subaru Impreza III
subaru_impreza_iii_request='[
	{
		"name": "brands",
		"property": 6,
		"value": [
			[
				{
					"name": "brand",
					"value": 1136
				},
				{
					"name": "model",
					"value": 1143
				},
				{
					"name": "generation",
					"value": 2277
				}
			]
		]
	},
	{
		"name": "price_currency",
		"value": 2
	},
	{
		"name": "engine_capacity",
		"value": {
			"max": null,
			"min": 2000
		}
	}
]'
make_request 1 "Subaru Impreza III" "${subaru_impreza_iii_request}"

# Subaru Impreza III Автомат
subaru_impreza_iii_auto_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 1136
        },
        {
          "name": "model",
          "value": 1143
        },
        {
          "name": "generation",
          "value": 2277
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  },
  {
    "name": "engine_capacity",
    "value": {
      "max": null,
      "min": 2000
    }
  },
  {
    "name": "transmission_type",
    "value": [
      1,
      3,
      4
    ]
  }
]'
make_request 1 "Subaru Impreza III Автомат" "${subaru_impreza_iii_auto_request}"

# BMW X1 E84
bmw_x1_e84_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 8
        },
        {
          "name": "model",
          "value": 2207
        },
        {
          "name": "generation",
          "value": 126
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  }
]'
make_request 1 "BMW X1 E84" "${bmw_x1_e84_request}"
make_request 2 "BMW X1 E84" "${bmw_x1_e84_request}"

# Volvo S40 II
volvo_s40_ii_request='[
  {
    "name": "brands",
    "property": 6,
    "value": [
      [
        {
          "name": "brand",
          "value": 1238
        },
        {
          "name": "model",
          "value": 1255
        },
        {
          "name": "generation",
          "value": 2744
        }
      ]
    ]
  },
  {
    "name": "price_currency",
    "value": 2
  },
  {
    "name": "transmission_type",
    "value": [
      1,
      3,
      4
    ]
  },
  {
    "name": "engine_type",
    "value": [
      1
    ]
  }
]'
make_request 1 "Volvo S40 II" "${volvo_s40_ii_request}"

# atomically append to history
echo '\n' >> history
cat "$tempFile" >> history
rm "$tempFile"

# refresh view.csv
./view.sh

echo "${GREEN}Successfully downloaded data for $downloadDate${NC}"
echo "Note, view.csv was refreshed too"
