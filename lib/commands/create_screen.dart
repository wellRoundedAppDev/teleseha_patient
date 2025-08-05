// ignore_for_file: avoid_print, leading_newlines_in_multiline_strings

import 'dart:convert';
import 'dart:io';

void main() async {
  // You can write the name of the component like this TextInput or text_input
  print('Enter screen name (company_details):');
  String? screenName = stdin.readLineSync(encoding: utf8);
  if (screenName == null) {
    print("The name can't be null");
    main();
  } else {
    final Directory projectDirectory = Directory.current;
    screenName = screenName.replaceAll(' ', '_').toLowerCase();
    final String screenController = '${screenName}_controller.dart';
    final String screensDirectory = '${projectDirectory.path}/lib/screens/';
    final String myAppDirectory =
        '${projectDirectory.path}/lib/screens/my_app/';
    final String constantsKeys = '${projectDirectory.path}/lib/constants/keys/';
    final List<String> screenNameWords = screenName.split('_');
    final String className = screenNameWords
        .map((String e) => e[0].toUpperCase() + e.substring(1))
        .join();
    final String indexContent =
        '''export '$screenName.dart';\nexport '$screenController';\n''';
    final String screenContent = '''import '../../general_exports.dart';

class $className extends StatelessWidget {
  const $className({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.white),
      body: GetBuilder<${className}Controller>(
        init: ${className}Controller(),
        builder: (${className}Controller controller) {
          return const Center();
        },
      ),
    );
  }
}\n''';

    final String screenControllerContent =
        '''import '../../general_exports.dart';

class ${className}Controller extends GetxController {}\n''';

    // Create component directory
    await Directory('$screensDirectory$screenName').create();

    // Create Index file
    final File indexFile =
        await File('$screensDirectory$screenName/index.dart').create();
    await indexFile.writeAsString(indexContent);
    // Create screen file
    final File screenFile =
        await File('$screensDirectory$screenName/$screenName.dart').create();
    await screenFile.writeAsString(screenContent);
    // Create screen controller file
    final File screenControllerFile =
        await File('$screensDirectory$screenName/$screenController').create();
    await screenControllerFile.writeAsString(screenControllerContent);
    // Update Screen index
    final File screensIndexFile = File('$screensDirectory/index.dart');

    // Append the new screen export line and format the file alphabetically
    final String screensIndexString = await screensIndexFile.readAsString();
    final List<String> screensIndexList = screensIndexString.split('\n');
    screensIndexList.add("export '$screenName/index.dart';");

    // Sort the array based on the first letter after export '...
    screensIndexList.sort((String a, String b) {
      final String aString = a.substring(a.indexOf("'") + 1);
      final String bString = b.substring(b.indexOf("'") + 1);
      return aString.compareTo(bString);
    });

    // add \n after ; for each item in the screensIndexList array
    String screensIndexStringSorted = screensIndexList.join('\n');

    //Remove the first character which is \n
    screensIndexStringSorted = screensIndexStringSorted.substring(1);

    await screensIndexFile.writeAsString('$screensIndexStringSorted\n');

    // Add screen route to routes file
    final File routesFile = File('$myAppDirectory/routes.dart');
    final String routesFileOldContent = await routesFile.readAsString();
    final String routesFileNewContent =
        '''${routesFileOldContent.split('];')[0]}  GetPage<$className>(
    name: route$className,
    page: () => const $className(),
  ),
];
''';
    await routesFile.writeAsString(routesFileNewContent);

    // Add route key to routes_keys file
    final File routesKeysFile = File('$constantsKeys/routes_keys.dart');
    final String routesKeysFileOldContent = await routesKeysFile.readAsString();
    final String routesKeysFileNewContent =
        '''${routesKeysFileOldContent}const String route$className = '/$screenName';''';
    await routesKeysFile.writeAsString(routesKeysFileNewContent);

    print('$screenName screen created successfully :)');
  }
}
