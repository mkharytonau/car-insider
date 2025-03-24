# car-insider
Accumulates a car market offers and visualizing price and other metrics history. Hypothesys is this can provide some insights for me as a buyer.

## download.sh
Downloads actual offers from `api.av.by` for
 * BMW F34. Consist of 2 pages, so we make 2 api calls.

and accumulates results in `history`.

It extends each offer (`advert` in `av.by` api naming) with current datetime, so we can track metrics by datetime later.

## view.sh
Extract metrics we are interested in from raw `history` data into `view.csv`. It can be pasted to Excel to draw plots.
