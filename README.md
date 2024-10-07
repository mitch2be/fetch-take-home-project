# Steps to Run the App

Ensure the target fetch-take-home-project is selected and run

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I focused on clean, modular code that scales. I believe that is the foundation to a great app.

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

About 3 - 3.5 hours.

- 50% of my time for ensuring clean and scalable code with modules
- 25% of my time on the UI, error handling and async tasks
- 25% on tests

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

With more time
- adding light and dark mode
- Better UI design
- I would add localization into the app with more time

# Weakest Part of the Project: What do you think is the weakest part of your project?

My Recipe model object which led into my tests. More explained below:

I was confused on the JSON links. 

The All Recipes json had some missing fields and so did the Malformed Data json. For example, source_url was mising in the All Recipes json, which is why I made default values in my model objects.

Based on the directions for if the json was malformed, I was under the impression that the malformed endpoint would have the missing fields.

I wanted to call this out because it changed the way I structured my code and tests. I took a more defensive coding stance for the model object.

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?

The HTTPRequest framework is something I built myself previously and I dropped that into this project.
I used the tried and true Kingfisher for image caching.

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered

