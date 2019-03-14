Hold and Save Analysis
================

### What are we even doing here

The purpose of this analysis is to research the impact of boosting save and hold point values for the league.

*Note: No hitters, perfect games, and pickoffs are being left out here*

#### Current pitching point values

|      |    x|
|------|----:|
| IP   |    3|
| ER   |   -1|
| W    |    5|
| L    |   -3|
| SV   |    5|
| BSv  |   -3|
| SO   |    1|
| H    |   -1|
| BB   |   -1|
| HBP  |   -1|
| QS   |    3|
| Hold |    3|

#### Proposed values

|      |    x|
|------|----:|
| IP   |    3|
| ER   |   -1|
| W    |    5|
| L    |   -3|
| SV   |    7|
| BSv  |   -3|
| SO   |    1|
| H    |   -1|
| BB   |   -1|
| HBP  |   -1|
| QS   |    3|
| Hold |    5|

### Data

Here's a quick look at each of the tables we're pulling in: standard pitching, relief pitching, and starting pitching.

Standard pitching is our source of IP, W-L, SO, H, ER, SV, BB, K, and HBP. Unfortunately it's missing two stats that we have to get from the other tables, respectively: Holds and QS.

#### Standard pitching

``` r
#show sample data
std_pitching[1:10,] %>% kable()
```

|   Rk| Name                |  Age| Tm  | Lg  |    W|    L|   W-L%|    ERA|    G|   GS|   GF|   CG|  SHO|   SV|    IP|    H|    R|   ER|   HR|   BB|  IBB|   SO|  HBP|   BK|   WP|   BF|  ERA+|    FIP|   WHIP|    H9|  HR9|   BB9|   SO9|  SO/W|
|----:|:--------------------|----:|:----|:----|----:|----:|------:|------:|----:|----:|----:|----:|----:|----:|-----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|-----:|------:|------:|-----:|----:|-----:|-----:|-----:|
|    1| Jason Adam01        |   26| KCR | AL  |    0|    3|  0.000|   6.12|   31|    0|   14|    0|    0|    0|  32.1|   30|   22|   22|    9|   15|    1|   37|    3|    1|    4|  142|    71|   6.16|  1.392|   8.4|  2.5|   4.2|  10.3|  2.47|
|    2| Austin L. Adams02   |   27| WSN | NL  |    0|    0|     NA|   0.00|    2|    0|    0|    0|    0|    0|   1.0|    1|    0|    0|    0|    3|    0|    0|    0|    0|    0|    7|    NA|  12.16|  4.000|   9.0|  0.0|  27.0|   0.0|  0.00|
|    3| Chance Adams01      |   23| NYY | AL  |    0|    1|  0.000|   7.04|    3|    1|    1|    0|    0|    0|   7.2|    8|    7|    6|    3|    4|    0|    4|    0|    0|    0|   34|    65|   8.77|  1.565|   9.4|  3.5|   4.7|   4.7|  1.00|
|    4| Matt Albers01       |   35| MIL | NL  |    3|    3|  0.500|   7.34|   34|    0|   10|    0|    0|    1|  34.1|   45|   29|   28|   10|   12|    2|   32|    2|    0|    1|  157|    56|   6.31|  1.660|  11.8|  2.6|   3.1|   8.4|  2.67|
|    5| Sandy Alcantara01   |   22| MIA | NL  |    2|    3|  0.400|   3.44|    6|    6|    0|    0|    0|    0|  34.0|   25|   13|   13|    3|   23|    0|   30|    2|    0|    0|  146|   107|   4.75|  1.412|   6.6|  0.8|   6.1|   7.9|  1.30|
|    6| Victor Alcantara01  |   25| DET | AL  |    1|    1|  0.500|   2.40|   27|    0|    8|    0|    0|    0|  30.0|   25|    8|    8|    5|    6|    0|   21|    0|    0|    2|  119|   184|   4.53|  1.033|   7.5|  1.5|   1.8|   6.3|  3.50|
|    7| Scott Alexander\*02 |   28| LAD | NL  |    2|    1|  0.667|   3.68|   73|    1|    8|    0|    0|    3|  66.0|   57|   28|   27|    4|   27|    2|   56|    2|    0|    2|  268|   106|   3.57|  1.273|   7.8|  0.5|   3.7|   7.6|  2.07|
|    8| Kolby Allard\*01    |   20| ATL | NL  |    1|    1|  0.500|  12.38|    3|    1|    0|    0|    0|    0|   8.0|   19|   12|   11|    3|    4|    0|    3|    1|    1|    0|   47|    34|   9.16|  2.875|  21.4|  3.4|   4.5|   3.4|  0.75|
|    9| Cody Allen01        |   29| CLE | AL  |    4|    6|  0.400|   4.70|   70|    0|   45|    0|    0|   27|  67.0|   58|   35|   35|   11|   33|    2|   80|    4|    0|    3|  289|    93|   4.56|  1.358|   7.8|  1.5|   4.4|  10.7|  2.42|
|   10| Miguel Almonte01    |   25| LAA | AL  |    0|    0|     NA|  10.29|    8|    0|    4|    0|    0|    0|   7.0|    9|    8|    8|    1|    3|    0|    7|    1|    0|    1|   34|    42|   4.73|  1.714|  11.6|  1.3|   3.9|   9.0|  2.33|

