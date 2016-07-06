##RevMan: Your Revenue Management Dashboard

RevMan is a proof-of-concept productivity tool for the hospitality industry highlighting some of the many features available through [Shiny Apps](http://shiny.rstudio.com).


The main sections of the Dashboard are:

* **Overview tab:** Industry-standard Key Performance Indicators for monitoring the state of the business in real time. Implements a red-light/yellow-light/green-light color-coding scheme based on underlying threshold values, to allow an at-a-glance overview of business health. *Tip: try different values of the modifiable parameters in the Google Sheet to see color changes!*

* **ADR tab:** ADR (average daily rate) being an important hospitality business metric has its own page for viewing year-over-year changes in the metric, as well as exploring the raw data values. Tip: plots are highly interactive. Zooming, rescaling, as well as filtering data by the legend are all possible! The data table can also be searched, sorted, and filtered.

* **NPS tab:** NPS (net promoter score) reveals customer satisfaction trends. *Tip: try entering new NPS entries with the data entry tool. The plot and table will automatically refresh.*


What other great features, you ask? How about:

* **Mobile friendly:** Page design is fluid and adapts to many screen sizes and ratios. Try resizing the browser window or viewing on a mobile device to see what happens!

* **Persistent data storage:** This App lives in the cloud, and can be deployed strictly locally. In either case, it can read and write data to central data stores like Google Sheets. *(Click the link in the Sidebar.)* Other interfaces are of course possible as well. Integrate easily with your existing technologies!

* **In control:** The App is smart about what data to download, and when. Only the pages viewed are downloaded, and then cached for faster subsequent access. When adding data from the App, affected plots and tables are automatically reloaded. Plus, the "Refresh Data" button is useful in case manual edits are made in external data stores (Google Sheets, etc). Automatic periodic polling and refreshing is also possible.

