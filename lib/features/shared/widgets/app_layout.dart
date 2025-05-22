// lib/features/shared/widgets/app_layout.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../main.dart';
import 'header_widget.dart';
import 'footer_widget.dart';
import 'mobile_drawer.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  final ThemeService themeService;

  const AppLayout({
    super.key,
    required this.child,
    required this.themeService,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  
  bool _showScrollToTop = false;
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    
    _fabAnimationController = AnimationController(
      duration: AppConstants.durationFast,
      vsync: this,
    );
    
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = _scrollController.offset > 300;
    if (shouldShow != _showScrollToTop) {
      setState(() => _showScrollToTop = shouldShow);
      if (shouldShow) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final isAdminRoute = currentLocation.startsWith('/admin');
    final isLoginRoute = currentLocation == '/admin/login';
    final shouldShowNavigation = !isAdminRoute || isLoginRoute;
    
    // For admin routes (except login), use minimal layout
    if (isAdminRoute && !isLoginRoute) {
      return _buildAdminLayout();
    }
    
    // For public routes, use full layout
    return _buildPublicLayout(shouldShowNavigation);
  }

  Widget _buildAdminLayout() {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: widget.child,
      ),
    );
  }

  Widget _buildPublicLayout(bool showNavigation) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isMobile = AppConstants.isMobile(screenWidth);
        final isTablet = AppConstants.isTablet(screenWidth);
        
        return Scaffold(
          key: _scaffoldKey,
          
          // Header
          appBar: showNavigation ? PreferredSize(
            preferredSize: const Size.fromHeight(AppConstants.headerHeight),
            child: AnimatedHeader(
              themeService: widget.themeService,
              onMenuPressed: isMobile ? _openDrawer : null,
              scrollController: _scrollController,
            ),
          ) : null,
          
          // Mobile drawer
          drawer: isMobile && showNavigation 
              ? MobileDrawer(themeService: widget.themeService)
              : null,
          
          // Side navigation for tablet
          body: Row(
            children: [
              if (isTablet && showNavigation && !isMobile)
                CompactDrawer(themeService: widget.themeService),
              
              // Main content
              Expanded(
                child: _buildMainContent(constraints, showNavigation),
              ),
            ],
          ),
          
          // Floating action button for scroll to top
          floatingActionButton: showNavigation ? _buildScrollToTopButton() : null,
          
          // Disable drawer swipe on desktop
          drawerEnableOpenDragGesture: isMobile,
          
          // Handle drawer state changes
          onDrawerChanged: (isOpen) {
            setState(() => _isDrawerOpen = isOpen);
          },
        );
      },
    );
  }

  Widget _buildMainContent(BoxConstraints constraints, bool showNavigation) {
    final isMobile = AppConstants.isMobile(constraints.maxWidth);
    
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Main content
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              // Page content
              Expanded(
                child: _buildPageContent(constraints),
              ),
              
              // Footer (only for public routes)
              if (showNavigation) const FooterWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageContent(BoxConstraints constraints) {
    final isMobile = AppConstants.isMobile(constraints.maxWidth);
    
    if (isMobile) {
      // Mobile: Full width content
      return widget.child;
    } else {
      // Desktop: Centered content with max width
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: widget.child,
        ),
      );
    }
  }

  Widget _buildScrollToTopButton() {
    return AnimatedBuilder(
      animation: _fabAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _fabAnimation.value,
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            tooltip: 'Scroll to top',
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        );
      },
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: AppConstants.durationSlow,
      curve: Curves.easeInOut,
    );
  }
}

// Compact drawer for tablets
class CompactDrawer extends StatelessWidget {
  final ThemeService themeService;

  const CompactDrawer({
    super.key,
    required this.themeService,
  });

  final List<CompactNavItem> _navItems = const [
    CompactNavItem(icon: Icons.home_outlined, path: '/', tooltip: 'Home'),
    CompactNavItem(icon: Icons.person_outline, path: '/about', tooltip: 'About'),
    CompactNavItem(icon: Icons.work_outline, path: '/projects', tooltip: 'Projects'),
    CompactNavItem(icon: Icons.star_outline, path: '/skills', tooltip: 'Skills'),
    CompactNavItem(icon: Icons.timeline_outlined, path: '/experience', tooltip: 'Experience'),
    CompactNavItem(icon: Icons.email_outlined, path: '/contact', tooltip: 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentLocation = GoRouterState.of(context).uri.toString();
    
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            offset: const Offset(2, 0),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppConstants.spaceLG),
            
            // Logo
            Container(
              width: 48,
              height: 48,
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
              child: InkWell(
                onTap: () => context.go('/'),
                borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                child: Icon(
                  Icons.code,
                  color: theme.colorScheme.onPrimary,
                  size: 24,
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.spaceXL),
            
            // Navigation items
            Expanded(
              child: Column(
                children: _navItems.map((item) {
                  final isActive = item.path == '/' 
                      ? currentLocation == '/' 
                      : currentLocation.startsWith(item.path);
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.spaceXS,
                    ),
                    child: _buildCompactNavItem(context, item, isActive),
                  );
                }).toList(),
              ),
            ),
            
            // Theme toggle
            Padding(
              padding: const EdgeInsets.all(AppConstants.spaceMD),
              child: _buildCompactThemeToggle(context),
            ),
            
            const SizedBox(height: AppConstants.spaceLG),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactNavItem(
    BuildContext context,
    CompactNavItem item,
    bool isActive,
  ) {
    final theme = Theme.of(context);
    
    return Tooltip(
      message: item.tooltip,
      preferBelow: false,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive 
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          border: isActive ? Border.all(
            color: theme.colorScheme.primary.withOpacity(0.3),
            width: 1,
          ) : null,
        ),
        child: IconButton(
          onPressed: () => context.go(item.path),
          icon: Icon(
            item.icon,
            color: isActive 
                ? theme.colorScheme.primary 
                : theme.colorScheme.onSurfaceVariant,
            size: 24,
          ),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactThemeToggle(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService.themeModeNotifier,
      builder: (context, themeMode, child) {
        final theme = Theme.of(context);
        final isDark = themeService.isDarkMode(context);
        
        return Tooltip(
          message: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppConstants.radiusMD),
            ),
            child: IconButton(
              onPressed: themeService.toggleTheme,
              icon: AnimatedSwitcher(
                duration: AppConstants.durationFast,
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  key: ValueKey(isDark),
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              ),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Section layout wrapper for consistent spacing
class SectionLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool fullWidth;
  final bool centerContent;

  const SectionLayout({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.fullWidth = false,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = AppConstants.isMobile(screenWidth);
    
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: isMobile ? AppConstants.spaceMD : AppConstants.spaceLG,
      vertical: AppConstants.spaceXL,
    );

    Widget content = Container(
      width: double.infinity,
      padding: padding ?? defaultPadding,
      color: backgroundColor,
      child: child,
    );

    if (!fullWidth && centerContent) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: content,
        ),
      );
    }

    return content;
  }
}

// Page wrapper with animations
class AnimatedPageWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedPageWrapper({
    super.key,
    required this.child,
    this.duration = AppConstants.durationMedium,
  });

  @override
  State<AnimatedPageWrapper> createState() => _AnimatedPageWrapperState();
}

class _AnimatedPageWrapperState extends State<AnimatedPageWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

// Loading overlay
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spaceLG),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      if (message != null) ...[
                        const SizedBox(height: AppConstants.spaceMD),
                        Text(
                          message!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// Models
class CompactNavItem {
  final IconData icon;
  final String path;
  final String tooltip;

  const CompactNavItem({
    required this.icon,
    required this.path,
    required this.tooltip,
  });
}