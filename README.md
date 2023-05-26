# RSS Filter

This project is a simple Hanami 2 Ruby app that will take `FEED_URL` specified in an environment variable, and then it will filter out all RSS items that have their link NOT match any of the paths specified in `NewsletterRss::Rss:Filter::KEEP_KEYS`.

## Issues/Problems/Technical Debt

First, the name of the Github project is `rssfilter` but the Hanami app is named `NewsletterRss` even if there is nothing specific about a newsletter here. So that should be renamed.

Second, I did not run almost any linter or code formatter consistently. Thus the code does not look the same in some files (like mixing usage of single and double quotes) and so on. This is mainly because I work on various Ruby projects and they all have different styling guides, so I think in the end I am getting immune to any style offense, thus I can just read code in any style, and it does not bother me.

Third, it does not have good tests. As I had a limited amount of time early morning or late at night to read Hanami 2 and implement this, I did not write good tests.

Fourth, I made this with Hanami 2 as I wanted to learn a bit about it.
