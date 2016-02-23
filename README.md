# Etsymon

Small coding exercise to find the top 5 terms from Etsy shops' title &amp; description

## INSTALL

```
$ bundle install
```

## Run tests

```
$ rspec
```

## Usage

```
$ ./bin/etsymon --api-key YOUR_API_KEY shop_name_1 shop_name_2 shop_name_3
```

The current implementation contains two stop lists. The first one contains the most common english words. The second one contains a domain specific words and can be disabled using "--activate-ecommerce-stop-words false"
Both can be easily updated by adding or removing a line from:
  - lib/dict/common.txt
  - lib/dict/etsy.txt

## Example:

```
$ ./bin/etsymon --api-key MY_API_KEY ThinkPinkBows bertiescloset Thevelvetacorn SugarRobot janinekingdesigns Cyberoptix Diddlebugs collageOrama ThingsVerySpecial MysticMoons
Retrieving listing for:
  - ThinkPinkBows... done.
  - bertiescloset... done.
  - Thevelvetacorn... done.
  - SugarRobot... done.
  - janinekingdesigns... done.
  - Cyberoptix... done.
  - Diddlebugs... done.
  - collageOrama... done.
  - ThingsVerySpecial... done.
  - MysticMoons... done.

Computing top terms:
  - Top terms for 'ThinkPinkBows': headband (3448), baby (1518), flower (1448), romper (1318), girl (1263)
  - Top terms for 'bertiescloset': laptop (2084), case (1863), fabric (1256), sleeve (1119), cover (1028)
  - Top terms for 'Thevelvetacorn': child (616), adult (599), toddler (537), velvet (384), acorn (384)
  - Top terms for 'SugarRobot': edible (689), butterfly (665), food (491), cake (467), nut (396)
  - Top terms for 'janinekingdesigns': bag (3358), fabric (2634), strap (1778), zipper (1690), black (1431)
  - Top terms for 'Cyberoptix': tie (8041), ink (6107), black (4010), box (3594), note (3459)
  - Top terms for 'DiddlebugsAndMe': hair (3273), clip (2697), bow (1772), girl (835), ribbon (670)
  - Top terms for 'collageOrama': print (8187), book (3950), dictionary (2004), image (1715), unique (1684)
  - Top terms for 'ThingsVerySpecial': tee (39868), child (27749), large (17961), white (17350), age (14949)
  - Top terms for 'MysticMoons': hoop (2695), gold (2078), moon (2012), mystic (2010), preciou (1817)
```

Shops for the example:
  - https://www.etsy.com/shop/ThinkPinkBows
  - https://www.etsy.com/shop/bertiescloset
  - https://www.etsy.com/shop/Thevelvetacorn
  - https://www.etsy.com/shop/SugarRobot
  - https://www.etsy.com/shop/janinekingdesigns
  - https://www.etsy.com/shop/Cyberoptix
  - https://www.etsy.com/shop/Diddlebugs
  - https://www.etsy.com/shop/collageOrama
  - https://www.etsy.com/shop/ThingsVerySpecial
  - https://www.etsy.com/shop/MysticMoons
