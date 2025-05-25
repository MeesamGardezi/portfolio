// lib/features/shared/widgets/header_widget.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../main.dart';

class HeaderWidget extends StatefulWidget {
  final ThemeService themeService;
  final VoidCallback? onMenuPressed;

  const HeaderWidget({
    super.key,
    required this.themeService,
    this.onMenuPressed,
  });

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final List<NavigationItem> _navigationItems = [
    NavigationItem(name: 'Home', path: '/', icon: Icons.home_outlined),
    NavigationItem(name: 'About', path: '/about', icon: Icons.person_outline),
    NavigationItem(name: 'Projects', path: '/projects', icon: Icons.work_outline),
    NavigationItem(name: 'Skills', path: '/skills', icon: Icons.star_outline),
    NavigationItem(name: 'Experience', path: '/experience', icon: Icons.timeline_outlined),
    NavigationItem(name: 'Contact', path: '/contact', icon: Icons.email_outlined),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.durationMedium,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = AppConstants.isMobile(screenWidth);
    final isTablet = AppConstants.isTablet(screenWidth);
    
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: AppConstants.headerHeight,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppConstants.spaceMD : AppConstants.spaceLG,
            ),
            child: Row(
              children: [
                // Mobile menu button
                if (isMobile && widget.onMenuPressed != null) ...[
                  IconButton(
                    onPressed: widget.onMenuPressed,
                    icon: const Icon(Icons.menu),
                    tooltip: 'Open Menu',
                    iconSize: 24,
                  ),
                  const SizedBox(width: AppConstants.spaceMD),
                ],
                
                // Logo/Brand
                _buildLogo(context, isMobile),
                
                const Spacer(),
                
                // Desktop/Tablet navigation
                if (!isMobile) ...[
                  _buildDesktopNavigation(context, currentLocation, isTablet),
                  const SizedBox(width: AppConstants.spaceLG),
                ],
                
                // Theme toggle
                _buildThemeToggle(context),
                
                // Admin access button (desktop only)
                if (!isMobile) ...[
                  const SizedBox(width: AppConstants.spaceMD),
                  _buildAdminButton(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildLogo(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () => context.go('/'),
      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceSM,
          vertical: AppConstants.spaceSM,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo container with gradient
            Container(
              width: isMobile ? 36 : 42,
              height: isMobile ? 36 : 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                Icons.code,
                color: theme.colorScheme.onPrimary,
                size: isMobile ? 20 : 24,
              ),
            ),
            
            if (!isMobile) ...[
              const SizedBox(width: AppConstants.spaceMD),
              
              // Brand text
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfolio',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    'Developer',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDesktopNavigation(BuildContext context, String currentLocation, bool isTablet) {
    return Row(
      children: _navigationItems.map((item) {
        final isActive = _isNavItemActive(currentLocation, item.path);
        
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? AppConstants.spaceXS : AppConstants.spaceSM,
          ),
          child: _buildNavItem(context, item, isActive, isTablet),
        );
      }).toList(),
    );
  }
  
  Widget _buildNavItem(BuildContext context, NavigationItem item, bool isActive, bool isCompact) {
    final theme = Theme.of(context);
    
    return AnimatedContainer(
      duration: AppConstants.durationFast,
      curve: Curves.easeInOut,
      child: InkWell(
        onTap: () => context.go(item.path),
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? AppConstants.spaceSM : AppConstants.spaceMD,
            vertical: AppConstants.spaceSM,
          ),
          decoration: BoxDecoration(
            color: isActive 
                ? theme.colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            border: isActive ? Border.all(
              color: theme.colorScheme.primary.withOpacity(0.2),
              width: 1,
            ) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCompact) ...[
                Icon(
                  item.icon,
                  size: 18,
                  color: isActive 
                      ? theme.colorScheme.primary 
                      : theme.colorScheme.onSurface,
                ),
              ] else ...[
                Text(
                  item.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: isActive 
                        ? theme.colorScheme.primary 
                        : theme.colorScheme.onSurface,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildThemeToggle(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: widget.themeService.themeModeNotifier,
      builder: (context, themeMode, child) {
        final theme = Theme.of(context);
        final isDark = widget.themeService.isDarkMode(context);
        
        return AnimatedSwitcher(
          duration: AppConstants.durationFast,
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: IconButton(
            key: ValueKey(isDark),
            onPressed: widget.themeService.toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: theme.colorScheme.onSurface,
            ),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildAdminButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return IconButton(
      onPressed: () => context.go('/admin/login'),
      icon: Icon(
        Icons.admin_panel_settings_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      tooltip: 'Admin Access',
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
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
}

// Navigation item model
class NavigationItem {
  final String name;
  final String path;
  final IconData icon;

  const NavigationItem({
    required this.name,
    required this.path,
    required this.icon,
  });
}

// Animated header that responds to scroll
class AnimatedHeader extends StatefulWidget {
  final ThemeService themeService;
  final VoidCallback? onMenuPressed;
  final ScrollController? scrollController;

  const AnimatedHeader({
    super.key,
    required this.themeService,
    this.onMenuPressed,
    this.scrollController,
  });

  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elevationAnimation;
  late Animation<double> _backgroundOpacityAnimation;
  
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: AppConstants.durationFast,
      vsync: this,
    );
    
    _elevationAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _backgroundOpacityAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = widget.scrollController?.offset ?? 0;
    final shouldBeScrolled = offset > 50;
    
    if (shouldBeScrolled != _isScrolled) {
      setState(() => _isScrolled = shouldBeScrolled);
      
      if (shouldBeScrolled) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1 * _controller.value),
                offset: const Offset(0, 2),
                blurRadius: _elevationAnimation.value,
              ),
            ],
          ),
          child: Opacity(
            opacity: _backgroundOpacityAnimation.value,
            child: HeaderWidget(
              themeService: widget.themeService,
              onMenuPressed: widget.onMenuPressed,
            ),
          ),
        );
      },
    );
  }
}

// Sticky header that becomes visible on scroll up
class StickyHeader extends StatefulWidget {
  final ThemeService themeService;
  final Widget child;

  const StickyHeader({
    super.key,
    required this.themeService,
    required this.child,
  });

  @override
  State<StickyHeader> createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  
  ScrollController? _scrollController;
  double _lastScrollPosition = 0;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: AppConstants.durationFast,
      vsync: this,
    );
    
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentScrollPosition = _scrollController?.offset ?? 0;
    final isScrollingUp = currentScrollPosition < _lastScrollPosition;
    final shouldShow = isScrollingUp || currentScrollPosition < 100;
    
    if (shouldShow != _isVisible) {
      setState(() => _isVisible = shouldShow);
      
      if (shouldShow) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
    
    _lastScrollPosition = currentScrollPosition;
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: HeaderWidget(themeService: widget.themeService),
    );
  }
}