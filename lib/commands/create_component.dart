// ignore_for_file: avoid_consoleLog, leading_newlines_in_multiline_strings

import 'dart:convert';
import 'dart:io';
import '../general_exports.dart';


void main() async {
  // You can write the name of the component like this TextInput or text_input
  consoleLog('Enter component name (text_input):');
  String? componentName = stdin.readLineSync(encoding: utf8);
  if (componentName == null) {
    consoleLog("The name can't be null");
    main();
  } else {
    final Directory projectDirectory = Directory.current;
    componentName = componentName.replaceAll(' ', '_').toLowerCase();
    final String componentsDirectory =
        '${projectDirectory.path}/lib/components/';
    final List<String> screenNameWords = componentName.split('_');
    final String className = screenNameWords
        .map((String e) => e[0].toUpperCase() + e.substring(1))
        .join();
    final String indexContent = '''export '$componentName.dart';\n''';
    final String componentContent =
        '''import '../../general_exports.dart';

class $className extends StatelessWidget {
  const $className({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center();
  }
}\n''';

    // Create component directory
    await Directory('$componentsDirectory$componentName').create();

    // Create Index file
    final File indexFile = await File(
      '$componentsDirectory$componentName/index.dart',
    ).create();
    await indexFile.writeAsString(indexContent);
    // Create component file
    final File componentFile = await File(
      '$componentsDirectory$componentName/$componentName.dart',
    ).create();
    await componentFile.writeAsString(componentContent);
    // Update Components index
    final File componentsIndexFile = File('$componentsDirectory/index.dart');

    // Append the new component export line and format the file alphabetically
    final String componentsIndexString = await componentsIndexFile
        .readAsString();
    final List<String> componentsIndexList = componentsIndexString.split('\n');
    componentsIndexList.add("export '$componentName/index.dart';");

    // Sort the array based on the first letter after export '...
    componentsIndexList.sort((String a, String b) {
      final String aString = a.substring(a.indexOf("'") + 1);
      final String bString = b.substring(b.indexOf("'") + 1);
      return aString.compareTo(bString);
    });

    // add \n after ; for each item in the componentsIndexList array
    String componentsIndexStringSorted = componentsIndexList.join('\n');

    //Remove the first character which is \n
    componentsIndexStringSorted = componentsIndexStringSorted.substring(1);

    await componentsIndexFile.writeAsString('$componentsIndexStringSorted\n');

    consoleLog('$componentName component created successfully :)');
  }
}
