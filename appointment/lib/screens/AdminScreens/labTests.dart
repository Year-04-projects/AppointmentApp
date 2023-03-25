import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/nav_drawer.dart';
import '../authscreens/login.dart';

class LabTests extends StatefulWidget {
  const LabTests({super.key});

  @override
  State<LabTests> createState() => _LabTests();
}

class _LabTests extends State<LabTests> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: secondaryColor,
            expansionTileTheme: const ExpansionTileThemeData(
                backgroundColor: Colors.white,
                collapsedBackgroundColor: messageColor)),
        home: Scaffold(
            body: Center(
                child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Frequently Asked Questions',
                  style: GoogleFonts.urbanist(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 32,
                ),
                ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: const Text(
                    'How To Add Lab results to the system?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkprimaryColor),
                  ),
                  //subtitle: const Text('Custom expansion arrow ico'),
                  trailing: Icon(
                      _customTileExpanded ? Icons.horizontal_rule : Icons.add),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                        'Navigate to Add Result in Bottom Navigation pane and fill details',
                        style: TextStyle(fontSize: 16, color: darkTextColor),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: const Text(
                    'How To Add Lab results to the system?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkprimaryColor),
                  ),
                  //subtitle: const Text('Custom expansion arrow ico'),
                  trailing: Icon(
                      _customTileExpanded ? Icons.horizontal_rule : Icons.add),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                        'Navigate to Add Result in Bottom Navigation pane and fill details',
                        style: TextStyle(fontSize: 16, color: darkTextColor),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: const Text(
                    'How To Add Lab results to the system?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkprimaryColor),
                  ),
                  //subtitle: const Text('Custom expansion arrow ico'),
                  trailing: Icon(
                      _customTileExpanded ? Icons.horizontal_rule : Icons.add),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                        'Navigate to Add Result in Bottom Navigation pane and fill details',
                        style: TextStyle(fontSize: 16, color: darkTextColor),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: const Text(
                    'How To Add Lab results to the system?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkprimaryColor),
                  ),
                  //subtitle: const Text('Custom expansion arrow ico'),
                  trailing: Icon(
                      _customTileExpanded ? Icons.horizontal_rule : Icons.add),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                        'Navigate to Add Result in Bottom Navigation pane and fill details',
                        style: TextStyle(fontSize: 16, color: darkTextColor),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: const Text(
                    'How To Add Lab results to the system?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkprimaryColor),
                  ),
                  //subtitle: const Text('Custom expansion arrow ico'),
                  trailing: Icon(
                      _customTileExpanded ? Icons.horizontal_rule : Icons.add),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                        'Navigate to Add Result in Bottom Navigation pane and fill details',
                        style: TextStyle(fontSize: 16, color: darkTextColor),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: const Text(
                    'How To Add Lab results to the system?',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: darkprimaryColor),
                  ),
                  //subtitle: const Text('Custom expansion arrow ico'),
                  trailing: Icon(
                      _customTileExpanded ? Icons.horizontal_rule : Icons.add),
                  children: const <Widget>[
                    ListTile(
                      title: Text(
                        'Navigate to Add Result in Bottom Navigation pane and fill details',
                        style: TextStyle(fontSize: 16, color: darkTextColor),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    setState(() => _customTileExpanded = expanded);
                  },
                )
              ],
            ),
          ),
        ))));
  }
}
