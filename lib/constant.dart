import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weathering_you/screens/air_quality_page.dart';
import 'package:weathering_you/screens/earthquake_page.dart';
import 'package:weathering_you/screens/forecast_page.dart';
import 'package:weathering_you/screens/news_page.dart';
import 'package:weathering_you/screens/simple_page.dart';

const OPEN_WEATHER_API = "551bceb1825daa3ff74a9f59e7c076b6";
const NEWS_API = "3c306b27306041a2a1b8564dd048044c";

final months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
final days = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

// Architects+Daughter

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

const Color foregroundColor = Colors.white;
const Color backgroundColor = Color(0xffF3F3F3);
const Color activeColor = Color(0xff834DF3);
const Color textColor = Color(0xff645D6E);
const Color purpleBgColor = Color(0xffDAC7FF);
const Color redBgColor = Color(0xffFCCFCF);
const Color redActiveColor = Color(0xffEA5455);
const Color greenBgColor = Color(0xffE0F9EE);
const Color greenActiveColor = Color(0xff11D47B);
const Color yellowBgColor = Color(0xffFFE5C6);
const Color yellowActiveColor = Color(0xffFF9B26);

const List<Color> activeTabGradient = [
  Color(0xff834DF3),
  Color(0xff996CF5),
];
const Color textDarkGrey = Color(0xff4B4B4B);
const Color textLightGrey = Color(0xffACA8B5);
const Color textColor2 = Color(0xff70697B);

const Color colorComb11 = Colors.deepPurple;
const Color colorComb12 = Colors.greenAccent;
const Color colorComb13 = Colors.pinkAccent;

const Color colorComb21 = Colors.blue;
const Color colorComb22 = Colors.deepOrange;
const Color colorComb23 = Colors.orangeAccent;

const commonTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);

double getDoubleRandomV() {
  double randomDouble = Random().nextDouble();
  return randomDouble;
}

List<Widget> pages = const [
  SimplePage(),
  AirQualityPage(),
  EarthquakesPage(),
  ForecastPage(),
  NewsPage(),
];