#### Relief pitching

``` r
rel_pitching[1:10,] %>% kable()
```

|   Rk| Name                |  Age| Tm  |    IP|    G|   GR|   GF|  Wgr|  Lgr|  SVOpp|   SV|  BSv| SV% |  SVSit|  Hold|   IR|   IS| IS% |  1stIP|    aLI|  LevHi|  LevMd|  LevLo|  Ahd|  Tie|  Bhd|  Runr|  Empt|  &gt;3o|  &lt;3o|  IPmult|  0DR|  Out/GR|  Pit/GR|
|----:|:--------------------|----:|:----|-----:|----:|----:|----:|----:|----:|------:|----:|----:|:----|------:|-----:|----:|----:|:----|------:|------:|------:|------:|------:|----:|----:|----:|-----:|-----:|-------:|-------:|-------:|----:|-------:|-------:|
|    1| Jason Adam01        |   26| KCR |  32.1|   31|   31|   14|    0|    3|      2|    0|    2| 0%  |      4|     2|   15|    9| 60% |      8|  0.661|      6|      5|     17|    4|    5|   22|     9|    22|       6|       5|       8|    6|     3.1|      18|
|    2| Austin L. Adams02   |   27| WSN |   1.0|    2|    2|    0|    0|    0|      0|    0|    0|     |      0|     0|    2|    1| 50% |     10|  1.503|      1|      0|      0|    1|    1|    0|     1|     1|       0|       1|       0|    0|     1.5|      12|
|    3| Chance Adams01      |   23| NYY |   7.2|    3|    2|    1|    0|    0|      0|    0|    0|     |      0|     0|    0|    0|     |      8|  0.358|      0|      0|      1|    0|    0|    2|     0|     2|       1|       0|       1|    0|     4.0|      35|
|    4| Matt Albers01       |   35| MIL |  34.1|   34|   34|   10|    3|    3|      2|    1|    1| 50% |      9|     7|   16|    8| 50% |      9|  1.236|     12|      7|     14|   17|    8|    9|     9|    25|       8|      10|      10|    5|     3.0|      20|
|    5| Victor Alcantara01  |   25| DET |  30.0|   27|   27|    8|    1|    1|      0|    0|    0|     |      3|     3|   13|    3| 23% |      7|  0.693|      6|      5|     15|    6|    3|   18|     6|    21|       7|       3|       7|    2|     3.3|      16|
|    6| Scott Alexander\*02 |   28| LAD |  66.0|   73|   71|    8|    2|    1|      6|    3|    3| 50% |     28|    21|   27|    7| 26% |      8|  1.359|     28|     23|     20|   37|   13|   21|    18|    53|      11|      23|      12|   19|     2.6|      13|
|    7| Kolby Allard\*01    |   20| ATL |   8.0|    3|    2|    0|    0|    1|      0|    0|    0|     |      0|     0|    0|    0|     |      8|  0.926|      0|      1|      1|    0|    1|    1|     0|     2|       1|       0|       1|    0|     4.5|      40|
|    8| Cody Allen01        |   29| CLE |  67.0|   70|   70|   45|    4|    6|     32|   27|    5| 84% |     39|     7|   24|    7| 29% |      9|  1.809|     40|     11|     17|   53|   12|    5|    18|    52|      12|      16|      14|   18|     2.9|      17|
|    9| Miguel Almonte01    |   25| LAA |   7.0|    8|    8|    4|    0|    0|      0|    0|    0|     |      0|     0|    2|    0| 0%  |      8|  0.179|      1|      0|      6|    2|    0|    6|     1|     7|       0|       1|       1|    0|     2.6|      17|
|   10| Yency Almonte01     |   24| COL |  14.2|   14|   14|    3|    0|    0|      0|    0|    0|     |      3|     3|   10|    8| 80% |      8|  0.450|      2|      4|      8|    7|    1|    6|     6|     8|       4|       6|       4|    1|     3.1|      18|

