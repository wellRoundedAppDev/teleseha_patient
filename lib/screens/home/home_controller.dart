// import '../../general_exports.dart';

// class HomeController extends GetxController {
//   dynamic homeData = [];

//   @override
//   void onReady() {
//     super.onReady();
//     getUsers();
//   }

//   void getUsers() {
//     startLoading();
//     ApiRequest(
//       path: users,
//       className: 'HomeController',
//       formatResponse: true,
//     ).request(
//       onSuccess: (dynamic data, dynamic response) {
//         dismissLoading();
//         homeData = data;
//         update();
//       },
//     );
//   }
// }
