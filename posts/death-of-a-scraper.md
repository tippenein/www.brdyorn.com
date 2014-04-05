{{{
    "title":"Death of a scraper",
    "tags" :["webapp", "api", "scraper"],
    "date" : "06/02/2013",
    "category": "web"
}}}

####Scraping is dumb
Scraping is a simple way of getting some info quickly, but that shit's going to break sooner or later. The site you're scraping will change its layout or the contents of divs and you'll be left with a big pile of garbage that will always need "fixing." 

<!--more-->

####Retiring a moderately useful web app
The app I'm referring to is talked about more [here](/post/classroom-scraper).
I'll be taking down [brontasaur.us](http://brontasaur.us) since it will no longer be able to scrape data from Astra. It seems to be something many universities have "implemented" - [https://duckduckgo.com/?q=astra+scheduler](https://duckduckgo.com/?q=astra+scheduler)


Only about 16 users will even notice the scraper is gone (according to cloudflare).

####Why we need an API
Some parts of the datavis look nice, but ultimately I was only ever interested in the gaps between classroom usage so it inhibits my use of it. With an API for classroom schedules it would allow anyone to represent the data however they deemed most useful. I wanted to leave some useful open source code behind for students to use, but now this won't happen. Perhaps that's good since they won't be handed a rough repo of poorly thought-out python... but I'd like to think people actually got use out of this tiny project.

There is a [University coding fest](http://campus-codefest-2013.eventbrite.com) coming up that I plan on attending. Maybe this will lead to an API for simple info, but I'm not holding my breath.
