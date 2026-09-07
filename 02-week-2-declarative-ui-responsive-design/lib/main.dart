import 'package:flutter/material.dart';

const double kWideBreakpoint = 700;

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatefulWidget {
  const DashboardApp({super.key});

  @override
  State<DashboardApp> createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academic Overview',

      // LIGHT THEME
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),

      // DARK THEME
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),

      // DARK MODE
      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: DashboardPage(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const DashboardPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Overview'),

        // DARK MODE TOGGLE
        actions: [
          Row(
            children: [
              Icon(
                isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),

              Semantics(
                label: 'Toggle dark mode',
                child: Switch(
                  value: isDarkMode,
                  onChanged: onThemeChanged,
                ),
              ),

              const SizedBox(width: 8),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // PROFILE HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // ACCESSIBILITY
                  Semantics(
                    label: 'Profile picture of Wahyu Fairuz',
                    child: const CircleAvatar(
                      radius: 32,
                      child: Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(width: 16),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wahyu Fairuz',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'D4 Informatics Engineering',
                        ),

                        Text(
                          'Mobile Programming - Week 2',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // RESPONSIVE CARDS
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide =
                    constraints.maxWidth >=
                    kWideBreakpoint;

                return GridView.count(
                  crossAxisCount: isWide ? 2 : 1,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: const [
                    // SEMESTER
                    InfoCard(
                      title: 'Semester',
                      value: '5',
                      icon: Icons.school,
                    ),

                    // COURSES
                    InfoCard(
                      title: 'Courses',
                      value: '8',
                      icon: Icons.menu_book,
                    ),

                    // ASSIGNMENTS
                    InfoCard(
                      title: 'Assignments',
                      value: '12',
                      icon: Icons.assignment,
                    ),

                    // GPA
                    InfoCard(
                      title: 'GPA',
                      value: '3.85',
                      icon: Icons.star,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// REUSABLE INFO CARD
class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
            ),

            const SizedBox(height: 8),

            Text(title),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}