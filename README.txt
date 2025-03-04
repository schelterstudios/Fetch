### Summary: Include screen shots or a video of your app highlighting its features
recipes.png - Default API
empty.png - API for empty result
malformed.png - API for malformed json

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
First priority is MVP, so building the service and populating a list. From there I focus on larger optimizations, like the custom
image cacher and view model alongside unit tests to verify it.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
About 3 hours. First hour for the MVP, then other two hours for optimizations.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Started with AsyncImage for the photos, as it's an out-of-the-box solution. Finding out it doesn't properly handle image caching,
I would normally fall back to a third party solution, but given the requirements, I went with a custom solution.

### Weakest Part of the Project: What do you think is the weakest part of your project?
Could further optimize caching to proactively load images instead of waiting for the user to scroll.
Better and more communicative UI (ie animations and guidance)
Use of compile-time conditionals and scheme arguments to improve testing the different service response scenarios.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