#### Starting pitching

One thing you'll notice in the starting pitching table is that there are three lines for Matt Andriese - he was traded midseason. The only row we care about is the total row, so we'll filter for those later.

``` r
start_pitching[1:10,] %>% kable()
```

|   Rk| Name                |  Age| Tm  |     IP|    G|   GS|  Wgs|  Lgs|   ND|  Wchp|  Ltuf|  Wtm|  Ltm|  tmW-L%|  Wlst|  Lsv|   CG|  SHO|   QS| QS% |  GmScA|  Best|  Wrst|  BQR|  BQS|  sDR|  lDR|  RS/GS|  RS/IP|  IP/GS|  Pit/GS|  &lt;80|  80-99|  100-119|  â‰¥120|  Max|
|----:|:--------------------|----:|:----|------:|----:|----:|----:|----:|----:|-----:|-----:|----:|----:|-------:|-----:|----:|----:|----:|----:|:----|------:|-----:|-----:|----:|----:|----:|----:|------:|------:|------:|-------:|-------:|------:|--------:|-------:|----:|
|    1| Chance Adams01      |   23| NYY |    7.2|    3|    1|    0|    1|    0|     0|     0|    0|    1|   0.000|     0|    0|    0|    0|    0| 0%  |   50.0|    50|    50|    2|    0|    0|    1|    1.0|    0.0|    5.0|      83|       0|      1|        0|       0|   83|
|    2| Sandy Alcantara01   |   22| MIA |   34.0|    6|    6|    2|    3|    1|     1|     1|    2|    4|   0.333|     1|    0|    0|    0|    3| 50% |   54.5|    75|    22|    2|    0|    0|    5|    3.1|    3.3|    5.7|      95|       0|      6|        0|       0|   99|
|    3| Scott Alexander\*02 |   28| LAD |   66.0|   73|    1|    0|    0|    1|     0|     0|    1|    0|   1.000|     0|    0|    0|    0|    0| 0%  |   53.0|    59|    47|   13|    5|    2|    0|   11.0|    6.8|    1.7|      21|       2|      0|        0|       0|   23|
|    4| Kolby Allard\*01    |   20| ATL |    8.0|    3|    1|    1|    0|    0|     1|     0|    1|    0|   1.000|     0|    0|    0|    0|    0| 0%  |   30.0|    30|    30|    2|    1|    0|    1|   12.4|   14.3|    5.0|      81|       0|      1|        0|       0|   81|
|    5| Brett Anderson\*04  |   30| OAK |   80.1|   17|   17|    4|    5|    8|     1|     0|    8|    9|   0.471|     1|    2|    0|    0|    6| 35% |   48.3|    80|     4|   13|    3|    0|   12|    4.2|    4.7|    4.7|      71|       9|      8|        0|       0|   97|
|    6| Chase Anderson01    |   30| MIL |  158.0|   30|   30|    9|    8|   13|     3|     2|   16|   14|   0.533|     4|    3|    0|    0|   11| 37% |   52.4|    79|    29|   20|    8|    0|   16|    4.6|    4.1|    5.3|      87|       7|     20|        3|       0|  107|
|    7| Drew Anderson02     |   24| PHI |   12.2|    5|    1|    0|    1|    0|     0|     0|    0|    1|   0.000|     0|    0|    0|    0|    0| 0%  |   38.0|    38|    38|    0|    0|    0|    1|    1.0|    1.8|    5.0|      94|       0|      1|        0|       0|   94|
|    8| Tyler Anderson\*01  |   28| COL |  176.0|   32|   32|    7|    9|   16|     1|     1|   12|   20|   0.375|     7|    1|    0|    0|   16| 50% |   51.3|    85|    14|   28|    8|    0|   19|    4.3|    4.4|    5.5|      89|       4|     20|        8|       0|  109|
|    9| Matt Andriese01     |   28| TOT |   78.2|   41|    5|    0|    1|    4|     0|     0|    2|    3|   0.400|     0|    0|    0|    0|    0| 0%  |   47.6|    59|    30|   17|    9|    3|    2|    4.0|    7.4|    2.7|      51|       5|      0|        0|       0|   61|
|   10| Matt Andriese01     |   28| TBR |   59.2|   27|    4|    0|    0|    4|     0|     0|    2|    2|   0.500|     0|    0|    0|    0|    0| 0%  |   52.0|    59|    40|   14|    7|    3|    1|    4.7|    8.5|    2.8|      48|       4|      0|        0|       0|   58|

