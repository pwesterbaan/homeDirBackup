#!/bin/bash

## Script to reset regions in end dimension in Minecraft
## https://xisumavoid.com/pruneendchunks/

# WORLD=1st\ World
WORLD=1_20\ world
cd /home/peter/.minecraft/saves/"$WORLD"/DIM1/region

zip ~/dataRegions.zip r.0.0.mca r.0.-1.mca r.0.1.mca r.0.-2.mca r.0.2.mca r.0.-3.mca r.-1.0.mca r.1.0.mca r.-1.-1.mca r.-1.1.mca r.1.-1.mca r.1.1.mca r.-1.-2.mca r.-1.2.mca r.1.-2.mca r.1.2.mca r.-1.-3.mca r.1.-3.mca r.-2.0.mca r.2.0.mca r.-2.-1.mca r.-2.1.mca r.2.-1.mca r.2.1.mca r.-2.-2.mca r.-2.2.mca r.2.-2.mca r.2.2.mca r.-2.-3.mca r.2.-3.mca r.-3.0.mca r.-3.-1.mca r.-3.1.mca r.-3.-2.mca r.-3.2.mca r.-3.-3.mca

rm *.mca

unzip ~/dataRegions.zip

rm ~/dataRegions.zip
