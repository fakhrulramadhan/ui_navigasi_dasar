import 'package:flutter/material.dart';

import 'screens/bottom_nav_screen.dart';
import 'screens/contact_list_screen.dart';
import 'screens/named_routes_screen.dart';
import 'screens/result_picker_screen.dart';
import 'screens/unknown_route_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const UiNavigasiApp());
}

class UiNavigasiApp extends StatelessWidget {
  const UiNavigasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigasi & Routing Flutter',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeMenu(),
      routes: {
        NamedRoutesScreen.routeName: (_) => const NamedRoutesScreen(),
        PlanDetailScreen.routeName: (_) => const PlanDetailScreen(),
      },
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const UnknownRouteScreen()),
    );
  }
}

/// Menu utama berisi daftar latihan navigasi dan routing.
class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = <_Lesson>[
      _Lesson(
        title: '1. Kirim Data ke Halaman Lain',
        subtitle: 'push, constructor, arguments, hasil pop',
        icon: Icons.send_outlined,
        builder: (_) => const ContactListScreen(),
      ),
      _Lesson(
        title: '2. Named Routes',
        subtitle: 'routes, arguments, fallback route',
        icon: Icons.alt_route_outlined,
        builder: (_) => const NamedRoutesScreen(),
      ),
      _Lesson(
        title: '3. Bottom Navigation',
        subtitle: 'IndexedStack, tab, state yang tetap hidup',
        icon: Icons.menu_open_outlined,
        builder: (_) => const BottomNavScreen(),
      ),
      _Lesson(
        title: '4. Kembalikan Data',
        subtitle: 'await push, generic result, pop dengan nilai',
        icon: Icons.keyboard_return_outlined,
        builder: (_) => const ResultPickerScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Navigasi & Routing Flutter')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          itemCount: lessons.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppTheme.spaceSm),
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            return _LessonTile(
              lesson: lesson,
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: lesson.builder)),
            );
          },
        ),
      ),
    );
  }
}

class _Lesson {
  const _Lesson({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({required this.lesson, required this.onTap});

  final _Lesson lesson;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.surface,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spaceMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(color: AppTheme.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Icon(lesson.icon, color: AppTheme.primary),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceXs),
                    Text(
                      lesson.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
