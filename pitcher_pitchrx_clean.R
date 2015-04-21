
##########################
##########################
#SETUP + DATA COLLECTION
##########################
##########################

#LOAD REQUIRED PACKAGES
library(ggplot2)
library(pitchRx)
library(dplyr)
library(plyr)
library(Hmisc)
library(lattice)

#DEFINE STRIKE ZONE
topKzone <- 3.5
botKzone <- 1.6
inKzone <- -0.95
outKzone <- 0.95
kZone <- data.frame(
  x=c(inKzone, inKzone, outKzone, outKzone, inKzone),
  y=c(botKzone, topKzone, topKzone, botKzone, botKzone)
)

#DETERMINE WHICH XML ITEMS WE NEED + SCRAPE DATA FOR TIME FRAME
files <- c("inning/inning_all.xml", "players.xml", "inning/inning_hit.xml")
dat <- scrape(start = "2015-04-01", end = "2015-04-15", suffix = files)



##########################
##########################
#DATA MANIPULATION
##########################
##########################

#ASSIGN VARIABLES TO DATAFRAMES
dat.atbat <- dat$atbat
dat.coach <- dat$coach
dat.player <- dat$player
dat.umpire <- dat$umpire
dat.hip <- dat$hip
dat.action <- dat$action
dat.pitch <- dat$pitch
dat.po <- dat$po
dat.runner <- dat$runner

#SUBSET WHERE PITCHER = FELIX HERNANDEZ
pitcher_atbats <- subset(dat.atbat, pitcher_name %in% "Felix Hernandez")

#RENAME TYPE TO TYPE_BSX
names(dat.pitch)[names(dat.pitch) == "type"] <- "type_bsx"

#JOIN DATAFRAMES PITCHER_ATBATS + PITCH
pitcher <- join(pitcher_atbats, dat.pitch, by = c("num", "url"), type="inner")


#WANT TO CREATE A DATA FRAME THAT CONTAINS JUST THE FINAL PITCH OF THE ATBAT
#TO DO THIS WE WILL NEED BALLS IN PLAY, STRIKEOUTS, AND WALKS

##CREATE SUBSET OF PITCHER DATA WHERE RESULT = X (BALL IN PLAY)
hits.pitcher <- subset(pitcher, type_bsx == "X")

##ADD ROWS FOR STRIKEOUTS AND WALKS 
hits.pitcher$k <- ifelse((hits.pitcher$count == "0-2" | hits.pitcher$count == "1-2" | hits.pitcher$count == "2-2" | hits.pitcher$count == "3-2") & (hits.pitcher$des == "Called Strike" | hits.pitcher$des == "Swinging Strike"),1,0)
hits.pitcher$bb <- ifelse((hits.pitcher$count == "3-0" | hits.pitcher$count == "3-1" | hits.pitcher$count == "3-2") & (hits.pitcher$des == "Ball" | hits.pitcher$des == "Ball In Dirt" | hits.pitcher$des == "Intent Ball"),1,0)

##SUBSET OUT ROWS THAT WERE A STRIKEOUT, WALK, OR BALL IN PLAY
events.pitcher <- subset(hits.pitcher,k>0 | bb>0 | type_bsx == "X")


##########################
##########################
#GRAPHICS
##########################
##########################

#############################################################################
#AVERAGE PITCH SPEED BY GAME (VELOCITY - MPH)
ggplot(aes(x=date,y=start_speed),data=pitcher) +
  stat_summary(fun.data="mean_cl_boot", color="red",size=1) +
  geom_point() +
  xlab("gameday") +
  ylab("velo") +
  facet_wrap(~ pitch_type)
#############################################################################

#############################################################################
#PITCH LOCATION OF FINAL PITCH OF ATBAT 
###SPLIT BY GAME
###COLOR BY EVENT (TYPE OF HIT)
###SHAPE = PITCH TYPE
ggplot(events.pitcher,aes(px,pz,color=event)) +
  geom_point(aes(shape=pitch_type)) +
  facet_wrap(~ date) +
  coord_equal() +
  geom_path(aes(x,y), data = kZone, lwd = 1, col = "black", alpha = .75)
#############################################################################

#############################################################################
#PITCH LOCATION OF ALL PITCHES THROWN
###SPLIT BY GAME
###COLORED BY BATTER HAND (L/R)
ggplot(pitcher,aes(px,pz,color=stand)) +
  geom_point(aes(shape=pitch_type)) +
  facet_wrap(~ date) +
  coord_equal() +
  geom_path(aes(x,y), data = kZone, lwd = 1, col = "black", alpha = .75)
#############################################################################

#############################################################################
#AVERAGE PITCH SPEED BY GAME (non-graphic)
speedCH <- subset(pitcher, pitch_type %in% c("CH","CU","FF","SI","SL"))
avgspeedCH <- aggregate(start_speed ~ pitch_type + date, data = pitcher, FUN=mean)
avgspeedCH <- droplevels(avgspeedCH)
avgspeedCH
#############################################################################