#### Cleaning the data and putting it all together

As mentioned previously, we need to find all the players that have been traded so that we don't end up with multiple records for the same player. The standard pitching table has everybody included in it. Conveniently, it also always lists the "Total" row first, so we can use a trick to get just the first row for each name. We'll need to do this for all of our data tables.

``` r
tot_all_pitchers <- std_pitching[, .SD[1], by = Name]
tot_rel_pitchers <- rel_pitching[, .SD[1], by = Name]
tot_start_pitchers <- start_pitching[, .SD[1], by = Name]
```

Next we'll need to filter our relief and starting pitcher tables down to just the columns that we're intersted in, Holds and QS, respectively.

``` r
hold_rel_pitchers <- tot_rel_pitchers[, .(Name, Hold, BSv)]
qs_start_pitchers <- tot_start_pitchers[, .(Name, QS)]
```

Lastly we set keys for the data tables and join them all together:

``` r
setkey(tot_all_pitchers, "Name")
setkey(hold_rel_pitchers, "Name")
setkey(qs_start_pitchers, "Name")

full_pitchers <- hold_rel_pitchers[qs_start_pitchers[tot_all_pitchers]]
```

Here's what our new data table looks like:

``` r
full_pitchers[1:10,] %>% kable()
```

| Name              |  Hold|  BSv|   QS|   Rk|  Age| Tm  | Lg  |    W|    L|   W-L%|    ERA|    G|   GS|   GF|   CG|  SHO|   SV|     IP|    H|    R|   ER|   HR|   BB|  IBB|   SO|  HBP|   BK|   WP|   BF|  ERA+|   FIP|   WHIP|    H9|  HR9|  BB9|   SO9|  SO/W|
|:------------------|-----:|----:|----:|----:|----:|:----|:----|----:|----:|------:|------:|----:|----:|----:|----:|----:|----:|------:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|-----:|-----:|------:|-----:|----:|----:|-----:|-----:|
| A.J. Cole01       |     0|    1|    0|  167|   26| TOT | MLB |    4|    2|  0.667|   6.14|   32|    2|   14|    0|    0|    0|   48.1|   55|   38|   33|   15|   22|    1|   59|    0|    0|    2|  221|    71|  6.12|  1.593|  10.2|  2.8|  4.1|  11.0|  2.68|
| A.J. Minter\*01   |    12|    2|   NA|  617|   24| ATL | NL  |    4|    3|  0.571|   3.23|   65|    0|   31|    0|    0|   15|   61.1|   57|   23|   22|    3|   22|    1|   69|    2|    0|    5|  260|   126|  2.72|  1.288|   8.4|  0.4|  3.2|  10.1|  3.14|
| AJ Ramos01        |     7|    0|   NA|  727|   31| NYM | NL  |    2|    2|  0.500|   6.41|   28|    0|    5|    0|    0|    0|   19.2|   17|   14|   14|    3|   15|    0|   22|    0|    0|    1|   88|    58|  5.19|  1.627|   7.8|  1.4|  6.9|  10.1|  1.47|
| Aaron Brooks01    |     0|    0|   NA|  112|   28| OAK | AL  |    0|    0|     NA|   0.00|    3|    0|    2|    0|    0|    0|    2.2|    1|    0|    0|    0|    2|    0|    1|    0|    0|    0|   10|    NA|  4.66|  1.125|   3.4|  0.0|  6.8|   3.4|  0.50|
| Aaron Bummer\*01  |     2|    1|   NA|  118|   24| CHW | AL  |    0|    1|  0.000|   4.26|   37|    0|    9|    0|    0|    0|   31.2|   40|   19|   15|    1|   10|    0|   35|    1|    1|    7|  144|    99|  2.40|  1.579|  11.4|  0.3|  2.8|   9.9|  3.50|
| Aaron Loup\*01    |    11|    0|   NA|  543|   30| TOT | MLB |    0|    0|     NA|   4.54|   59|    0|    8|    0|    0|    0|   39.2|   48|   23|   20|    4|   14|    0|   44|    4|    0|    0|  183|    94|  3.61|  1.563|  10.9|  0.9|  3.2|  10.0|  3.14|
| Aaron Nola01      |    NA|   NA|   25|  646|   25| PHI | NL  |   17|    6|  0.739|   2.37|   33|   33|    0|    0|    0|    0|  212.1|  149|   57|   56|   17|   58|    3|  224|    7|    1|    4|  831|   175|  3.01|  0.975|   6.3|  0.7|  2.5|   9.5|  3.86|
| Aaron Sanchez01   |    NA|   NA|    9|  797|   25| TOR | AL  |    4|    6|  0.400|   4.89|   20|   20|    0|    0|    0|    0|  105.0|  106|   62|   57|   11|   58|    2|   86|    7|    0|    4|  474|    86|  4.74|  1.562|   9.1|  0.9|  5.0|   7.4|  1.48|
| Aaron Slegers01   |     0|    0|    1|  833|   25| MIN | AL  |    1|    1|  0.500|   5.27|    4|    2|    1|    0|    0|    0|   13.2|   17|    8|    8|    3|    2|    0|    6|    1|    0|    0|   60|    85|  5.80|  1.390|  11.2|  2.0|  1.3|   4.0|  3.00|
| Aaron Wilkerson01 |     0|    0|    0|  958|   29| MIL | NL  |    0|    1|  0.000|  10.00|    3|    1|    2|    0|    0|    0|    9.0|   12|   10|   10|    4|    3|    0|   10|    1|    0|    0|   43|    42|  8.05|  1.667|  12.0|  4.0|  3.0|  10.0|  3.33|

