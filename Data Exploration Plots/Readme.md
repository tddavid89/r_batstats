# PitchFx Data Exploration: R Plots


---

For this project, I scraped 2015 PitchFx data from the MLB.com website (MLBAM) using the R package _"pitchRx"_, post processed the data, and loaded the finished dataset into Hadoop. This data was then stored in a Hive table, where I was able to access and manipulate the data using Apache Zeppelin.

Having closely followed the Seattle Mariners this past season, I decided to create plots pertaining to two of their biggest stars: _Robinson Cano_ and _Felix Hernandez_

---

### Pitch Location
For my first plot, I wanted to get a general understanding of the pitch location data. I created a two dimensional plot creating two legends: **type** (ball (B), strike (S), ball in play (X) and **pitch type**

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img07.png?raw=true)


---

### Pitch Location By Pitch Type
Once I got a general understanding of the pitch location data, I wanted to try splitting the data into segments to see if I could find anything valuable. This plot shows all of the pitches thrown by Felix Hernandez in 2015, split by pitch type.

A few things stand out to me, even from this basic plot.
1. With the exception of his Fastball (FF) and Sinker (SI), Hernandez tends to stay away from quadrant 1 (*possibly because this is up and away to a right handed batter*). This also makes sense, as pitchers tend to keep their off-speed pitches down in the zone.

2. Hernandez tends to get quite a few pitches of the plate for strikes. While this particular graph does not go into detail regarding the type of strike (swinging vs. looking), it is still significant as it highlights his ability to expand the strike zone

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img06.png?raw=true)

---

### Pitch Location: Density Plots
While it was interesting to see pitches displayed as points, it is difficult to determine the density of points in a given location as they all tend to stack on top of each other.I wanted to see the frequency in which batters were thrown a particular pitch in a particular location.

In the graph below, you can see the density of nine different pitch types thrown to Robinson Cano during the 2015 season.

This was very interesting to me. Cano is seeing his fair share of pitches low and away as a left-handed hitter (with the exception of knuckleballs, but this is to be expected due to the nature of the pitch). I found it particularly interesting how many sliders he was thrown in the middle of the plate. It seems to me that the density map would illustrate more pitches thrown outside as it seems that right-handed pitchers would utilize it as a chase pitch throwing it low and outside to lefties.

I would be interested in seeing this compared to other seasons. Cano struggled this season, and it would be interesting to explore whether this was because he was being pitched differently than in previous years (more low and outside pitches), or some other reason.

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img01.png?raw=true)


---
### Contour Plots

The previous graph got me thinking about strategies pitchers may have utilized against Cano. As a result, I wanted to see if right-handed pitchers pitched him differently than left-handed pitchers.

It does appear that all pitchers were trying to stay away from Cano this Year. Right-handed pitchers tended to miss up in the zone more to Cano than their left-handed counterparts.

The overall slant of the graphs are different, but this is expected due to the nature of the delivery of the ball. Left-handed pitchers are mostly going to hit quadrants 1 and 3 (release too soon / release too late), and right-handers should naturally hit quadrants 2 and 4.

It also appears that right-handed pitchers threw Cano more fastballs than left-handers.

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img03.png?raw=true)

---
### Contour Plots: Pitch Type

Continuing with contour plots, I wanted to see if left-handers pitched Cano in a different manner compared to right-handers.

It appears that left-handers tried to bury their off-speed pitches, as curveballs and sliders primarily reside in quadrant 3. It appears they tried to stay away with the fastball, but jam him with the sinker, and at times the change-up. This is a fairly common approach for a left-handed pitcher vs. a left-handed hitter.

Right-handed pitchers followed a fairly traditional strategy as well. It appeaars that they too buried their off-speed pitches, throwing sliders and curveballs down and in. I am still very surprised at how many sliders and curveballs they left in the middle of the plate. Fastballs were mostly in the middle of the plate, I imagine because they were used as first pitches or thrown when a strike was needed and Cano was taking.

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img02.png?raw=true)

---
### Density Plots: Batted Balls

Now that I saw how pitchers approached Cano, I wanted to see how well he handled the pitches he was thrown. I decided to focus only on results that resulted in Cano reaching base.

Robinson's heat map for singles was all over the place, but he primarily took advantage of any pitch left over the middle of the plate. Most of his singles on sinkers were inside, but this is most likely due to the fact that most of the sinkers he saw were on the inside half.

For doubles, Cano took advantage of change-ups that were left out over the plate. He also took advantage of sliders and fastballs.

Homeruns were interesting as he primarily hit them on inside pitches. I guess it makes sense as he has a lot of power to the pull side, but Cano has alwasy struck me as someone who has power to all fields. I guess this is still the case as most of his doubles appear to be to the opposite filed, but it is still surprising. Cano also hit quite a few curveballs for homeruns that were not thrown as strikes.

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img05.png?raw=true)

---
### Contour Plots: Batted Balls

While the density plots were informative, I wanted to see if contour plots would hightlight anything new. For the most part, the same data is illustrated, but we can see a little bit more granularity into where local hot spots reside.

![img01](https://github.com/tddavid89/r_batstats/blob/master/Data%20Exploration%20Plots/img04.png?raw=true)
