// lib/features/shared/widgets/mobile_drawer.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../main.dart';

class MobileDrawer extends StatefulWidget {
  final ThemeService themeService;

  const MobileDrawer({
    super.key,
    required this.themeService,
  });

  @override
  State<MobileDrawer> createState() => _MobileDrawerState();
}

class _MobileDrawerState extends State<MobileDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<DrawerNavigationItem> _navigationItems = [
    DrawerNavigationItem(
      name: 'Home',
      path: '/',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    DrawerNavigationItem(
      name: 'About',
      path: '/about',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
    DrawerNavigationItem(
      name: 'Projects',
      path: '/projects',
      icon: Icons.work_outline,
      activeIcon: Icons.work,
    ),
    DrawerNavigationItem(
      name: 'Skills',
      path: '/skills',
      icon: Icons.star_outline,
      activeIcon: Icons.star,
    ),
    DrawerNavigationItem(
      name: 'Experience',
      path: '/experience',
      icon: Icons.timeline_outlined,
      activeIcon: Icons.timeline,
    ),
    DrawerNavigationItem(
      name: 'Contact',
      path: '/contact',
      icon: Icons.email_outlined,
      activeIcon: Icons.email,
    ),
  ];

  final List<SocialLink> _socialLinks = [
    SocialLink(
      name: 'GitHub',
      icon: Icons.code,
      url: 'https://github.com',
      color: Color(0xFF333333),
    ),
    SocialLink(
      name: 'LinkedIn',
      icon: Icons.work_outline,
      url: 'https://linkedin.com',
      color: Color(0xFF0077B5),
    ),
    SocialLink(
      name: 'Twitter',
      icon: Icons.alternate_email,
      url: 'https://twitter.com',
      color: Color(0xFF1DA1F2),
    ),
    SocialLink(
      name: 'Email',
      icon: Icons.email_outlined,
      url: 'mailto:hello@portfolio.com',
      color: Color(0xFFEA4335),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.durationMedium,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocation = GoRouterState.of(context).uri.toString();

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildDrawerHeader(context),
                Expanded(
                  child: _buildNavigationList(context, currentLocation),
                ),
                _buildDrawerFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
            theme.colorScheme.tertiary,
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar with animation
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: AppConstants.durationSlow,
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppConstants.radiusLG),
                    border: Border.all(
                      color: theme.colorScheme.onPrimary.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.code,
                    size: 36,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: AppConstants.spaceMD),

          // Name and title
          Text(
            'Portfolio',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: AppConstants.spaceXS),

          Text(
            'Full Stack Developer',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppConstants.spaceXS),

          // Status indicator
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spaceSM,
              vertical: AppConstants.spaceXS,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.radiusCircular),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppConstants.spaceXS),
                Text(
                  'Available for work',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationList(BuildContext context, String currentLocation) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceMD),
      children: [
        // Main navigation items
        ..._navigationItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isActive = _isNavItemActive(currentLocation, item.path);

          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(
              milliseconds: 200 + (index * 100),
            ),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(50 * (1 - value), 0),
                child: Opacity(
                  opacity: value,
                  child: _buildNavItem(context, item, isActive),
                ),
              );
            },
          );
        }),

        // Divider
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLG,
            vertical: AppConstants.spaceMD,
          ),
          child: Divider(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),

        // Additional items
        _buildAdditionalNavItem(
          context: context,
          title: 'Download Resume',
          icon: Icons.download_outlined,
          onTap: _downloadResume,
        ),

        _buildAdditionalNavItem(
          context: context,
          title: 'Admin Panel',
          icon: Icons.admin_panel_settings_outlined,
          onTap: () {
            Navigator.of(context).pop();
            context.go('/admin/login');
          },
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    DrawerNavigationItem item,
    bool isActive,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMD,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: isActive
            ? Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
                width: 1,
              )
            : null,
      ),
      child: ListTile(
        leading: Icon(
          isActive ? item.activeIcon : item.icon,
          color: isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
          size: 24,
        ),
        title: Text(
          item.name,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: () => _navigateToSection(context, item),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMD,
          vertical: AppConstants.spaceXS,
        ),
      ),
    );
  }

  Widget _buildAdditionalNavItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMD,
        vertical: AppConstants.spaceXS,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: theme.colorScheme.onSurfaceVariant,
          size: 24,
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMD,
          vertical: AppConstants.spaceXS,
        ),
      ),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Theme toggle
          Row(
            children: [
              Icon(
                Icons.palette_outlined,
                size: 20,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppConstants.spaceMD),
              Expanded(
                child: Text(
                  'Theme',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildThemeToggleSwitch(context),
            ],
          ),

          const SizedBox(height: AppConstants.spaceLG),

          // Social links
          _buildSocialLinks(context),

          const SizedBox(height: AppConstants.spaceMD),

          // Version info
          Text(
            'Version ${AppConstants.appVersion}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeToggleSwitch(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: widget.themeService.themeModeNotifier,
      builder: (context, themeMode, child) {
        final theme = Theme.of(context);
        final isDark = widget.themeService.isDarkMode(context);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.light_mode,
              size: 16,
              color: !isDark
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppConstants.spaceXS),
            Switch(
              value: isDark,
              onChanged: (_) => widget.themeService.toggleTheme(),
              activeColor: theme.colorScheme.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: AppConstants.spaceXS),
            Icon(
              Icons.dark_mode,
              size: 16,
              color: isDark
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect with me',
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),
        Wrap(
          spacing: AppConstants.spaceMD,
          runSpacing: AppConstants.spaceSM,
          children: _socialLinks.map((link) {
            return _buildSocialButton(context, link);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, SocialLink link) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _launchUrl(link.url),
      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spaceSM),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          link.icon,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  bool _isNavItemActive(String currentLocation, String itemPath) {
    if (itemPath == '/') {
      return currentLocation == '/';
    }
    return currentLocation.startsWith(itemPath);
  }

  void _navigateToSection(BuildContext context, DrawerNavigationItem item) {
    Navigator.of(context).pop();
    context.go(item.path);
  }

  void _downloadResume() {
    Navigator.of(context).pop();
    // Create a mock PDF download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Resume download started!'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Would open the PDF in browser/viewer
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not open $url'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening link: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}

// Models
class DrawerNavigationItem {
  final String name;
  final String path;
  final IconData icon;
  final IconData activeIcon;

  const DrawerNavigationItem({
    required this.name,
    required this.path,
    required this.icon,
    required this.activeIcon,
  });
}

class SocialLink {
  final String name;
  final IconData icon;
  final String url;
  final Color color;

  const SocialLink({
    required this.name,
    required this.icon,
    required this.url,
    required this.color,
  });
}

// Compact drawer for tablets
class CompactDrawer extends StatelessWidget {
  final ThemeService themeService;

  const CompactDrawer({
    super.key,
    required this.themeService,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 72,
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: AppConstants.spaceLG),
          // Logo
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
            child: Icon(
              Icons.code,
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(height: AppConstants.spaceLG),
          // Navigation icons
          Expanded(
            child: ListView(
              children: [
                _buildCompactNavItem(context, Icons.home_outlined, '/'),
                _buildCompactNavItem(context, Icons.person_outline, '/about'),
                _buildCompactNavItem(context, Icons.work_outline, '/projects'),
                _buildCompactNavItem(context, Icons.star_outline, '/skills'),
                _buildCompactNavItem(context, Icons.timeline_outlined, '/experience'),
                _buildCompactNavItem(context, Icons.email_outlined, '/contact'),
              ],
            ),
          ),
          // Theme toggle
          IconButton(
            onPressed: themeService.toggleTheme,
            icon: Icon(
              themeService.isDarkMode(context) 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
          ),
          const SizedBox(height: AppConstants.spaceLG),
        ],
      ),
    );
  }

  Widget _buildCompactNavItem(BuildContext context, IconData icon, String path) {
    final theme = Theme.of(context);
    final currentLocation = GoRouterState.of(context).uri.toString();
    final isActive = path == '/' 
        ? currentLocation == '/' 
        : currentLocation.startsWith(path);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceXS),
      child: IconButton(
        onPressed: () => context.go(path),
        icon: Icon(
          icon,
          color: isActive 
              ? theme.colorScheme.primary 
              : theme.colorScheme.onSurfaceVariant,
        ),
        style: IconButton.styleFrom(
          backgroundColor: isActive 
              ? theme.colorScheme.primary.withOpacity(0.1)
              : null,
        ),
      ),
    );
  }
}