Now we need to clean up the NA's, since that'll cause us problems when we try to generate point totals. We can infer that these should be 0's if they don't exist .

``` r
# Thanks Matt Dowle
# https://stackoverflow.com/questions/7235657/fastest-way-to-replace-nas-in-a-large-data-table
# plaigarism is bad

cleandt <- function(DT) {
for (j in seq_len(ncol(DT)))
  set(DT, which(is.na(DT[[j]])),j,0)
}

cleandt(full_pitchers)
```

The purpose of this is to compare how much better relievers get, so we need to devise a way to make sure that we track what position a player falls into.

``` r
# If a pitcher is not in starting pitcher table label as a reliever
# If a pitcher is in starting pitching and in relieving, label as both
# Otherwise label as starter
full_pitchers[, pos:= ifelse(!Name %in% qs_start_pitchers$Name, "RP",
                              ifelse(Name %in% hold_rel_pitchers$Name, "RP/SP",
                                     "SP"))]
```

### Analysis

Next up we need to generate point totals for both scoring systems.

We'll do this by taking the columns that line up with our scoring system, turning our data table into a matrix, and then multiplying it by our score vector. It's a neat trick.

``` r
# prepoints are scores prior to the scoring change
full_pitchers[, prepoints := 
                full_pitchers[, names(pt_vals), with = FALSE] %>%
                as.matrix() %*% pt_vals]

# postpoints are scores post scoring change
full_pitchers[, postpoints := 
                full_pitchers[, names(pt_vals), with = FALSE] %>%
                as.matrix() %*% pt_edit]

# point change is difference
full_pitchers[, ptchange := postpoints - prepoints]
```

#### Comparing before and after

With scores calculated, what's left is to assess how things changed.

First we'll take a look at how the composition of the top pitchers ranked.

For the purpose of tracking fringe pitchers, we'll look at the top 120 before and after (12 pitchers/team).

| .     |  Freq|
|:------|-----:|
| RP    |    18|
| RP/SP |    32|
| SP    |    70|

| .     |  Freq|
|:------|-----:|
| RP    |    29|
| RP/SP |    28|
| SP    |    63|

Here are the interesting findings: players that enter and leave the top 120.

The relievers that enter the top 120:

