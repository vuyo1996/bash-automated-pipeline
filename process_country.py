import json
import logging
from pathlib import Path

import pandas as pd

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)

script_dir = Path(__file__).resolve().parent
data_file = script_dir / "data.json"

with open(data_file, "r") as file:
    data = json.load(file)

objects = data["data"]["objects"][0]

country_info = {
    "name": objects["names"]["common"],
    "country_code": objects["codes"]["alpha_2"],
    "capital": objects["capitals"][0]["name"],
    "region": objects["region"],
    "subregion": objects["subregion"],
    "population": objects["population"],
    "area": objects["area"]["kilometers"]
}

countries_df = pd.DataFrame([country_info])

records_processed = len(countries_df)

if records_processed == 1:
    logging.info(f"Countries DataFrame created with {records_processed} country.")
else:
    logging.info(f"Countries DataFrame created with {records_processed} countries.")

print(records_processed)

