// ignore_for_file: always_specify_types

import '../../general_exports.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage<Splash>(
    name: routeSplash,
    page: () => const Splash(),
  ),
  // GetPage<Login>(
  //   name: routeLogin,
  //   page: () => const Login(),
  // ),
  GetPage<HomeBottomBar>(
    name: routeHomeBottomBar,
    page: () => const HomeBottomBar(),
  ),
  GetPage<Home>(
    name: routeHome,
    page: () => const Home(),
  ),
  GetPage<FilterResult>(
    name: routeFilterResult,
    page: () => const FilterResult(),
  ),
  GetPage<MapScreen>(
    name: routeMapScreen,
    page: () => const MapScreen(),
  ),
  GetPage<AuctionItemDetails>(
    name: routeAuctionItemDetails,
    page: () => const AuctionItemDetails(),
  ),

  GetPage<AuctionDetails>(
    name: routeAuctionDetails,
    page: () => const AuctionDetails(),
  ),
  GetPage<MyAuctions>(
    name: routeMyAuctions,
    page: () => const MyAuctions(),
  ),
  GetPage<Wallet>(
    name: routeWallet,
    page: () => const Wallet(),
  ),
  GetPage<More>(
    name: routeMore,
    page: () => const More(),
  ),
  GetPage<MyAuctionDetails>(
    name: routeMyAuctionDetails,
    page: () => const MyAuctionDetails(),
  ),
  GetPage<ContactUs>(
    name: routeContactUs,
    page: () => const ContactUs(),
  ),
  GetPage<MyProfile>(
    name: routeMyProfile,
    page: () => const MyProfile(),
  ),
  GetPage<WebViewScreen>(
    name: routeWebview,
    page: () => const WebViewScreen(),
  ),
  GetPage<NotificationScreen>(
    name: routeNotification,
    page: () => const NotificationScreen(),
  ),
  GetPage<NotificationDetails>(
    name: routeNotificationDetails,
    page: () => const NotificationDetails(),
  ),
  GetPage<Favorites>(
    name: routeFavorites,
    page: () => const Favorites(),
  ),
  GetPage<VideoScreen>(
    name: routeVideoScreen,
    page: () => const VideoScreen(),
  ),
];
