%let pgm=utl-altair-slc-free-unlimited-geofencing-geocoding-reverse-geocoding-all-I32-million-us-addresses;

%stop_submission;

Altair slc free unlimited geofencing geocoding reverse geocoding all I32 million us addresses

Too long to post on a list, see github
https://github.com/rogerjdeangelis/utl-altair-slc-free-unlimited-geofencing-geocoding-reverse-geocoding-all-I32-million-us-addresses

Problem
Use geo fencing to find all addresses in a latitude longitude quadrangle reverse geocoding.

/**************************************************************************************************************************/
/* CREATE THIS OUTPUT                                                                                                     */
/* The PLOT Procedure                                                                                                     */
/*                    Plot of AVGLAT*AVGLON. Symbol used is '*'.                                                          */
/*                                                                                                                        */
/*                                      LONGITUDE                                                                         */
/*       -121.831     -121.8308    -121.8306    -121.8304    -121.8302     -121.83                                        */
/*          -+------------+------------+------------+------------+------------+-                                          */
/*   AVGLAT |                                                                  |   AVGLAT                                 */
/*          |                                                                  |                                          */
/*          |          LTR      ADDRESSES                                      |                                          */
/*          |                                     * 07                     * 02|                                          */
/*  37.2418 +   * 01    01 2 CALERO AVE 95123                  * 04            +  37.2418                                 */
/*          |   * 11    02 490 CALERO AVE 95123                                |                                          */
/*  37.2417 +           03 491 SHAWNEE LN 95123                                +  37.2417                                 */
/*          |           04 494 CALERO AVE 95123                                |                                          */
/*  37.2416 +           05 494 SHAWNEE LN 95123                                +  37.2416                                 */
/*          |           06 495 SHAWNEE LN 95123                 * 06       * 03|                                          */
/*  37.2415 +   * 10    07 498 CALERO AVE 95123    * 09                        +  37.2415                                 */
/*          |           08 498 SHAWNEE LN 95123                                |                                          */
/*  37.2414 +           09 499 SHAWNEE LN 95123         GEO FENCE              +  37.2414                                 */
/*          |           10 501 SHAWNEE LN 95123        LAT        LON          |                                          */
/*  37.2413 +           11 502 CALERO AVE 95123                                +  37.2413                                 */
/*          |                                        37.242    -121.830        |                                          */
/*  37.2412 +                                        37.242    -121.831        +  37.2412                                 */
/*          |                                        37.241    -121.830        |                                          */
/*  37.2411 +              * 08           * 05       37.241    -121.831        +  37.2411                                 */
/*          |                                                                  |                                          */
/*   37.241 +                                                                  +   37.241                                 */
/*          -+------------+------------+------------+------------+------------+-                                          */
/*       -121.831     -121.8308    -121.8306    -121.8304    -121.8302     -121.83                                        */
/*                                       LONGITUDE                                                                        */
/**************************************************************************************************************************/

  PREPARATION

    MANUAL OPERATIONS

      A  FOLDERS

         d:/exe - where I put the downloaded adr_fix132e6.exe (self extracting ultr 7-zip)
         d:/csv - where I save the unzipped file (ulta 7-zip self extracting executable)
         d:/sd1 - where I save the addreess database ib d:/sd1/adr_010adrlonlatfmt.wpd
         d:/sd1 - where I save the geo-fence output in havGps.sas7bdat and havGps.wpd

      B  download adr_fix132e6.exe 1432 million addresses (1.45gb win10) into d:/adr/exe/adr_fix132e6.exe (10gb unzipped)

         Same csv file (just belt and suspenders -
         https://1drv.ms/u/c/bb0f3c4c9b1dc58b/EeJAnwdAgy9Oo1C4IIzf_VIBVcUhQGZRHBZZ2ulv0gICSQ?e=LXtbdk

         https://drive.google.com/file/d/1j3u9g9X4t5GYoz4O62oEs63RVp_qSlhq/view?usp=drive_link
         https://www.dropbox.com/scl/fi/hijvujwjotftaqiu93dgt/adr_fix132e6.exe?rlkey=efa8b49x52tpc25kz1vloc06g&st=f8insd26&dl=0

      C  Unzip the self extracting 7-zip file you downloaded save in d:/csv/adr_fix132e6.csv
         Just click on the exe file (131,789,977 records)
         Be patient you may need to allow win 11 to run the self extrating zip.
         This takes a couple of minutes

  PROCESS

      1  input csv and geo fence
      2  Convert csv to wpd dataset (wpd datasets are faster than sas datasets?)
      3  Find all addresses in the fence
      4  Related repos use the new database from this repo


/*   _                   _                      ___      __
/ | (_)_ __  _ __  _   _| |_    ___ _____   __ ( _ )    / _| ___ _ __   ___ ___
| | | | `_ \| `_ \| | | | __|  / __/ __\ \ / / / _ \/\ | |_ / _ \ `_ \ / __/ _ \
| | | | | | | |_) | |_| | |_  | (__\__ \\ V / | (_>  < |  _|  __/ | | | (_|  __/
|_| |_|_| |_| .__/ \__,_|\__|  \___|___/ \_/   \___/\/ |_|  \___|_| |_|\___\___|
            |_|
  ___ _____   __
 / __/ __\ \ / /
| (__\__ \\ V /
 \___|___/ \_/

*/

data _null_;
 infile "d:/csv/adr_fix132e6.csv";
 input;
 put _infile_;
 if _n_=11 then stop;
run;quit;

/**************************************************************************************************************************/
/* d:/adr/csv/d:/adr/csv/adr_fix132e6.csv  (131,789,977 records)                                                          */
/*                                                                                                                        */
/* MATCHCODE,ZIP4,STATE,ADR,AVGLON,AVGLAT                                                                                 */
/* 0008SCOUNTYRD50W46701,4670,IN,0008 S COUNTY RD 50 W 46701,-85.44081,41.3513                                            */
/* 0009ECOUNTYRD1050N46784,4678,IN,0009 E COUNTY RD 1050 N 46784,-85.42322,41.50108                                       */
/* 000BELLVALERD07046,0704,NJ,000 BELLVALE RD 07046,-74.42985,40.89064                                                    */
/* 0010NCOUNTYRD375W46701,4670,IN,0010 N COUNTY RD 375 W 46701,-85.4898,41.35255                                          */
/* 0010WCOUNTYRD900N46794,4679,IN,0010 W COUNTY RD 900 N 46794,-85.42382,41.48246                                         */
/* 00126THST07410,0741,NJ,001 26TH ST 07410,-74.10739,40.91937                                                            */
/* 00127THST07410,0741,NJ,001 27TH ST 07410,-74.10657,40.91959                                                            */
/* 00128THST07410,0741,NJ,001 28TH ST 07410,-74.1057,40.91983                                                             */
/* 00129THST07410,0741,NJ,001 29TH ST 07410,-74.10483,40.92009                                                            */
/* 0012ANTHONYPL02840,0284,RI,0012 ANTHONY PL 02840,-71.31617,41.47072                                                    */
/**************************************************************************************************************************/

/*                   __                       _                   _
  __ _  ___  ___    / _| ___ _ __   ___ ___  (_)_ __  _ __  _   _| |_
 / _` |/ _ \/ _ \  | |_ / _ \ `_ \ / __/ _ \ | | `_ \| `_ \| | | | __|
| (_| |  __/ (_) | |  _|  __/ | | | (_|  __/ | | | | | |_) | |_| | |_
 \__, |\___|\___/  |_|  \___|_| |_|\___\___| |_|_| |_| .__/ \__,_|\__|
 |___/                                               |_|
*/

libname sd1 wpd "d:/sd1";

data sd1.havGps ;
  length intlatlon $8;
  input lat lon;
  intlatlon = cats(put(int(lat),z4.),put(int(lon),z4.));
keep lat lon intlatlon;
cards4;
37.242 -121.830
37.242 -121.831
37.241 -121.830
37.241 -121.831
;;;;
run;quit;

/**************************************************************************************************************************/
/*  SD1.HAVGPS total obs=4                                                                                                */
/*                                                                                                                        */
/* Obs    INTLATLON      LAT        LON                                                                                   */
/*                                                                                                                        */
/*  1     0037-121     37.242    -121.830                                                                                 */
/*  2     0037-121     37.242    -121.831                                                                                 */
/*  3     0037-121     37.241    -121.830                                                                                 */
/*                                                                                                                        */
/*  INLATLON (used to speedup lookups)                                                                                    */
/**************************************************************************************************************************/

/*___                                  _                                         _       _       _                 _
|___ \    ___ ___  _ ____   _____ _ __| |_    ___ _____   __ __      ___ __   __| |   __| | __ _| |_ __ _ ___  ___| |_
  __) |  / __/ _ \| `_ \ \ / / _ \ `__| __|  / __/ __\ \ / / \ \ /\ / / `_ \ / _` |  / _` |/ _` | __/ _` / __|/ _ \ __|
 / __/  | (_| (_) | | | \ V /  __/ |  | |_  | (__\__ \\ V /   \ V  V /| |_) | (_| | | (_| | (_| | || (_| \__ \  __/ |_
|_____|  \___\___/|_| |_|\_/ \___|_|   \__|  \___|___/ \_/     \_/\_/ | .__/ \__,_|  \__,_|\__,_|\__\__,_|___/\___|\__|
                                                                      |_|
*/

/*--- BE PATIENT MODERATE SIZE DATA ---*/

libname adr wpd "d:/sd1";

data adr.adr_010adrlonlatfmt(compress=char);
   infile 'd:/adr/csv/adr_fix132e6.csv'
      /*---- SKIP FIRST ROW ----*/
      firstobs=2 delimiter=',' DSD lrecl=32767;
   informat MATCHCODE $64. ;
   informat ZIP4 $4. ;
   informat STATE $2. ;
   informat ADR $64. ;
   informat AVGLAT best12. ;
   informat AVGLON best12. ;
   input
      MATCHCODE
      ZIP4
      STATE
      ADR
      AVGLON
      AVGLAT
   ;
   if mod(_n_,10000000)=0 then put _n_ comma15.;
run;quit;

libname adr wpd "d:/sd1";
proc print data=adr.adr_010adrlonlatfmt(firstobs=5);
run;quit;

/**************************************************************************************************************************/
/* Altair SLC  adr.adr_010adrlonlatfmt (9,754,973,696 bytes)                                                              */
/*                                         FIRST                                                                          */
/* Obs           MATCHCODE                  ZIP4    STATE                 ADR                  AVGLAT      AVGLON         */
/*                                                                                                                        */
/*         1     0008SCOUNTYRD50W46701      4670     IN      0008 S COUNTY RD 50 W 46701      41.3513    -85.4408         */
/*         2     0009ECOUNTYRD1050N46784    4678     IN      0009 E COUNTY RD 1050 N 46784    41.5011    -85.4232         */
/*         3     000BELLVALERD07046         0704     NJ      000 BELLVALE RD 07046            40.8906    -74.4299         */
/*         4     0010NCOUNTYRD375W46701     4670     IN      0010 N COUNTY RD 375 W 46701     41.3526    -85.4898         */
/*         5     0010WCOUNTYRD900N46794     4679     IN      0010 W COUNTY RD 900 N 46794     41.4825    -85.4238         */
/*                                                                                                                        */
/*                                                                                                                        */
/* 131789973     ZCMNLOT1509589148          8914     NV      Z CMN LOT 15095 89148*           36.0564    -115.302         */
/* 131789974     ZCMNLOT1511289148          8914     NV      Z CMN LOT 15112 89148            36.0368    -115.296         */
/* 131789975     ZCMNLOT1516989135          8913     NV      Z CMN LOT 15169 89135            36.1055    -115.330         */
/* 131789976     ZCMNLOT1531489135          8913     NV      Z CMN LOT 15314 89135            36.1564    -115.342         */
/* 131789977     ZCMNLOT1534089148          8914     NV      Z CMN LOT 15340 89148            36.0668    -115.309         */
/*                                                                                                                        */
/* * Based on the format of the text, "Z CMN LOT 15095" is highly likely to be a lot number or internal identifier        */
/* used by the Clark County Assessor’s Office or the Las Vegas Township for property tax and parcel management.           */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC       08:25 Friday, February 20, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"
NOTE: Library workx assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\wpswrkx

NOTE: Library slchelp assigned as follows:
      Engine:        WPD
      Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp

NOTE: Library worksas assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\worksas

NOTE: Library workwpd assigned as follows:
      Engine:        WPD
      Physical Name: d:\workwpd


LOG:  8:25:58
NOTE: 1 record was written to file PRINT

NOTE: The data step took :
      real time : 0.031
      cpu time  : 0.015


NOTE: AUTOEXEC processing completed

1         libname adr wpd "d:/sd1";
NOTE: Library adr assigned as follows:
      Engine:        WPD
      Physical Name: d:\sd1

2
3         data adr.adr_010adrlonlatfmt(compress=char);
4            infile 'd:/csv/adr_fix132e6.csv'
5               /*---- SKIP FIRST ROW ----*/
6               firstobs=2 delimiter=',' DSD lrecl=32767;
7            informat MATCHCODE $64. ;
8            informat ZIP4 $4. ;
9            informat STATE $2. ;
10           informat ADR $64. ;
11           informat AVGLAT best12. ;
12           informat AVGLON best12. ;
13           input
14              MATCHCODE
15              ZIP4
16              STATE
17              ADR
18              AVGLON
19              AVGLAT
20           ;
21           if mod(_n_,10000000)=0 then put _n_ comma15.;
22        run;

NOTE: The infile 'd:\csv\adr_fix132e6.csv' is:
      Filename='d:\csv\adr_fix132e6.csv',
      Owner Name=SLC\suzie,
      File size (bytes)=9299808653,
      Create Time=08:21:54 Feb 20 2026,
      Last Accessed=08:22:48 Feb 20 2026,
      Last Modified=13:26:56 Mar 16 2025,
      Lrecl=32767, Recfm=V

     10,000,000
     20,000,000
     30,000,000
     40,000,000
     50,000,000
     60,000,000
     70,000,000
     80,000,000
     90,000,000
    100,000,000
    110,000,000
    120,000,000
    130,000,000
NOTE: 131789976 records were read from file 'd:\csv\adr_fix132e6.csv'
      The minimum record length was 32
      The maximum record length was 157
NOTE: Data set "ADR.adr_010adrlonlatfmt" has 131789976 observation(s) and 6 variable(s)
NOTE: Specifying compression for data set "ADR.adr_010adrlonlatfmt" has decreased
      its size from 4881112 to 2391351 pages (a 52% reduction)
NOTE: The data step took :
      real time : 5:41.814
      cpu time  : 5:29.390


22      !     quit;
23
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 5:41.893
      cpu time  : 5:29.437

/*____    __ _           _             _     _                          _          __
|___ /   / _(_)_ __   __| |   __ _  __| | __| |_ __ ___  ___  ___  ___ (_)_ __    / _| ___ _ __   ___ ___
  |_ \  | |_| | `_ \ / _` |  / _` |/ _` |/ _` | `__/ _ \/ __|/ _ \/ __|| | `_ \  | |_ / _ \ `_ \ / __/ _ \
 ___) | |  _| | | | | (_| | | (_| | (_| | (_| | | |  __/\__ \  __/\__ \| | | | | |  _|  __/ | | | (_|  __/
|____/  |_| |_|_| |_|\__,_|  \__,_|\__,_|\__,_|_|  \___||___/\___||___/|_|_| |_| |_|  \___|_| |_|\___\___|

*/

libname adr wpd "d:/sd1";

data adr.adr_010adrqud ;
   retain ltr '  ';
   set adr.adr_010adrlonlatfmt(
     where= (
        37.241 <= avglat <= 37.242 and
        -121.831 <= avglon <= -121.830)
     );
   ltr=put(_n_,z2.);
run;quit;

proc print data=adr.adr_010adrqud ;
 format avglat avglon 13.6;
run;quit;

libname adr wpd "d:/sd1";

options ls=80 ps=44;

proc plot data=adr.adr_010adrqud;

    plot avglat*avglon='*' $ ltr /box
    haxis=-121.831 -121.8308 -121.8306 -121.8304 -121.8302 -121.83;

run;


/**************************************************************************************************************************/
/* Altair SLC                                                                                                             */
/* Obs    LTR        MATCHCODE        ZIP4    STATE            ADR                    AVGLAT           AVGLON             */
/*                                                                                                                        */
/*   1    01     2CALEROAVE95123      9512     CA      2 CALERO AVE 95123          37.241810      -121.830950             */
/*   2    02     490CALEROAVE95123    9512     CA      490 CALERO AVE 95123        37.241860      -121.830025             */
/*   3    03     491SHAWNEELN95123    9512     CA      491 SHAWNEE LN 95123        37.241530      -121.830015             */
/*   4    04     494CALEROAVE95123    9512     CA      494 CALERO AVE 95123        37.241800      -121.830225             */
/*   5    05     494SHAWNEELN95123    9512     CA      494 SHAWNEE LN 95123        37.241085      -121.830175             */
/*   6    06     495SHAWNEELN95123    9512     CA      495 SHAWNEE LN 95123        37.241550      -121.830220             */
/*   7    07     498CALEROAVE95123    9512     CA      498 CALERO AVE 95123        37.241830      -121.830430             */
/*   8    08     498SHAWNEELN95123    9512     CA      498 SHAWNEE LN 95123        37.241105      -121.830400             */
/*   9    09     499SHAWNEELN95123    9512     CA      499 SHAWNEE LN 95123        37.241520      -121.830420             */
/*  10    10     501SHAWNEELN95123    9512     CA      501 SHAWNEE LN 95123        37.241510      -121.830950             */
/*  11    11     502CALEROAVE95123    9512     CA      502 CALERO AVE 95123        37.241740      -121.830960             */
/*                                                                                                                        */
/* The PLOT Procedure                                                                                                     */
/*                    Plot of AVGLAT*AVGLON. Symbol used is '*'.                                                          */
/*                                                                                                                        */
/*                                      LONGITUDE                                                                         */
/*       -121.831     -121.8308    -121.8306    -121.8304    -121.8302     -121.83                                        */
/*          -+------------+------------+------------+------------+------------+-                                          */
/*   AVGLAT |                                                                  |   AVGLAT                                 */
/*          |                                                                  |                                          */
/*          |          LTR      ADDRESS                                        |                                          */
/*          |                                     * 07                     * 02|                                          */
/*  37.2418 +   * 01    01 2 CALERO AVE 95123                  * 04            +  37.2418                                 */
/*          |   * 11    02 490 CALERO AVE 95123                                |                                          */
/*  37.2417 +           03 491 SHAWNEE LN 95123                                +  37.2417                                 */
/*          |           04 494 CALERO AVE 95123                                |                                          */
/*  37.2416 +           05 494 SHAWNEE LN 95123                                +  37.2416                                 */
/*          |           06 495 SHAWNEE LN 95123                 * 06       * 03|                                          */
/*  37.2415 +   * 10    07 498 CALERO AVE 95123    * 09                        +  37.2415                                 */
/*          |           08 498 SHAWNEE LN 95123                                |                                          */
/*  37.2414 +           09 499 SHAWNEE LN 95123                                +  37.2414                                 */
/*          |           10 501 SHAWNEE LN 95123                                |                                          */
/*  37.2413 +           11 502 CALERO AVE 95123                                +  37.2413                                 */
/*          |                                                                  |                                          */
/*  37.2412 +                                                                  +  37.2412                                 */
/*          |                                                                  |                                          */
/*  37.2411 +              * 08           * 05                                 +  37.2411                                 */
/*          |                                                                  |                                          */
/*   37.241 +                                                                  +   37.241                                 */
/*          -+------------+------------+------------+------------+------------+-                                          */
/*       -121.831     -121.8308    -121.8306    -121.8304    -121.8302     -121.83                                        */
/*                                       LONGITUDE                                                                        */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

1                                          Altair SLC       13:23 Friday, February 20, 2026

NOTE: Copyright 2002-2025 World Programming, an Altair Company
NOTE: Altair SLC 2026 (05.26.01.00.000758)
      Licensed to Roger DeAngelis
NOTE: This session is executing on the X64_WIN11PRO platform and is running in 64 bit mode

NOTE: AUTOEXEC processing beginning; file is C:\wpsoto\autoexec.sas
NOTE: AUTOEXEC source line
1       +  ï»¿ods _all_ close;
           ^
ERROR: Expected a statement keyword : found "?"
NOTE: Library workx assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\wpswrkx

NOTE: Library slchelp assigned as follows:
      Engine:        WPD
      Physical Name: C:\Progra~1\Altair\SLC\2026\sashelp

NOTE: Library worksas assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: d:\worksas

NOTE: Library workwpd assigned as follows:
      Engine:        WPD
      Physical Name: d:\workwpd


LOG:  13:23:36
NOTE: 1 record was written to file PRINT

NOTE: The data step took :
      real time : 0.035
      cpu time  : 0.015


NOTE: AUTOEXEC processing completed

1
2         libname adr wpd "d:/sd1";
NOTE: Library adr assigned as follows:
      Engine:        WPD
      Physical Name: d:\sd1

3
4         data adr.adr_010adrqud ;
5            retain ltr '  ';
6            set adr.adr_010adrlonlatfmt(
7              where= (
8                 37.241 <= avglat <= 37.242 and
9                 -121.831 <= avglon <= -121.830)
10             );
11           ltr=put(_n_,z2.);
12        run;

NOTE: 11 observations were read from "ADR.adr_010adrlonlatfmt"
NOTE: Data set "ADR.adr_010adrqud" has 11 observation(s) and 7 variable(s)
NOTE: The data step took :
      real time : 24.287
      cpu time  : 24.265


12      !     quit;
13
14        proc print data=adr.adr_010adrqud ;
15         format avglat avglon 13.6;
16        run;quit;
NOTE: 11 observations were read from "ADR.adr_010adrqud"
NOTE: Procedure print step took :
      real time : 0.019
      cpu time  : 0.015


17
18        libname adr wpd "d:/sd1";
NOTE: Library adr assigned as follows:
      Engine:        WPD
      Physical Name: d:\sd1

19
20        options ls=80 ps=44;
21
22        proc plot data=adr.adr_010adrqud;
23
24            plot avglat*avglon='*' $ ltr /box
25            haxis=-121.831 -121.8308 -121.8306 -121.8304 -121.8302 -121.83;
26
27        run;
NOTE: Procedure plot step took :
      real time : 0.018
      cpu time  : 0.000


28
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 24.409
      cpu time  : 24.343

/*  _             _       _           _
| || |   _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
| || |_ | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
|__   _|| | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
   |_|  |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                          |_|
*/

REPO
----------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/utl_geocode_reverse_geocode
https://github.com/rogerjdeangelis/utl-dept-of-trans-address-database-to-sas-wps-tables-for-geocoding-and-reverse-geocoding
https://github.com/rogerjdeangelis/utl-free-unlimited-geocoding-reverse-geocoding-wps-aprox-I41-million-addresses-with-gps
https://github.com/rogerjdeangelis/utl-given-a-list-of-messy-addresses-geocode-and-reverse-geocode-using-us-address-database
https://github.com/rogerjdeangelis/utl-openaddress-database-to-sas-wps-tables-for-geocoding-and-reverse-geocoding
https://github.com/rogerjdeangelis/utl-standardize-address-suffix-using-usps-abreviations
https://github.com/rogerjdeangelis/utl-validate-email-address-and-domain-python
https://github.com/rogerjdeangelis/utl_US_address-standardization
https://github.com/rogerjdeangelis/utl_geocode_and_reverse_geocode_netherland_addresses_and_latitudes_longitudes


https://github.com/rogerjdeangelis/utl-add-points-to-a-map-of-slovakia
https://github.com/rogerjdeangelis/utl-creating-zipcode-zcta-choropleth-maps-in-R-and-SAS
https://github.com/rogerjdeangelis/utl-drawing-a-world-map-using-the-eckert-projection-ggplot-map-rnaturalearth
https://github.com/rogerjdeangelis/utl-gis-census-zipcode-maps-no-credit-card-api-or-restrictions-wps-r-tmap
https://github.com/rogerjdeangelis/utl-gis-mapping-with-r-package-rnaturalearth-no-api-credit-card-or-access-limits-
https://github.com/rogerjdeangelis/utl-given-latitude-and-longitude-determine-the-us-state-mapping
https://github.com/rogerjdeangelis/utl-programatically-download-census-tiger-shapefiles-and-map-us-labeling-largest-cities
https://github.com/rogerjdeangelis/utl-usmap-drilldown
https://github.com/rogerjdeangelis/utl_driving_distance_from_city_to_city_using_google_maps
https://github.com/rogerjdeangelis/utl_google_and_SAS_maps
https://github.com/rogerjdeangelis/utl_google_map_of_USA_with_long_and_lat_and_earnings
https://github.com/rogerjdeangelis/utl_google_map_of_earnings_for_canada_cities
https://github.com/rogerjdeangelis/utl_graphics_zipcode_boundary_maps
https://github.com/rogerjdeangelis/utl_javascript_and_classic_map_graphics_with_mouseovers_and_multiple_drilldowns
https://github.com/rogerjdeangelis/utl_map_counties_within_one_state_choropleth_map
https://github.com/rogerjdeangelis/utl_proc_gmap_classic_graphics_grid_containing_four_states
https://github.com/rogerjdeangelis/utl_where_am_i_show_the_street_or_satelite_map
/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