| Name                   |  Hold|  BSv|   QS|   Rk|  Age| Tm  | Lg  |    W|    L|   W-L%|   ERA|    G|   GS|   GF|   CG|  SHO|   SV|    IP|    H|    R|   ER|   HR|   BB|  IBB|   SO|  HBP|   BK|   WP|   BF|  ERA+|   FIP|   WHIP|   H9|  HR9|  BB9|   SO9|   SO/W| pos   |  prepoints|  postpoints|  ptchange|  prerank|  postrank|  rankchange|
|:-----------------------|-----:|----:|----:|----:|----:|:----|:----|----:|----:|------:|-----:|----:|----:|----:|----:|----:|----:|-----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|-----:|-----:|------:|----:|----:|----:|-----:|------:|:------|----------:|-----------:|---------:|--------:|---------:|-----------:|
| Archie Bradley01       |    34|    8|    0|  101|   25| ARI | NL  |    4|    5|  0.444|  3.64|   76|    0|    8|    0|    0|    3|  71.2|   62|   30|   29|    9|   20|    1|   75|    4|    1|    2|  296|   119|  3.71|  1.144|  7.8|  1.1|  2.5|   9.4|   3.75| RP    |      271.6|       345.6|        74|    153.5|     108.0|        45.5|
| Cody Allen01           |     7|    5|    0|    9|   29| CLE | AL  |    4|    6|  0.400|  4.70|   70|    0|   45|    0|    0|   27|  67.0|   58|   35|   35|   11|   33|    2|   80|    4|    0|    3|  289|    93|  4.56|  1.358|  7.8|  1.5|  4.4|  10.7|   2.42| RP    |      294.0|       362.0|        68|    124.5|      95.0|        29.5|
| Dellin Betances01      |    20|    3|    0|   78|   30| NYY | AL  |    4|    6|  0.400|  2.70|   66|    0|   15|    0|    0|    4|  66.2|   44|   22|   20|    7|   26|    2|  115|    5|    1|    4|  272|   162|  2.47|  1.050|  5.9|  0.9|  3.5|  15.5|   4.42| RP    |      291.6|       339.6|        48|    127.0|     115.0|        12.0|
| Fernando Rodney01      |     7|    7|    0|  751|   41| TOT | AL  |    4|    3|  0.571|  3.36|   68|    0|   40|    0|    0|   25|  64.1|   62|   27|   24|    7|   32|    1|   70|    3|    0|    6|  285|   129|  4.03|  1.461|  8.7|  1.0|  4.5|   9.8|   2.19| RP    |      277.3|       341.3|        64|    142.5|     113.0|        29.5|
| Jose Alvarado\*03      |    32|    4|    0|   13|   23| TBR | AL  |    1|    6|  0.143|  2.39|   70|    0|   17|    0|    0|    8|  64.0|   42|   21|   17|    1|   29|    4|   80|    1|    0|    2|  263|   174|  2.27|  1.109|  5.9|  0.1|  4.1|  11.3|   2.76| RP    |      294.0|       374.0|        80|    124.5|      91.0|        33.5|
| Jose Leclerc01         |    15|    4|    0|  520|   24| TEX | AL  |    2|    3|  0.400|  1.56|   59|    0|   21|    0|    0|   12|  57.2|   24|   16|   10|    1|   25|    1|   85|    3|    0|    2|  223|   311|  1.90|  0.850|  3.7|  0.2|  3.9|  13.3|   3.40| RP    |      288.6|       342.6|        54|    129.0|     112.0|        17.0|
| Sean Doolittle\*01     |     1|    1|    0|  229|   31| WSN | NL  |    3|    3|  0.500|  1.60|   43|    0|   35|    0|    0|   25|  45.0|   21|    8|    8|    3|    6|    1|   60|    2|    0|    1|  163|   267|  1.89|  0.600|  4.2|  0.6|  1.2|  12.0|  10.00| RP    |      289.0|       341.0|        52|    128.0|     114.0|        14.0|
| Seranthony Dominguez01 |    14|    4|    0|  228|   23| PHI | NL  |    2|    5|  0.286|  2.95|   53|    0|   24|    0|    0|   16|  58.0|   32|   19|   19|    4|   22|    2|   74|    4|    0|   10|  231|   142|  2.85|  0.931|  5.0|  0.6|  3.4|  11.5|   3.36| RP    |      276.0|       336.0|        60|    145.0|     117.0|        28.0|
| Sergio Romo01          |     8|    8|    0|  771|   35| TBR | AL  |    3|    4|  0.429|  4.14|   73|    5|   39|    0|    0|   25|  67.1|   65|   31|   31|   11|   20|    0|   75|    2|    0|    2|  284|   101|  4.04|  1.262|  8.7|  1.5|  2.7|  10.0|   3.75| RP/SP |      286.3|       352.3|        66|    133.0|     102.0|        31.0|
| Shane Greene02         |     0|    6|    0|  366|   29| DET | AL  |    4|    6|  0.400|  5.12|   66|    0|   58|    0|    0|   32|  63.1|   68|   39|   36|   12|   19|    1|   65|    3|    0|    3|  279|    86|  4.61|  1.374|  9.7|  1.7|  2.7|   9.2|   3.42| RP    |      272.3|       336.3|        64|    152.0|     116.0|        36.0|
| Steve Cishek01         |    25|    3|    0|  161|   32| CHC | NL  |    4|    3|  0.571|  2.18|   80|    0|   10|    0|    0|    4|  70.1|   45|   19|   17|    5|   28|    4|   78|    9|    0|    2|  288|   197|  3.45|  1.038|  5.8|  0.6|  3.6|  10.0|   2.79| RP    |      286.3|       344.3|        58|    133.0|     110.5|        22.5|
| Yoshihisa Hirano01     |    32|    4|    0|  429|   34| ARI | NL  |    4|    3|  0.571|  2.44|   75|    0|   10|    0|    0|    3|  66.1|   49|   22|   18|    6|   23|    4|   59|    2|    1|    6|  262|   178|  3.69|  1.085|  6.6|  0.8|  3.1|   8.0|   2.57| RP    |      275.3|       345.3|        70|    146.0|     109.0|        37.0|

