# A Tale of Two Felixes

--------------------------------------------------------------------------------

Felix Hernandez opened the season with an emphatic 4-1 win over the Los Angeles Angels of Anaheim in front of a sell-out crowd at Safeco Field in Seattle. It was the type of start that we have come to expect from Felix, especially on opening day with a line of:

**_7IP/2H/1ER/1BB/10K_**

Fast forward to 5 days later, the Mariners with a 2-3 record are looking to Felix to right the ship against the division rival Oakland Athletics. It just seems automatic that every 5 days, Felix will do something special. While the Mariners ended up winning the game in extra innings thanks to a Nelson Cruz HR, Felix posted a line of:

**_5IP/8H/3R/2BB/1K_**

Forced to leave the game early with quad tightness Felix posted a rare outing in which he walked more than he struck out.

It is entirely too early in the season to panic, and it was not a terrible start by any stretch of the imagination, but it was very uncharacteristic from someone who has been the anchor of this team for years, and a perennial Cy Young candidate. I understand that every pitcher has good starts and bad starts, and that made me start to wonder if there was a way to visualize the difference. There are some days where pitchers admit that their "stuff" wasn't there, and there are other days that they make pitches but the other teams put good swings on the ball. I wanted to see if we could tell which happened.

First, I looked to velocity. The first thing that comes to my mind with a dominant starter is velo. To me, it is important to see if the velocity is similar to what it had been in the past and if there is a big enough gap between pitch speeds. Looking at Felix's average velocity for the day, there was not a huge cause for alarm

![img01](https://github.com/tddavid89/r_batstats/blob/master/Tale%20of%20Two%20Felixes/img01.png?raw=true)

Average velocity was down with Felix's Changeup, Four-Seam Fastball, and Sinker, while it was up with his Curveball and Slider. However, none of these values were too extreme to elicit any type of concern.

With velocity out of the way, I went to location. Was Felix around the strike zone?

![img02](https://github.com/tddavid89/r_batstats/blob/master/Tale%20of%20Two%20Felixes/img02.png?raw=true)

In the first game, it appears that Felix was attacking the zone. He threw a lot of pitches in the middle of the strikezone with movement (quite a few Sinkers, Curveballs, and Changeups). In the second game, he appeared to work the edges of the zone, throwing quite a few borderline pitches, and for the most part avoided the middle of the strike zone.

Outside of the strikezone, Felix was much more aggressive in the first game, burying a lot of Changeups, Curveballs, and the occasional Slider. He did the same in game two, but not as often. For the most part, it appears that Felix was working up in the zone. The Changeups that he was burying on game one, were elevated.

With that information, my mind immediately went to release point. Felix was up in the zone for one of two reasons. One, he felt he could be more effective trying to catch the corners of the zone with his offspeed pitches against Oakland. Or two, his pitches weren't biting like they were supposed to. To me, the latter is more likely and more interesting.

Release points are very telling, as they give you a good indication of pitch movement. It has been said on several occasions that Felix is incredibly hard to hit because EVERYTHING moves. He doesn't blow people away with the upper 90's Fastball, he sits in the lower 90's and everything moves. You take away that movement, you take away his primary weapon.

Looking at his release points together, you start to notice a slight move to the right, more to the center of his body.

![img03](https://github.com/tddavid89/r_batstats/blob/master/Tale%20of%20Two%20Felixes/img03.png?raw=true)

There is enough of a shift, that I am interested to see how each individual pitch is shifting. With a movement to the center of his body, there is less horizontal movement, and the hitters have to deal with less run on his Four-Seam Fastball and Sinker.

I took the average release point of each pitch type and plotted them on the same graph, splitting them up by each game.

![img04](https://github.com/tddavid89/r_batstats/blob/master/Tale%20of%20Two%20Felixes/img04.png?raw=true)

You can see now that everything has shifted. Although the shift is small (as the graph is displayed in inches), it could be enough to cause a noticable effect on the outcome of Felix's pitches.

Sure enough, the effect on movement was substantial.

![img05](https://github.com/tddavid89/r_batstats/blob/master/Tale%20of%20Two%20Felixes/img05.png?raw=true)

The first thing that I noticed was that Felix worked primarily in the lower two quadrants throughout the entire first game. This says nothing about the location of the pitches, but it suggests that he was missing bats with good downward movement on almost everything. Felix also had as much as 11 inches of horizontal movement. For the most part Felix stayed away from the origin of the graph except for Four-Seam Fastballs and the occasional Changeup that were most likely the first pitches of an atbat or came at a time where he needed to locate.

Moving to the second graph, everything was up. The only pitch he effectively buried was his curveball. A few Changeups dipped below the x-axis, but for the most part, his Changeups were flat. Everything was in the upper two quadrants, with the exception of his Curveballs, which should exist in the lower quadrants regardless of their effectiveness. It is worth noting that there was still a good amount of horizontal movement on Felix's pitches, but not with as much consistency in the first game.

While it is important to see that Felix's pitches in the second game didn't have the movement that they did in the first, it is also important to see what the A's were able to do with these pitches. You can see that the majority of contact occurred in the upper left quadrant, which means that they were taking advanage of opportunities when Felix delivered pitches with minimal vertical movement.

![img06](https://github.com/tddavid89/r_batstats/blob/master/Tale%20of%20Two%20Felixes/img06.png?raw=true)

Felix did manage to generate quite a few outs in that upper left quadrant, but that is also where he surrendered all of his runs in has second outing.

Almost all of Felix's swinging strikes from the first game came with significant vertical movement, while the few he managed in the first game were primarily flat.

From the results, it appears that the primary difference between Felix's two starts was the amount of movement, specifically vertical movement, that he was able to generate. This appears to be caused by a slight change in release points. It is possible that this was simply a poor outing or it could be a factor of his tight quad. Felix's injury could have led him to compensate by making a more upright delivery, eliminating enough movement to make him more hittable. While it is still early in the season, it is definitely something to keep an eye on as King Felix takes the hill at Safeco against the Rangers tonight.

For anyone interested in the code used to generate the graphs above,here is a link to my github repository: ([https://github.com/tddavid89/r_batstats/blob/master/pitcher_pitchrx_clean.R](https://github.com/tddavid89/r_batstats/blob/master/pitcher_pitchrx_clean.R))
