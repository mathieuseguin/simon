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
  - Top terms for 'ThinkPinkBows': headband (2879), baby (1506), lace (1137), petti (920), like (908)
  - Top terms for 'bertiescloset': laptop (2003), case (1274), fabric (1250), sleeve (1120), ipad (963)
  - Top terms for 'Thevelvetacorn': patterns (1069), child (616), adult (594), toddler (537), help (469)
  - Top terms for 'SugarRobot': edible (691), butterflies (551), food (493), free (396), cake (375)
  - Top terms for 'janinekingdesigns': bag (3286), fabric (1670), strap (1623), zipper (1603), black (1464)
  - Top terms for 'Cyberoptix': tie (8047), ink (6066), black (4016), boxes (3516), gift (3148)
  - Top terms for 'DiddlebugsAndMe': hair (3308), clip (2279), bow (1277), girls (795), ribbon (677)
  - Top terms for 'collageOrama': print (4653), prints (3513), page (3193), book (3099), dictionary (1999)
  - Top terms for 'ThingsVerySpecial': tees (28602), chart (21032), child (18430), large (17968), white (17356)
  - Top terms for 'MysticMoons': gold (2080), mystic (2014), moon (2005), hoop (1932), precious (1821)
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
