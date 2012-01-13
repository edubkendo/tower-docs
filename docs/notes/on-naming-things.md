## Resources

- type "define someword" in google
- [Etymonline](http://etymonline.com)
- [Thesaurus.com](http://thesaurus.com)
- [Metaphors We Live By - George Lakoff](http://www.amazon.com/Metaphors-We-Live-George-Lakoff/dp/0226468011)

## Entailments

Rails
  - entailments: fast, speed, future of transportation, massive army behind them (rail workers)
  - sound: simple to pronounce, one syllable, common word
  - look: easy to read, easy to remember, not too generic
  
- choices for Metro.js
  - Urban.js
  - Tau.js
  - Muni.js: The San Francisco Municipal Railway (SF Muni) is the public transit system for the city and county of San Francisco. (http://www.etymonline.com/index.php?term=municipal)
  - Transit.js
  - Auto.js (and α for the global variable)
    - short, and starts with A
  - Pilot.js
  - Concrete.js
  - Car.js (Short)
  
Once you pick a name you can use the entailments for variable names, the logo, and the design in general, _only if the entailments come to your mind immediately_.  For Rails, it's clear.  For Taciturn it's not.
  
## Look, Sound, and Feel

The word must be easy to say and remember.  It must not be an ugly word.

Ugly words:

- carbuncle.  uncle is fine

Must be short, unless the name is a joke
  
## Attributes of Cheesy Names

- Alternative spellings
  - dezign
  - some alternative spellings are okay if the word still looks good:
    - thryve (thrive)
    - tranceform (transform)
- [Portmanteau Words](http://en.wikipedia.org/wiki/Portmanteau)
  - Comcast
  - Infosys
- Something with too direct (strong) of a meaning:
  - Speed, lightning.js, clean.js, light.js for a web framework
  - It's okay if it's over the top direct, the same way you'd say "I'm the most awesome person you've met" is good while "I'm the coolest person in this room" is not.  Awesome.js is okay.  Cool.js is not.  This probably changes with time.
  - Quick.js
- Too clever
- Too niche/rich of a word
  - taciturn.js: good, clean word, easy to pronounce, doesn't conflict with much, different from most words.  but it requires too much of a context to understand.
- Arrogant words:
  - Tact.js: says your framework is better than the rest (I got tact, therefore you don't).

Some word modifications are okay:

- Adding "ly" to a name:
  - bit.ly
  - visual.ly

Some aren't, if they make 50% sense
  - water.ly
  
Bitly doesn't make any sense so it's okay.

If the alternative spelling looks aesthetically better (without making any special typography changes, must be good looking in the default font), then that's a plus.

## Alternative Spellings

## Multiple Word Names

- Okay if they are complete words:
  - OpenStandards.org
  - watch out for abbreviations.  Make the choice whether or not it will be mostly used as abbreviation.  If so, don't use it unless the abbreviation doesn't conflict with the space.  CachedCommons vs. cc.
- Okay if phrase
  - iCanHaz
- Not okay if Portmanteau

## Nouns

Naming something a specific noun usually means it means nothing and gives you a whole space for design.

- Parsley
- Arugula
- Apple

Naming something a "form" noun, or generic noun, is generally not a good idea because it doesn't create a metaphorical picture, plus it's not giving you any benefit search engine wise:

- Fruit.js
- Car.js

## Adjectives

commonly used adjectives are good for names:

- aweseome.js
- fun.js
- clever.js

niche adjectives are not (beware of synonyms for good adjectives):

- shrewd.js (clever synonym, smart.js is good and is a synonym, but it's a common adjective)

## Verbs

very good when it's a foundational library

- animate.js
- build.js
- design.js

Not good if you choose a good verb for a niche market

- help.js for a specific tooltip plugin that forces a specific design. okay if the tooltip plugin is awesome.

To use verbs, your project must be _low level_, _intuitive_, and _awesome_.

## Arrogant Words

Arrogant words are okay if they are _used out of context_ or talking about something not related to you:

- talent.js 
  - good for a web app about talent
  - bad for a layout framework (says you can layout things good, even though you might mean "makes the developer extra talented")
- tact.js
  - says you do it better than anyone else, even though you may mean "clean solution to a common problem".
  
## Other Random Names

- xyz.js
- asdf.js
- jimmy.js (named after people)
- saturn.js (named after mythology)
  
## Using Names that are taken by old or deprecated projects/organizations

- soap.js: soap.js might be a cool name for an animation library.  But SOAP is a protocol, and it was a skater shoe.  SOAP protocol was bulky and replaced by something awesome; in that context "soap" is an oldschool, complicated, slow name, so your project will be associated with slowness.

You can redefine the meaning of words _if_ your project is good enough.  To redefine "windows.js" or "explorer.js" you have to:

1. be in a very different context/market (a good windows.js might be a commandline tool that scrapes your social networks and gives you a feed like a log (window to your social life), a bad one would be a grid layout system).
2. it must be low level and powerful, aka "awesome".

I wanted to name a project Metro.js, the Node.js equivalent of Rails.  But Microsoft came out with Metro, their new Windows 8 operating system framework.  I had the choice to try and compete, because they were as of then unreleased, or scrap.  There would be too much confusion and energy spent describing how "it's not Microsoft's Metro".  And in the small chance the library grew to sufficient size it would introduce unnecessary legal/reputation tension with Microsoft.

## The Shit Test

1. is it clever?
2. is it an alternative spelling?
3. is it arrogant? talent.js
4. is it taking a valuable name? pythagoras.js

The more valuable the name, the more awesome your project better be.

### Example: Tactik.js

1. Clever: no
2. Alternative spelling: yes

## Don't listen to your negative judgements

It's important to take note of the immediate feelings and images that come to you when you judge a name.  But if it reminds you of a niche something you dislike that doesn't mean the word is bad:

- soap.js
  - soaps was a skater shoe fad.  reminds me of being part of a fad which was cool but fads in general fade, so it subtly suggests the library is a fad.  must be weighed in the context of everything else because soap was also an invention of the ancients, a clean word, etc.
- coconut.js
  - i dislike coconuts, and they remind me of "almond joy", the worst candy on the planet but everyone gave you on halloween. I would never name something coconut-anything.  But, I still have to see that coconut.js could actually be a cool name for something like a vector library - draws circles among other things, but circles are the foundation shape, simple, and coconut is a circle but it comes with a lot of imagery which opens up a lot of examples you could create: having an "example space" is important.  If coconut.js were a vector library, all of your demos could be thing like building palm trees (fractals), sand (particles), ocean waves and surf (waves), sunshine (light, reflection), etc.  So your biases should generally ignored - otherwise, really flesh them out and see if they are common biases.