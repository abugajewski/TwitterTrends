# TwitterTrends

This project shows how to fetch Twitter’s Trending Topics from their API and display them in a simple table view.

The project has the following parts:

* Model:
    * `TrendingTopic`: Represents topics from JSON as native Swift structs (uses Swift 4 `Codable`).
* UI:
    * `TrendsViewController`: Simple table view controller that displays results from API.
* API:
    * `API` protocol: Represents a generic API protocol and is used by UI classes.
    * `TwitterAPI+Version1` extension: All extensions for current Twitter API.
    * `TwitterAPI`: Implementation of `API` protocol.
* `Config`: Global configuration for the application.
