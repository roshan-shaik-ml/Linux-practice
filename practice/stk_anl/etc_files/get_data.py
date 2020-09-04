#!/usr/bin/python3

import datetime as dt
# import matplotlib.pyplot as plt

import pandas as pd
import pandas_datareader.data as web

#style.use('ggplot')

start = dt.datetime(2019,1,1)
end = dt.datetime(2020,1,1)

pd.set_option("display.max_rows", None, "display.max_columns", None)
df = web.DataReader( 'GOOG', 'yahoo', start, end)

print(df)