#############################################################################
#RELEASE POINT
ggplot(aes(x=x0,y=z0,shape=pitch_type),data=pitcher) + geom_point(aes(color=pitch_type)) +
  xlim(c(-3,3)) +
  ylim(c(0,7)) +
  facet_wrap(~ date)
#############################################################################

##############################################################################
# --> evaluating avg release point of each pitch (colored by game)
rpCH <- subset(pitcher, pitch_type %in% c("CH","CU","FF","SI","SL"))
avgrpCH <- aggregate(x0 ~ pitch_type + date, data = pitcher, FUN=mean)
avgrpCH <- droplevels(avgrpCH)

rpCH1 <- subset(pitcher, pitch_type %in% c("CH","CU","FF","SI","SL"))
avgrpCH1 <- aggregate(z0 ~ pitch_type + date, data = pitcher, FUN=mean)
avgrpCH1 <- droplevels(avgrpCH1)

releasepoint.eval <- join(avgrpCH, avgrpCH1, by = c("pitch_type", "date"), type="inner")
releasepoint.eval <- subset(releasepoint.eval,pitch_type != 'PO')

ggplot(aes(x=x0,y=z0,shape=pitch_type),data=releasepoint.eval) + 
  geom_point(aes(color=date)) +
  #facet_wrap(~ date) +
  xlab("Horizontal Release Point (inches)") +
  ylab("Vertical Release Point (inches)")   
  #############################################################################
#############################################################################
#MOVEMENT
ggplot(aes(x=pfx_x,y=pfx_z,shape=pitch_type),data=pitcher) + 
  geom_point(aes(color=pitch_type)) +
  facet_wrap(~ date) +
  coord_equal() +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  scale_y_continuous(minor_breaks = seq(-20 , 10, 0.5), breaks = seq(-20, 10, 1)) +
  scale_x_continuous(minor_breaks = seq(-15 , 15, 0.5), breaks = seq(-15, 15, 1)) +
  xlab("Horizontal Movement (inches)") +
  ylab("Vertical Movement (inches)") 
#############################################################################

##############################################################################
# --> evaluating avg movement of each pitch_type (split by game)
movCH <- subset(pitcher, pitch_type %in% c("CH","CU","FF","SI","SL"))
avgmovCH <- aggregate(pfx_z ~ pitch_type + date, data = pitcher, FUN=mean)
avgmovCH <- droplevels(avgmovCH)

movCH1 <- subset(pitcher, pitch_type %in% c("CH","CU","FF","SI","SL"))
avgmovCH1 <- aggregate(pfx_x ~ pitch_type + date, data = pitcher, FUN=mean)
avgmovCH1 <- droplevels(avgmovCH1)

movement.eval <- join(avgmovCH, avgmovCH1, by = c("pitch_type", "date"), type="inner")

ggplot(aes(x=pfx_x,y=pfx_z,shape=date),data=movement.eval) + 
  geom_point(aes(color=pitch_type)) +
  facet_wrap(~ date) +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  scale_y_continuous(minor_breaks = seq(-20 , 10, 0.5), breaks = seq(-20, 10, 1)) +
  scale_x_continuous(minor_breaks = seq(-15 , 15, 0.5), breaks = seq(-15, 15, 1)) +
  xlab("Horizontal Movement (inches)") +
  ylab("Vertical Movement (inches)") 
#############################################################################








##########################
##########################
#EXTRA - NOT USED
##########################
##########################

#############################################################################
#DOTPLOT OF AVG PITCH SPEEDS
dotplot(start_speed ~ factor(date) , groups=pitch_type,
        data = avgspeedCH,
        pch = 1:10, cex=1.5,
        par.settings = list(superpose.symbol = list(pch = 1:10)),
        auto.key=list(space="right"))
#############################################################################


#############################################################################
#VELOCITY TRENDS THROUGHOUT GAME
pitcher <- arrange(pitcher, start_tfs_zulu)
row_num_list <- 1:97
row_num_list_2 <- 98:nrow(pitcher)
row_num_list_2 <- row_num_list_2 - 97

for(i in 1:length(row_num_list_2)){
  row_num_list[[length(row_num_list)+1]] <- row_num_list_2[i]
}

pitcher$rownumber = row_num_list


ggplot(data=pitcher, aes(x=rownumber, y=start_speed)) +
  geom_point(aes(color=pitch_type)) +
  facet_wrap(~ date) +
  #geom_smooth(aes(group=pitch_type), method="lm", se=FALSE) +
  stat_smooth(aes(group=pitch_type,color=pitch_type),method="lm",se=FALSE) +
  xlab("Pitch Number") +
  ylab("Velocity (MPH)")
#############################################################################





  

