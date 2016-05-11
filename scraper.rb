# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful
def extract_number(element)
  element.text.delete(",").to_i
end

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

# Read in a page
page = agent.get("https://www.planningalerts.org.au")

metrics_numbers = page.search("#stats-wrapper .number")
metrics = {
  date_scraped: Date.today.to_s,
  applications_added_in_last_week: extract_number(metrics_numbers[0]),
  email_alerts_sent_in_last_week: extract_number(metrics_numbers[1]),
  new_alert_subscriptions_in_last_week: extract_number(metrics_numbers[2]),
  new_comments_made_in_last_week: extract_number(metrics_numbers[3])
}

ScraperWiki.save_sqlite([:date_scraped], metrics)