const tempNewsData = {
  "status": "ok",
  "totalResults": 38,
  "articles": [
    {
      "source": {"id": null, "name": "NDTV News"},
      "author": null,
      "title":
          "On CCTV, 3 am Arrest Over Bajrang Dal Man's Murder In Karnataka - NDTV",
      "description":
          "Hours after the killing of a member of the rightwing Bajrang Dal in Karnataka's Shivamogga, the police made its first arrests.",
      "url":
          "https://www.ndtv.com/karnataka-news/on-cctv-3-am-arrest-over-bajrang-dal-mans-murder-in-karnataka-2782509",
      "urlToImage":
          "https://c.ndtvimg.com/2022-02/vov4n2ko_karnataka-bajrang-dal-man-murder-accused-cctv-arrest-650_650x400_22_February_22.jpg",
      "publishedAt": "2022-02-22T12:18:00Z",
      "content":
          "The government said the murder would be investigated from \"all angles including the hijab row\".\r\nShivamogga: Hours after the killing of a member of the rightwing Bajrang Dal in Karnataka's Shivamogga… [+3446 chars]"
    },
    {
      "source": {"id": null, "name": "India Today"},
      "author": "IndiaToday.in",
      "title":
          "Russia-Ukraine news LIVE updates | Russia recognises independence of Ukraine-held areas as part of rebel regions - India Today",
      "description":
          "Russia-Ukraine crisis news LIVE Updates: Russian President Vladimir Putin on Monday signed a decree in Moscow recognising the independence of Donetsk and Luhansk regions in eastern Ukraine. Reacting to it, US President Joe Biden signed an executive order to p…",
      "url":
          "https://www.indiatoday.in/world/story/russia-ukraine-crisis-live-updates-putin-biden-nato-eu-un-1916094-2022-02-22",
      "urlToImage":
          "https://akm-img-a-in.tosshub.com/indiatoday/images/breaking_news/202202/ukraine_protest-647x363.jpeg?xePW.82djg6sf6u4HR7LFsPgBLYFOUrJ",
      "publishedAt": "2022-02-22T12:17:00Z",
      "content": null
    },
    {
      "source": {"id": null, "name": "The Indian Express"},
      "author": "Express Web Desk",
      "title":
          "Bengaluru News Live Updates: Right to wear hijab does not fall under Article 25 of Constitution, K’taka govt tells HC - The Indian Express",
      "description":
          "Bengaluru, Karnataka Live News, Hijab Row News Latest Updates, Bengaluru, Karnataka Shivamogga Riots Updates: The Karnataka High Court on Tuesday said it wishes to dispose of the Hijab related case this week itself and sought the cooperation of all the partie…",
      "url":
          "https://indianexpress.com/article/cities/bangalore/bengaluru-news-live-updatesbajrang-dal-worker-murder-protest-hijab-row-covid-cases-7784843/",
      "urlToImage": "https://images.indianexpress.com/2022/02/hijab-10.jpg",
      "publishedAt": "2022-02-22T12:01:30Z",
      "content":
          "The police are yet to confirm the reason behind the murder.\r\nThe police are looking at a series of crimes that a Bajrang Dal worker, Harsha Hindu (27), in Shivamogga region was involved in for a poss… [+1296 chars]"
    },
    {
      "source": {"id": null, "name": "NDTV News"},
      "author": null,
      "title":
          "Shibani Dandekar-Farhan Akhtar Wedding: Things We Learnt From Farah Khan's Inside Pics - NDTV Movies",
      "description":
          "Farah Khan shares inside pics from Shibani Dandekar and Farhan Akhtar's wedding",
      "url":
          "https://www.ndtv.com/entertainment/shibani-dandekar-farhan-akhtar-wedding-things-we-learnt-from-farah-khans-inside-pics-2782588",
      "urlToImage":
          "https://c.ndtvimg.com/2022-02/7v60j3qo_shabana_625x300_22_February_22.jpg",
      "publishedAt": "2022-02-22T11:34:00Z",
      "content":
          "Farah Khan posted this. (Image courtesy: farahkhankunder)\r\nHighlights\r\n<ul><li>Farah Khan shared inside pictures from the wedding\r\n</li><li>Sajid Khan, Rhea and others were seen at the wedding\r\n</li>… [+2023 chars]"
    },
    {
      "source": {"id": null, "name": "Republic World"},
      "author": "Apoorva Kaul",
      "title":
          "US: Omicron variant BA.2 cases on rampant rise; spreads 30% more easily - Republic World",
      "description":
          "According to the US Centers for Disease Control and Prevention's data tracker, BA.2 strain accounts for approximately 3.9% of all new cases in the country",
      "url":
          "https://www.republicworld.com/world-news/us-news/us-omicron-variant-ba-dot-2-cases-on-rampant-rise-spreads-30-percent-more-easily-articleshow.html",
      "urlToImage":
          "https://img.republicworld.com/republic-prod/stories/promolarge/xhdpi/vcxzktxzrvnf3jln_1645526386.jpeg",
      "publishedAt": "2022-02-22T11:33:00Z",
      "content":
          "Infectious disease experts are keeping a close watch on the BA.2 strain of the Omicron variant that has been slowly spreading throughout the United States. According to the US Centers for Disease Con… [+2063 chars]"
    },
    {
      "source": {"id": "google-news", "name": "Google News"},
      "author": null,
      "title":
          "Samsung Galaxy S22, Galaxy S22+, Galaxy S22 Ultra India pre-booking goes 'live' today: Price, offers - The Financial Express",
      "description": null,
      "url":
          "https://news.google.com/__i/rss/rd/articles/CBMimwFodHRwczovL3d3dy5maW5hbmNpYWxleHByZXNzLmNvbS9pbmR1c3RyeS90ZWNobm9sb2d5L3NhbXN1bmctZ2FsYXh5LXMyMi1nYWxheHktczIyLWdhbGF4eS1zMjItdWx0cmEtaW5kaWEtcHJlLWJvb2tpbmctZ29lcy1saXZlLXRvZGF5LXByaWNlLW9mZmVycy8yNDQxNjA3L9IBAA?oc=5",
      "urlToImage": null,
      "publishedAt": "2022-02-22T11:13:07Z",
      "content": null
    },
    {
      "source": {"id": null, "name": "Gadgets Now"},
      "author": "Gadgets Now Bureau",
      "title":
          "Galaxy Tab S8 Ultra vs iPad Pro 12.9: How the two most expensive tablets from Samsung and Apple compare - Gadgets Now",
      "description":
          "Samsung has recently launched the Galaxy Tab S8 Ultra, its biggest tablet to date. The Galaxy Tab S8 Ultra is the most premium Android tablet in the market and it also offers top-notch features like flagship Snapdragon 8 Gen 1 chipset, 12GB RAM and Super AMOL…",
      "url":
          "https://www.gadgetsnow.com/slideshows/galaxy-tab-s8-ultra-vs-ipad-pro-12-9-how-the-two-most-expensive-tablets-from-samsung-and-apple-compare/photolist/89738387.cms",
      "urlToImage":
          "https://static.toiimg.com/thumb/msid-89738426,width-800,resizemode-4,imgsize-17436/share.jpg",
      "publishedAt": "2022-02-22T10:53:00Z",
      "content":
          "Samsung Galaxy Tab S8 Ultra: Wi-Fi, Wi-Fi Direct, Bluetooth, USB 3.2 Gen 1, GPS, Glonass, Beidou, Galileo, QZSS\r\nApple iPad Pro 12.9: Wi-Fi, Bluetooth, Thunderbolt 4, GPS/GNSS, DisplayPort and USB 3.… [+6 chars]"
    },
    {
      "source": {"id": "the-times-of-india", "name": "The Times of India"},
      "author": "Reuters",
      "title":
          "Pakistan's Imran Khan wants TV debate with PM Modi to resolve issues - Times of India",
      "description":
          "India News: Pakistani Prime Minister Imran Khan said on Tuesday he would like to have a televised debate with his Indian counterpart, Narendra Modi, to resolve di",
      "url":
          "https://timesofindia.indiatimes.com/india/pakistans-imran-khan-wants-tv-debate-with-pm-modi-to-resolve-issues/articleshow/89749035.cms",
      "urlToImage":
          "https://static.toiimg.com/thumb/msid-89749335,width-1070,height-580,imgsize-899258,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg",
      "publishedAt": "2022-02-22T10:51:00Z",
      "content":
          "Pakistan's Imran Khan wants TV debate with PM Modi to resolve issues\r\n<ul><li>News</li>\r\n<li>India News</li>\r\n<li>Pakistan's Imran Khan wants TV debate with PM Modi to resolve issues</li></ul>"
    },
    {
      "source": {"id": "the-times-of-india", "name": "The Times of India"},
      "author": "TIMESOFINDIA.COM",
      "title":
          "Coronavirus: How soon can you get re-infected with COVID-19? Here's what doctors have to say - Times of India",
      "description":
          "With the onset of the latest variant of concern Omicron, there has been an increased possibility of catching COVID twice in a short span of time.",
      "url":
          "https://timesofindia.indiatimes.com/life-style/health-fitness/health-news/coronavirus-how-soon-can-you-get-re-infected-with-covid-19-heres-what-doctors-have-to-say/photostory/89744661.cms",
      "urlToImage": "https://static.toiimg.com/photo/89744680.cms",
      "publishedAt": "2022-02-22T10:30:00Z",
      "content":
          "Currently, scientists and medical professionals are uncertain as to how long protection from a natural infection or vaccine immunity lasts. While the duration of natural immunity is not exactly known… [+1091 chars]"
    },
    {
      "source": {"id": null, "name": "Livemint"},
      "author": "Livemint",
      "title":
          "Neanderthal-inherited genes influence severe COVID infections. Experts explain how. Read here - Mint",
      "description":
          "In 2020, researchers observed that we inherited the major genetic risk factor for severe COVID-19 from Neanderthals .Later, on studying ancient human DNA, they saw its frequency has increased significantly since the last ice age",
      "url":
          "https://www.livemint.com/science/neanderthalinherited-genes-influence-severe-covid-infections-experts-explain-how-read-here-11645522387518.html",
      "urlToImage":
          "https://images.livemint.com/img/2022/02/22/600x338/coronavirus_1608178200730_1608178208280_1645524726260.PNG",
      "publishedAt": "2022-02-22T10:12:44Z",
      "content":
          "In an astounding discovery regarding COVID-19, a recent study has shown that we have inherited major genetic factors from Neanderthals that can cause severe Covid infections. However, the same factor… [+2106 chars]"
    },
    {
      "source": {"id": null, "name": "Hindustan Times"},
      "author": "HT Entertainment Desk",
      "title":
          "Alia Bhatt responds to Kangana Ranaut saying Gangubai Kathiawadi will ‘be burnt to ashes’ with Bhagavad Gita quote - Hindustan Times",
      "description":
          "Alia Bhatt has reacted to Kangana Ranaut's comment on her film Gangubai Kathiawadi. Here's what she has said. | Bollywood",
      "url":
          "https://www.hindustantimes.com/entertainment/bollywood/alia-bhatt-responds-to-kangana-ranaut-saying-gangubai-kathiawadi-will-be-burnt-to-ashes-with-bhagavad-gita-quote-101645522430274.html",
      "urlToImage":
          "https://images.hindustantimes.com/img/2022/02/22/1600x900/kangana-alia_1618987437475_1645522806356.jpg",
      "publishedAt": "2022-02-22T09:59:43Z",
      "content":
          "Actor Alia Bhatt has responded to the recent criticism by actor Kangana Ranaut targeting her and her upcoming film, Gangubai Kathiawadi. In a recent promotional event in Kolkata, Alia gave her reacti… [+2494 chars]"
    },
    {
      "source": {"id": "the-times-of-india", "name": "The Times of India"},
      "author": "Bloomberg",
      "title":
          r"Bank CEO gives $500,000 of shares to his chauffeur, home help - Times of India",
      "description":
          r"India Business News: The chief executive officer (CEO) of IDFC First Bank gifted $530,000 worth of shares he owns to his driver, trainer, and helpers at home and office in",
      "url":
          "https://timesofindia.indiatimes.com/business/india-business/bank-ceo-gives-500000-of-shares-to-his-chauffeur-home-help/articleshow/89746759.cms",
      "urlToImage":
          "https://static.toiimg.com/thumb/msid-89746800,width-1070,height-580,imgsize-502911,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg",
      "publishedAt": "2022-02-22T09:24:00Z",
      "content":
          r"Bank CEO gives $500,000 of shares to his chauffeur, home help"
    },
    {
      "source": {"id": null, "name": "NDTV News"},
      "author": "NDTV Sports Desk",
      "title":
          "\"Why I Didn't Reveal Journalist Name\": Wriddhiman Saha On Explosive Tweet - NDTV Sports",
      "description":
          "Wriddhiman Saha said that he would not reveal the identity of the journalist to the board because it was \"never my intention to harm somebody's career, to pull a person down.\"",
      "url":
          "https://sports.ndtv.com/cricket/wriddhiman-saha-says-he-will-not-reveal-identity-of-journalist-2782099",
      "urlToImage":
          "https://c.ndtvimg.com/2022-02/1k586hr_saha-instagram_625x300_08_February_22.jpg?im=FitAndFill,algorithm=dnn,width=1200,height=675",
      "publishedAt": "2022-02-22T09:16:00Z",
      "content":
          "Wriddhiman Saha has received an outpouring of support after sharing a screenshot of messages he received from a journalist following the Indian selection committee's decision to drop him from the Tes… [+3409 chars]"
    },
    {
      "source": {"id": null, "name": "GSMArena.com"},
      "author": "Yordan",
      "title":
          "Poco X4 Pro 5G major leak confirms 108MP camera, SD695 - GSMArena.com news - GSMArena.com",
      "description":
          "This is the Redmi Note 11 Pro with a redesigned back panel.",
      "url":
          "https://www.gsmarena.com/xiaomi_poco_x4_pro_5g_leaks_in_full_brings_a_familiar_specs_sheet-news-53252.php",
      "urlToImage":
          "https://fdn.gsmarena.com/imgroot/news/22/02/xiaomi-poco-x4-pro-5-amzn-leak/-952x498w6/gsmarena_001.jpg",
      "publishedAt": "2022-02-22T08:44:01Z",
      "content":
          "Poco is having an event during MWC, and we expect to see new smartphones, including the Poco M4 Pro (an LTE-only version) and the Poco X4 Pro 5G. Yet Amazon France couldn't wait another week and rele… [+932 chars]"
    },
    {
      "source": {"id": null, "name": "The Indian Express"},
      "author": "Krishn Kaushik",
      "title":
          "Centre blocks ‘SFJ-linked’ Punjab Politics TV’s apps, website, social media accounts - The Indian Express",
      "description":
          "The I&B Ministry said that it has “ordered blocking of apps, website, and social media accounts of foreign-based ‘Punjab Politics TV’ having close links with Sikhs For Justice (SFJ), an organisation that has been declared unlawful under the Unlawful Activitie…",
      "url":
          "https://indianexpress.com/article/india/sfj-links-punjab-politics-tv-apps-website-blocked-7785262/",
      "urlToImage":
          "https://images.indianexpress.com/2022/02/Anurag-Thakur-2.jpg",
      "publishedAt": "2022-02-22T08:41:34Z",
      "content":
          "Once again relying on intelligence inputs and invoking the emergency powers it was given under the new Information Technology Rules issued last year, the Union Ministry of Information and Broadcastin… [+3374 chars]"
    },
    {
      "source": {"id": null, "name": "Moneycontrol"},
      "author": null,
      "title":
          "MC Election LIVE Updates February 22: Vote for BJP as this election will decide Manipur's future for next... - Moneycontrol.com",
      "description":
          "MC Election LIVE Updates February 22: Take a quick look at all the major updates on assembly elections in five states of Uttar Pradesh, Punjab, Uttarakhand, Goa, and Manipur.",
      "url":
          "https://www.moneycontrol.com/news/politics/mc-election-live-updates-february-22-rahul-gandhi-doesnt-know-history-says-amit-shah-8145401.html",
      "urlToImage":
          "https://images.moneycontrol.com/static-mcnews/2021/10/National-Unity-Day-Amit-Shah-Twt-1-770x433.jpg",
      "publishedAt": "2022-02-22T08:27:18Z",
      "content":
          "SP-BSP-Congress responsible for split in Muslim votes, says Peace Party chief\r\nPeace Party President Dr Ayub, who is trying his luck once again in the Uttar Pradesh Assembly polls, on Tuesday blamed … [+20858 chars]"
    },
    {
      "source": {"id": "al-jazeera-english", "name": "Al Jazeera English"},
      "author": "Al Jazeera",
      "title":
          "Indian grandmaster, 16, beats world chess champion Magnus Carlsen - Al Jazeera English",
      "description":
          "Rameshbabu Praggnanandhaa, who in 2016 became youngest international master at 10, beats Carlsen in online championship.",
      "url":
          "https://www.aljazeera.com/news/2022/2/22/india-grandmaster-praggnanandhaa-stuns-world-chess-champion-magnus-carlsen",
      "urlToImage":
          "https://www.aljazeera.com/wp-content/uploads/2022/02/000_323N48Q.jpg?resize=1200%2C630",
      "publishedAt": "2022-02-22T08:05:08Z",
      "content":
          "Indias teenage chess grandmaster Rameshbabu Praggnanandhaa has won praise for a stunning victory over world number one Magnus Carlsen in an online championship.\r\nPraggnanandhaa, 16, who in 2016 becam… [+2494 chars]"
    },
    {
      "source": {"id": null, "name": "News18"},
      "author": "Buzz Staff",
      "title":
          "NASA Astronauts to Grow Plants Without Soil in Space, Here's How - News18",
      "description":
          "Among the batch of supplies carried by the International Space Station which are necessary ingredients to carry out research in various categories and fields, including growing plants through hydroponic and aeroponic techniques. Basically, these plants will g…",
      "url":
          "https://www.news18.com/news/buzz/nasa-astronauts-to-grow-plants-without-soil-in-space-heres-how-4797719.html",
      "urlToImage":
          "https://images.news18.com/ibnlive/uploads/2022/02/plants-space-164551587516x9.png",
      "publishedAt": "2022-02-22T07:47:48Z",
      "content":
          "The International Space Station recently received a fresh batch of supplies and assistive elements for research and development. The cargo was carried by Northrop Grummans creation, Cygnus, which doc… [+1876 chars]"
    },
    {
      "source": {"id": null, "name": "NDTV News"},
      "author": null,
      "title":
          "Former SriLankan Airlines Chief Vipula Gunatilleka Appointed Chief Financial Officer Of Jet Airways - NDTV Profit",
      "description":
          "Promoters of Jet Airways have appointed Vipula Gunatilleka as the CFO of the airline. He has been tasked with reviving the grounded carrier",
      "url":
          "https://www.ndtv.com/business/former-srilankan-airlines-chief-vipula-gunatilleka-appointed-chief-financial-officer-of-jet-airways-2781972",
      "urlToImage":
          "https://c.ndtvimg.com/2022-02/u4epcbg_jet3_625x300_22_February_22.jpg",
      "publishedAt": "2022-02-22T06:47:38Z",
      "content":
          "Former CEO of SriLankan Airlines Vipula Gunatilleka has been appointed as CFO of Jet Airways\r\nJalan Kalrock consortium, the promoters of Jet Airways, have appointed Vipula Gunatilleka as the chief fi… [+2822 chars]"
    },
    {
      "source": {"id": null, "name": "Hindustan Times"},
      "author": "hindustantimes.com",
      "title":
          "'For a minute there my heart skipped a beat': MI star reveals most 'worrying bit' during his IPL Auction bidding war - Hindustan Times",
      "description":
          "Mumbai Indians' first buy at the auction went for a whopping INR 15.25 crore as they bought back their star player.  | Cricket",
      "url":
          "https://www.hindustantimes.com/cricket/for-a-minute-there-my-heart-skipped-a-beat-mumbai-indians-mi-star-ishan-kishan-reveals-most-worrying-bit-during-his-ipl-auction-bidding-war-101645510462739.html",
      "urlToImage":
          "https://images.hindustantimes.com/img/2022/02/22/1600x900/New_Project_-_2022-02-15T155816.215_1644920903264_(1)_1645510650402_1645510660658.jpg",
      "publishedAt": "2022-02-22T06:34:35Z",
      "content":
          "Mumbai Indians, the five-time winners of the Indian Premier League (IPL) trophy, remained curiously quiet throughout a major part of the IPL mega auction earlier this month in Bengaluru. But their fi… [+2044 chars]"
    }
  ]
};