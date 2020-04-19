+++
title = "Setting up PostgreSQL on MacOS"
date = 2019-02-18
lastmod = 2020-04-19T18:00:26-05:00
draft = false
weight = 2004
+++

For this tutorial we will be using postgres.app from the folks at <https://eggerapps.at/> to install and setup a local development server on macOS.

Download and install using the instructions at <https://postgresapp.com/>

Start postgres from the applications folder
Ensure the CLI tools are working by typing,

```sh
createdb
```

This should result in the following error if everything was installed correctly,

```sh
createdb: database creation failed: ERROR: database "username" already exists
```

To create your development db enter into the console,

```sh
createdb devdb
```

If for whatever reason this db needs to be removed use,

```sh
dropdb devdb
```

Access the db we have just created,

```sh
psql devdb
```

This should drop you into an interactive terminal program where we will be able to enter, edit, and execute sql commands.

From here you can also execute internal psql commands beginning with the backslash character, "",
that are not SQL commands.

You can see what commands are available to you with the help command,

```sh
devdb=# help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit
```

## Moving from San Diego to Austin {#moving-from-san-diego-to-austin}

A couple of months ago an opportunity opened up at work to move to Austin,
Texas. I toyed with the idea of making the move but never took it seriously.
Next thing you know, the lease on my apartment at the time was about to end and
I still had not found a new place to live in San Diego. Queue time to take the
decision seriously. Growing up and attending college in San Diego I felt like it
would be a good time to experience something new and committed to going. And,
after a hectic two months of moving halfway across the country, I'm finally
starting to settle in. Here are some things I've learned leading up to the move
and what I've learned from a little over a month in Austin.

## Start as early as possible {#start-as-early-as-possible}

Moving across the country with one month notice is certainly possible but I'd
highly recommend against it. My girlfriend and I had a little less than a month
to find a place to live, pack, ship, and drive out to Texas to avoid being
homeless. We were fortunate my family in San Antonio was able to view apartments
for us. If not we would have been rushed into picking a place to live. Spreading
out the cadence at which you pack, donate, and sell items relieves a lot of the
pressure of the move. Make the months prior as easy possible by starting as soon
as you can.

## Save money by shipping {#save-money-by-shipping}

Initially, we thought of using a moving company to pack up our belongings and
move them to Austin for us. While this would be the most painless route, expect
to burn a huge hole in your pocket. Our next option was to throw our belongings
in a U-Haul and drive them ourselves. That too was costlier then we had
expected. Especially taking into account the actual value of everything.

We settled on packing whatever valuables we could fit into the back of my car
and use Amtrak's shipping services for the rest (clothes, books, kitchen goods,
etc). What didn't fit we shipped using UPS which could have been saved even
further by shopping shipping services. For furniture, we realized we could
donate or sell most of it and rebuy the same furniture and still save. Overall
we offset the costs by more than half and were able to redistribute the costs of
buying new furniture to after the move. This option may not work for everyone
but is worth taking into account if you're willing to part with most of your
belongings and start over.

## Austin feels small {#austin-feels-small}

This one is subjective. Coming from San Diego and spending a significant time in
LA. Austin feels small. The small neighboring city of Round Rock is 21 minutes
north of Downtown Austin. My hometown of Mira Mesa in San Diego is 25 minutes
from Downtown San Diego yet we're still considered to be in the city of San
Diego. Everything feel's closer then I am accustomed to. This doesn't mean your
commute will be short though. Austin is supposedly notorious for its traffic.
Although nothing out of the ordinary compared to LA or San Francisco.

## Texans are nice {#texans-are-nice}

It will take a while to get used to how nice people have been in Texas. It's
downright strange at times. Friendly... but strange. Just the other day we were
in the parking lot with our throw pillow haul from HomeGoods when a random
stranger was genuinely excited for us when he saw that we had bought pillows.
The week prior we were at Whole Foods when the cashier complimented on our
choice of breakfast tacos and asked about our plans for the day. I promised I'm
not trying to be rude when I stare at you with a confused smile I just don't
know how to react yet.

## It seems as techie as they say {#it-seems-as-techie-as-they-say}

I don't have a large sample size to build on but five of the six people on our
TopGolf league team works for tech companies. It isn't shocking to see large
tech company offices as you drive through Austin. This is a stark contrast to
what I'd experienced in Southern California.

## Californians are everywhere {#californians-are-everywhere}

This may not come as a surprise to those who have lived in Austin for years but
it certainly surprised me how noticeable it was. In our apartment complex alone
I've spotted 5 California plates. Out and about it's not unusual to see people
representing their hometown teams. A recent post on culturemap estimated from
2010 to 2014 the Austin area gained on average 8 Californians per day. This was
prior to Austin being named "Best City to Live" two years in a row by U.S. News
and World Report. It's hard to imagine the influx to stop as long as
California's cost of living continues to rise. We are sorry.

## The food has been outstanding {#the-food-has-been-outstanding}

I was concerned about moving away from the land of California burritos in San
Diego and the sprawling food metropolitan of LA but Austin was quick to quell
those concerns. The BBQ is amazing and I have yet to go to the BBQ capital of
Texas 35 minutes south in Lockhart. Breakfast Tacos may not be as good as San
Diego burritos but they will definitely keep me satisfied until I go back. The
pho I've tried easily competes with the best I've had in Little Saigon. The
xiaolongbao (soup dumplings) are better than any I've had in San Diego prior to
Din Tai Fung opening. We have most of the top burger places, Hop Doddy, Shake
Shack, Whataburger, In-n-out, and Austin's very own P Terry's (which was a
pleasant surprise). And from my understanding, this is only the tip of the
iceberg. I'm looking forward to eating my way through Austin as the months roll
by.

## Your money goes a long way relative to California {#your-money-goes-a-long-way-relative-to-california}

As most know, one of the driving forces for the influx of new Austin residents
is the cost of living. It was one of the driving forces for me. I've noticed
this most in the cost of gas and housing. Prior to leaving San Diego, it would
cost anywhere from $3.70-$4.00 per gallon to fill up my tank. In Austin, it's
been anywhere from $2.40-$2.80 per gallon. My Austin apartment costs roughly the
same as the one I had in Oceanside except for its 3 years old versus 30 years
old. The gym has more than 3 treadmills and the washing machine and dryer are
in-unit. Getting the same quality apartment in San Diego would have cost upwards
of 50% more depending on the location. On top of the general day-to-day
expenses, Texas has no state income tax. There's a downside to all this though,
I've been made aware of the cost of living going up and going up fast. Housing
prices in some neighborhoods reflect those in California, some residents are
being forced out of neighborhoods they've lived in for generations. It's
unfortunate. Hopefully, it doesn't snowball into the issues we are seeing in the
bay area.

## Conclusion {#conclusion}

It has only been a month but so far Austin has exceeded all expectations and I
look forward to experiencing what more this city has to offer. It will be
interesting to see how my opinion of Austin changes over the course of a year
and will follow up on this post then. If you've moved to Austin from another
state, I'd love to hear your thoughts.

[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"