And the other pitchers that leave:

| Name                  |  Hold|  BSv|   QS|   Rk|  Age| Tm  | Lg  |    W|    L|   W-L%|   ERA|    G|   GS|   GF|   CG|  SHO|   SV|     IP|    H|    R|   ER|   HR|   BB|  IBB|   SO|  HBP|   BK|   WP|   BF|  ERA+|   FIP|   WHIP|    H9|  HR9|  BB9|  SO9|  SO/W| pos   |  prepoints|  postpoints|  ptchange|  prerank|  postrank|  rankchange|
|:----------------------|-----:|----:|----:|----:|----:|:----|:----|----:|----:|------:|-----:|----:|----:|----:|----:|----:|----:|------:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|-----:|-----:|------:|-----:|----:|----:|----:|-----:|:------|----------:|-----------:|---------:|--------:|---------:|-----------:|
| Chris Stratton01      |     0|    0|   12|  869|   27| SFG | NL  |   10|   10|  0.500|  5.09|   28|   26|    1|    1|    1|    0|  145.0|  153|   87|   82|   19|   54|    1|  112|    2|    0|    6|  625|    76|  4.48|  1.428|   9.5|  1.2|  3.4|  7.0|  2.07| RP/SP |      312.0|       312.0|         0|    110.0|     139.0|       -29.0|
| Clay Buchholz01       |     0|    0|   10|  114|   33| ARI | NL  |    7|    2|  0.778|  2.01|   16|   16|    0|    1|    0|    0|   98.1|   80|   25|   22|    9|   22|    1|   81|    3|    0|    1|  393|   215|  3.47|  1.037|   7.3|  0.8|  2.0|  7.4|  3.68| RP/SP |      307.3|       307.3|         0|    115.0|     143.0|       -28.0|
| Danny Duffy\*01       |     0|    0|   10|  239|   29| KCR | AL  |    8|   12|  0.400|  4.88|   28|   28|    0|    0|    0|    0|  155.0|  161|   86|   84|   23|   70|    1|  141|    4|    0|   14|  692|    88|  4.70|  1.490|   9.3|  1.3|  4.1|  8.2|  2.01| SP    |      321.0|       321.0|         0|    107.0|     132.0|       -25.0|
| Dereck Rodriguez01    |     0|    0|   14|  755|   26| SFG | NL  |    6|    4|  0.600|  2.81|   21|   19|    1|    0|    0|    0|  118.1|   98|   43|   37|    9|   36|    2|   89|    7|    0|    1|  487|   138|  3.74|  1.132|   7.5|  0.7|  2.7|  6.8|  2.47| RP/SP |      325.3|       325.3|         0|    104.0|     131.0|       -27.0|
| Jaime Barria01        |     0|    0|    5|   54|   21| LAA | AL  |   10|    9|  0.526|  3.41|   26|   26|    0|    0|    0|    0|  129.1|  117|   50|   49|   17|   47|    0|   98|    6|    1|    3|  537|   122|  4.58|  1.268|   8.1|  1.2|  3.3|  6.8|  2.09| SP    |      304.3|       304.3|         0|    117.0|     146.5|       -29.5|
| Jordan Zimmermann02   |     0|    0|    8|  988|   32| DET | AL  |    7|    8|  0.467|  4.52|   25|   25|    0|    0|    0|    0|  131.1|  140|   76|   66|   28|   26|    0|  111|    2|    0|    1|  556|    97|  4.88|  1.264|   9.6|  1.9|  1.8|  7.6|  4.27| SP    |      305.3|       305.3|         0|    116.0|     145.0|       -29.0|
| Junior Guerra02       |     1|    0|   10|  375|   33| MIL | NL  |    6|    9|  0.400|  4.09|   31|   26|    1|    0|    0|    0|  141.0|  143|   74|   64|   19|   55|    0|  136|    4|    0|   11|  611|   100|  4.24|  1.404|   9.1|  1.2|  3.5|  8.7|  2.47| RP/SP |      329.0|       331.0|         2|    103.0|     124.5|       -21.5|
| Lucas Giolito01       |     0|    0|   15|  335|   23| CHW | AL  |   10|   13|  0.435|  6.13|   32|   32|    0|    0|    0|    0|  173.1|  166|  123|  118|   27|   90|    2|  125|   15|    0|   13|  775|    68|  5.56|  1.477|   8.6|  1.4|  4.7|  6.5|  1.39| SP    |      311.3|       311.3|         0|    112.5|     141.0|       -28.5|
| Madison Bumgarner\*01 |     0|    0|   14|  117|   28| SFG | NL  |    6|    7|  0.462|  3.26|   21|   21|    0|    0|    0|    0|  129.2|  118|   51|   47|   14|   43|    3|  109|    5|    1|    3|  551|   119|  3.99|  1.242|   8.2|  1.0|  3.0|  7.6|  2.53| SP    |      334.6|       334.6|         0|    100.0|     121.0|       -21.0|
| Shane Bieber01        |     0|    0|    8|   83|   23| CLE | AL  |   11|    5|  0.688|  4.55|   20|   19|    0|    0|    0|    0|  114.2|  130|   60|   58|   13|   23|    0|  118|    2|    0|    5|  485|    96|  3.23|  1.334|  10.2|  1.0|  1.8|  9.3|  5.13| RP/SP |      311.6|       311.6|         0|    111.0|     140.0|       -29.0|
| Tyler Skaggs\*01      |     0|    0|   11|  831|   26| LAA | AL  |    8|   10|  0.444|  4.02|   24|   24|    0|    0|    0|    0|  125.1|  127|   60|   56|   14|   40|    0|  129|    5|    0|    2|  533|   103|  3.63|  1.332|   9.1|  1.0|  2.9|  9.3|  3.23| SP    |      319.3|       319.3|         0|    108.0|     134.5|       -26.5|
| Zach Eflin01          |     0|    0|    9|  248|   24| PHI | NL  |   11|    8|  0.579|  4.36|   24|   24|    0|    0|    0|    0|  128.0|  130|   69|   62|   16|   37|    4|  123|    3|    0|    4|  548|    95|  3.80|  1.305|   9.1|  1.1|  2.6|  8.6|  3.32| SP    |      333.0|       333.0|         0|    101.0|     122.0|       -21.0|

