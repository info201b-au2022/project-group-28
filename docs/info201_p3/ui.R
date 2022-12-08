#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(leaflet)

#create data frames
name = c("Acropora", "Montipora", "Pocillopora", "Porites")
Reef_Size = c("small (< 10 cm)", "medium (10-50 cm)", "large (> 50 cm)") 
value = c(56, 12, 5, 3, 50, 22, 11, 1, 55, 12, 48, 0)

corals <- data.frame(name, Reef_Size, value, stringsAsFactors = FALSE) 

severe_coral_bleaching_events <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/coral-bleaching-events.csv")

coral_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-group-28/main/data/CoralBleaching.csv")
severity <- coral_data %>% 
  filter(SEVERITY_CODE > 0) %>% 
  select(COUNTRY, LAT, LON, YEAR, SEVERITY_CODE)

#creating the intro page
tab_panel_01 <-tabPanel(
  "Introduction",
  mainPanel(
    h1("Introduction"),
  ),
  verbatimTextOutput("introduction")
)

#creating first interactive page
tab_panel_02 <- tabPanel(
  "Map of Coral Bleaching",
  mainPanel(
    h1("Coral Bleaching Around the World Based on Severity Level"),
    selectInput("country", "Country:",
                choices = unique(severity$COUNTRY)),
    leafletOutput("map"),
    p("This map shows the longitude and latitude of all the locations where coral 
bleaching has a severity code greater than 0 in this data set. As the map 
shows, coral bleaching affects coral reefs all over the world. It is not just
concentrated to one area. The data points appear to be more concentrated north
of Australia and between North America and South America. This is also where a
larger number of coral reefs are located. This is helpful to understand that 
coral bleaching does not necessarily have any correlation with a particular 
region of the world.")
  )
)

#creating second interactive page
tab_panel_03 <- tabPanel(
  "Bar Graph",
  mainPanel(
    h1("Bar Graph"),
    plotOutput("bargraph")
  )
)

#creating third interactive page
tab_panel_04 <- tabPanel(
  "Line Graph",
  mainPanel(
    h1("Line Graph"),
    plotOutput("linegraph")
  )
)

tab_panel_05 <- tabPanel(
  "Summary Takeaways"
)
tab_panel_06 <- tabPanel(
  "Project Report",
  mainPanel(
    h1("The Impacts of Coral Bleaching"),
    p("Authors: Sarah Haworth (shaworth@uw.edu), Erin Dong (edong10@uw.edu),
      Brian Yoo (byoo7@uw.edu)"),
    em("INFO-201: Technical Foundations of Informatics - The Information School
       - University of Washington"),
    p("Autumn 2022"),
    h3("Abstract"),
    p("Our main question for this report is 'What factors can affect coral bleaching?',
and this question is important because millions of organisms and people depend
on the health of the coral reef ecosystem. Also, identifying patterns in data
can help show what can be done to prevent coral bleaching. To address the question,
we will look through data visualizations and datasets to identify certain patterns between the causes and effects of coral bleaching. We are concerned with not only what causes coral bleaching, but also about what the effects of coral bleaching goes to show about the state of other environmental concerns."),
    h3("Keywords"),
    p("coral reefs; ocean sustainability; climate change; coral bleaching"),
    h3("Introduction"),
    p("Over the couple of decades, coral bleaching has been an environmental issue that
has been reoccurring in media and the news. Coral bleaching is a phenomenon
that occurs when coral tissues turn completely white, giving coral skeletons a ghostly, lifeless appearance. Though coral bleaching does not kill the coral
reef itself, they become more vulnerable and more subject to mortality, affecting the millions of organisms in their ecosystem that depend on coral to survive.
Most coral health data is presented in hard coral cover percentage, where a higher percentage indicates healthier coral. By exploring datasets and data visualizations on coral hard coral cover percentage in the world over the last couple of decades, we hope to identify patterns and causes of coral bleaching over a broad spectrum of areas, including location, time, and population. Hopefully by identifying the problems, we can make progress in finding solutions and help prevent coral
bleaching."),
    h3("Problem Domain"),
    h5(strong("Why Are Corals Bleaching?")),
    p("For this project, we examined the increasing rate of coral bleaching and its impacts on the world in the last couple of decades. To start, we asked, “what’s causing the coral bleaching?” According to National Public Radio, “Abnormally hot ocean temperatures, as high as 7 degrees Fahrenheit above average, have stressed the reef” (1). Typically, coral bleaching occurs when the water temperature is too warm and the leading cause is climate change: an excessive amount of CO2 is being transferred into the ocean, which causes the water temperature to rise. Among many problems climate change is causing our world, coral bleaching is one of them, and it’s our job to sustain the health of corals."),
    h5(strong("What's Coral Bleaching?")),
    p("The National Oceanic and Atmospheric Administration state, “When corals are stressed by changes in conditions such as temperature, light, or nutrients, they expel the symbiotic algae living in their tissues, causing them to turn completely white.” (2). Change in average water temperature causes corals to expel the algae living within their tissues (Zooxanthellae) and turn completely white. Zooxanthellae are crucial to the health of living corals because it provides food for them from a
process called photosynthesis."),
    h5(strong("Why Should We Care? (Human Values)")),
    p("“A quarter of marine species depend on coral reefs at some point in their lives, as do millions of people who depend on reefs for food, jobs, and shoreline protection from storm surges.” (1) Coral reefs are some of the most diverse and valuable
ecosystems on Earth and according to the NOAA, “Coral reefs support more species
per unit area than any other marine environment, including about 4,000 species of fish, 800 species of hard corals and hundreds of other species” (3). Not only do coral reefs support thousands of marine species, many drugs are now being
developed from coral reef animals and plants as well. These drugs could be
possible cures for cancer, arthritis, human bacterial infections, viruses, and other diseases. Coral reefs support commercial and subsistence fisheries as well as jobs and businesses through tourism and recreation. To us, coral reefs are essential for our supply of fisheries. “Approximately half of all federally managed fisheries depend on coral reefs and related habitats for a portion of their life cycles. The National Marine Fisheries Service estimates the commercial value of U.S. fisheries from coral reefs is over $100 million” (3). Coral reefs also makes billions of dollars for local economies. Coral reefs attract visitors through diving tours, recreational fishing trips, hotels, restaurants, and other businesses based near reef ecosystems.

Lastly, “Coral reef structures also buffer shorelines against 97 percent of the energy from waves, storms, and floods, helping to prevent loss of life, property damage, and erosion” (3). The natural barrier acts as protection for coastal
communities from normal wave action and violent storms. Replacing these barriers will be costly and without it, the coastal residents will be at risk."),
    h5(strong("Who's At Stake")),
    p("Directly, coral bleaching causes harm for the corals and the marine life that depends on the coral and the reefs for survival. But indirectly, there are many stakes to the human economy and their well-being."),
    h5(strong("Citations")),
    p("Sommer, Lauren. “Australia's Great Barrier Reef Is Hit with Mass Coral Bleaching Yet Again.” NPR, NPR, 26 Mar. 2022,
https://www.npr.org/2022/03/26/1088886918/australia-great-barrier-reef-coral-bleaching-climate.

US Department of Commerce, National Oceanic and Atmospheric Administration.“What Is Coral Bleaching?” NOAA's National Ocean Service, 15 Mar. 2010,
https://oceanservice.noaa.gov/facts/coral_bleach.html.

US Department of Commerce, National Oceanic and Atmospheric Administration. “The Importance of Coral Reefs - Corals: NOAA's National Ocean Service Education.” Corals Tutorial, 1 June 2013,
https://oceanservice.noaa.gov/education/tutorial_corals/coral07_importance.html."),
    h3("Research Questions"),
    h5(strong("Where does coral bleaching occur most commonly?")),
    p("Coral reefs cover shallow tropical and subtropical waters throughout the oceans of the World. Due to the sheer volume of area we must investigate, identifying patterns in the locations of coral bleaching not only helps to narrow down the amount of
reef being covered, but also points out areas of concern for future instances of coral bleaching. Being able to pinpoint certain areas where coral bleaching is
more common or where coral bleaching occurs at a higher frequency helps identify what areas are more vulnerable."),
    h5(strong("When does coral bleaching usually occur?")),
    p("A multitude of factors can have potential to affect the rate and locations at which coral bleaching occurs, and understanding when it's more likely to occur can help identify some of these components. One place where we can observe these patterns is in when coral reefs are more susceptible to bleaching. Identifying how the changing of the seasons or the slow progression of time has affected the rate of coral bleaching opens up opportunities to make connections to the core causes of coral bleaching. For example, maybe the changing of seasons affects water temperature, which could lead to more bleaching."),
    h5(strong("Can more coral reefs adapt to survive with resilient species?")),
    p("Another way coral reefs can continue to survive in a warming ocean is by selecting the most resilient coral species. This is because there are many different species of corals around the world and each of these species thrive in a divergent environment. For example, some coral species have higher tolerance to higher temperatures, which is a primary cause for coral bleaching. Coral reefs are structures that include different species of corals and by adapting to the changing ocean temperature over time, it can remain with corals susceptible to the new environment."),
    h3("The Dataset"),
    p("This data set shows where coral bleaching occurs. The table shows the different
locations around the world and how effected each location is by coral bleaching.
The range of each dataset displays how coral bleaching has occurred overtime
and how it has increased or decreased depending on the location."),
    h5(strong("Citations")),
    p("ReefBase. (2022, September 28). Coral Bleaching Data. Harvard Dataverse. Retrieved October 31, 2022, from
https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi%3A10.7910%2FDVN%2FKUVQKY

Gilmour, J. P., Cook, K. L., &amp; Ryan, N. M. (2021, August 12). Scott Reef and Rowley Shoals Coral Bleaching Data.
Environmental Data Initiative. Retrieved October 31, 2022, from https://environmentaldatainitiative.org

Ritchie, H., &amp; Roser, M. (2021, April 15). Coral reefs. Our World in Data. Retrieved October 31, 2022, from
https://ourworldindata.org/coral-reefs"),
    h5(strong("Provenance of Data")),
    p("1. The first data set, as cited above, was intially complied by UNEP-WCMC and since than has been expanded by Dr. J. Oliver,
Mr. Y. Yusuf, and Ms. Nurulhuda Ahmad Fatan from WorldFish. The authors began collecting this data in 1963 and continued
until 2012. It was funded by WorldFish, which is an international, non-profit research organization focused on improving
fisheries and aquaculture. Because this is a nonprofit organization, the researchers aren't likely to make money.
This data is valid because Dr. J. Oliver held a top senior scientific position in WorldFish. UNEP-WCMC is also a credible
biodiversity resource. I obtained this data from Harvard Dataverse and I credit it as a valid respository for publishing data
and code."),
    p("2. The next two data sets both come from James P Gilmour, Kylie L Cook, and Nicole M Ryan. They began collecting data in 1994
and ended in 2017. The collecton of data was funded by the Austrialian Federal Goverment and Austrialian Institutite of
Marine Science. The researchers were most likely paid by the government to gather this data. It is credible because it is
backed by a government organization. I obtained this data set through DataOne, which is another repository that facilitates
data sharing."),
    p("3. The last data set came from Terry P Hughes, Kristen D Anderson, Shaun K Wilson, and more. Data collection spanned from
1980-2016. This research was funded by the Australian Research Council;s Centre of Excellence Program. The data is validated
because the authors attatched a document detailing how they gathered all of the data. Their materials, methods, and data
analysis all appear to be reliable. I gathered this data from *Our World in Data*, which is a scientific online publication
that focuses on large global problems. *Our World in Data* is credible because it has been cited by academic scientific
journals and social science journals such as The Washington Post, The New York Times, and The Economist."),
    h3("Expected Limitations"),
    p("We can draw out essential data and information about the coral reefs' health and bleaching. The data we gathered answers where coral bleaching occurs and the factors causing the rate of coral bleaching to rise. Within the vast locations of coral reef structures, we could pinpoint the exact location where coral bleaching most commonly occurs. This helped us determine what marine species are at stake and why the environment caused so much coral bleaching. The information we gathered can help inform and teach others how to better care for the environment and save the corals. Our research can be shared with numerous people and let them know the significance of the coral reefs and how they can help contribute to protecting them. Our data may also be helpful to marine biologists or conservationists in the future. They may need information on coral bleaching and use our research in their projects."),
    h3("Limitations"),
    p("Some limitations may be limited access to research and data sets. There is lots of data on coral bleaching in general, but it isn't necessarily exactly what we need to answer our research questions. To overcome this setback, the librarians at UW would be a good resource to help. They could provide instruction on where to look and how to compile a data set that answers our research questions. It also may be difficult to find a large enough sample size. The first data table we examined has a sample size of 6190, but the other ones only have 100-200 observations. Having a larger sample size will be important to identify relationships within the data set. The scope of discussion will limit this project because we don't have the years of experience in analyzing and creating research projects. We also cannot get into the same depth of discussion as more experienced scholars."),
    h3("Findings"),
    h5(strong("Where does coral bleaching occur most commonly?")),
    p("Coral bleaching is not more concentrated to one area of the world. Wherever there are coral reefs, coral bleaching occurs. If one were to compare a map of all the coral reefs in the world, it would look very similar to the map displayed of bleached coral reefs. The majority of coral reef bleaching occurs in the climate that coral reefs thrive in, which are tropical and subtropical oceans. These are typically closer to the equator. Over half the world’s coral reef bleaching occurrence happen within these 6 countries: Australia, Indonesia, the Philippines, Papua New Guinea, Fiji, and the Maldives. "),
    h5(strong("When does coral bleaching occur?")),
    p("The highest-level severity of coral bleaching events has occurred in the past 20 years. The data also appears to be more highly concentrated in the past 20 years, giving evidence that the amount of coral bleaching events has increased overall. This correlates with the rise in climate change and pollution, which are main factors of coral bleaching. The data collected ranges from 1980 to 2016. Based on the trends of the data, it can be assumed that coral bleaching has only increased during the 2016 to 2022 gap where data was not collected, and coral bleaching will continue to get worse in the future. "),
    h5(strong("Can more coral reefs adapt to survive with resilient species?")),
    p("Certain species are more susceptible to coral bleaching and some species are more resilient. Based on the data explored in this report, the", em("Acropora"), "species appears to be the most susceptible.", em("Acropora"),
      "is one of the most widespread coral groups. This is mainly due to the fact that it can cope with rapid sea-level changes. Unfortunately,", em("Acropora"), "is very sensitive to changes in the ocean caused by human activity. The ",
      em("Montipora"), "species also seems to be more susceptible as well.", em("Montipora"), "Montipora is much rarer but is easily impacted by ocean warming. The", em("Pocillopora"), "and", em("Porites"), "species are more resilient to coral bleaching than the two species mentioned above.",
      em("Pocillopora"), "is found on most coral reefs of the Indo-Pacific and eastern Pacific. It is relatively common.", em("Porites"), "is rarer and can be found in reefs throughout the world."),
    h3("Discussion"),
    h3("Conclusion"),
    h3("Acknowledgements"),
    p("Thank you to for our amazing T.A., Raina, for also helping us out and answering all of our questions in a timely manner"),
    h3("References"),
    p("Gilmour, J. P., Cook, K. L., &amp; Ryan, N. M. (2021, August 12). Scott Reef and Rowley Shoals Coral Bleaching Data. Environmental Data Initiative. Retrieved October 31, 2022, from https://environmentaldatainitiative.org"),
    p("ReefBase. (2022, September 28). Coral Bleaching Data. Harvard Dataverse. Retrieved October 31, 2022, from https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi%3A10.7910%2FDVN%2FKUVQKY"),
    p("Ritchie, H., &amp; Roser, M. (2021, April 15). Coral reefs. Our World in Data. Retrieved October 31, 2022, from https://ourworldindata.org/coral-reefs"),
    p("Sommer, L. (2022, March 26). Australia's Great Barrier Reef is hit with mass coral bleaching yet again. NPR. Retrieved October 31, 2022, from https://www.npr.org/2022/03/26/1088886918/australia-great-barrier-reef-coral-bleaching-climate"),
    p("US Department of Commerce, N. O. and A. A. (2010, March 15). What is coral bleaching? NOAA's National Ocean Service. Retrieved October 31, 2022, from https://oceanservice.noaa.gov/facts/coral_bleach.html"),
    p("US Department of Commerce, N. O. and A. A. (2013, June 1). The importance of coral reefs - corals: NOAA's National Ocean Service Education. Corals Tutorial. Retrieved October 31, 2022, from https://oceanservice.noaa.gov/education/tutorial_corals/coral07_importance.html")
    )
)
# Define UI for application that draws a histogram
fluidPage(
  theme = shinytheme("darkly"),
  navlistPanel(
    "Trends Coral Reef Bleaching",
    
    # Variable set in tab_panel_plot.R
    tab_panel_01,

    tab_panel_02,
    
    tab_panel_03,
    
    tab_panel_04,
    
    tab_panel_05,
    
    tab_panel_06
  )
)

