#! /usr/bin/env python3
import random

phrases=[
"As the prophecy foretold.",
"But at what cost?",
"So let it be written; so let it be done.",
"So… it has come to this.",
"That's just what he/she/they would've said.",
"Is this why fate brought us together?",
"And thus, I die",
"…just like in my dream…",
"Be that as it may, still may it be as it may be",
"There is no escape from destiny",
"Wise words by wise men write wise deeds in wise pen.",
"In this economy?",
"…and then the wolves came.",
"Six one way, half a dozen the other.",
"Fear not! -- ScoOoOoter",
"Has anyone really been far as decided to use even go want to do more like?",
"I've been further even more decided to use even go need to do look as anyone can!"]

randInt=random.randint(0,len(phrases)-1)
print(phrases[randInt])