Within the new top 120, it's also worth looking at where the pitchers are by percentile.

#### Graph time

![](HoldSaveNotebook_files/figure-markdown_github/unnamed-chunk-21-1.png)![](HoldSaveNotebook_files/figure-markdown_github/unnamed-chunk-21-2.png)

![](HoldSaveNotebook_files/figure-markdown_github/unnamed-chunk-22-1.png)![](HoldSaveNotebook_files/figure-markdown_github/unnamed-chunk-22-2.png)

As shown in the plots above, relievers gain quite a bit in points here: Before the change, here's how the top relievers points broke down:

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   299.0   329.5   372.6   382.1   413.6   625.0

*This does include dual type pitchers, as they likely will have RP eligibility.* *This causes some problems because Trevor Bauer is one of these.*

And here is the after:

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   335.0   351.6   381.6   404.6   442.6   638.3

### Conclusion

Adding points for holds and saves is probably a good idea. It should make relievers comparable with many of the streamers/fringe starters as well as move some of the elite relievers further up into the pitcher pool.

Importantly, this shouldn't disturb the balance of pitcher/hitter value by much.

Prior to any scoring change, and assuming the top 120 pitchers are rostered (and perfectly average, so yeah it's a lot of assumptions but come on what else can we do), each team nets roughly 213 points per week from pitching:

``` r
#sum all points and divide by 25 weeks * 10 teams
top_pre_pitchers$prepoints %>% sum() / (25*10)
```

    ## [1] 212.7132

With the change, teams would on average gain about 7 points per week:

``` r
#do the same thing as before
top_post_pitchers$postpoints %>% sum() / (25*10)
```

    ## [1] 219.6264

This seems like a pretty reasonable update to make. If you would like to look at the data yourself, I have the csv files used to generate this data located here: [link](https://github.com/hshipper/fantasysports)
