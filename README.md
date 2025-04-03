# car-insider
Accumulates a car market offers and visualizing price and other metrics history. Hypothesys is this can provide some insights for me as a buyer.

Actual insights are served by https://mkharytonau.github.io/car-insider/

## download.sh
Downloads actual offers from `api.av.by` and accumulates results in `history`.

It extends each offer (`advert` in `av.by` api naming) with current datetime and model, so we can track metrics by datetime later.

## view.sh
Extract metrics we are interested in from raw `history` data into `view.csv`. It can be pasted to Excel to draw plots.

## insights.ipynb
Jupyter notebook visualising history metrics and extracting insights.

## generate index.html from insights.ipynb
"Run all cells" and then
```bash
jupyter nbconvert insights.ipynb --no-input --no-prompt --to html --output index
```

## download data and refresh insights
1. Clone this repo
2. Run ./download.sh
3. "Run all cells" of insights.ipynb
4. Refresh insights html report, see above for a command
5. Commit and push, index.html served by Github Pages will update automatically
