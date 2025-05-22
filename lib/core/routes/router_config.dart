// lib/core/routes/router_config.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

// Import page widgets (we'll create these in upcoming steps)
import '../../features/home/pages/home_page.dart';
import '../../features/about/pages/about_page.dart';
import '../../features/projects/pages/projects_page.dart';
import '../../features/projects/pages/project_detail_page.dart';
import '../../features/skills/pages/skills_page.dart';
import '../../features/experience/pages/experience_page.dart';
import '../../features/contact/pages/contact_page.dart';
import '../../features/blog/pages/blog_page.dart';
import '../../features/blog/pages/blog_post_page.dart';
import '../../features/admin/pages/admin_login_page.dart';
import '../../features/admin/pages/admin_dashboard_page.dart';
import '../../features/admin/pages/admin_projects_page.dart';
import '../../features/admin/pages/admin_project_form_page.dart';
import '../../features/admin/pages/admin_blog_page.dart';
import '../../features/admin/pages/admin_blog_form_page.dart';
import '../../features/admin/pages/admin_gallery_page.dart';
import '../../features/admin/pages/admin_settings_page.dart';
import '../../features/shared/pages/not_found_page.dart';
import '../../features/shared/pages/maintenance_page.dart';

// Import services (we'll create these later)
import '../../services/auth_service.dart';

class RouterConfig {
  RouterConfig._(); // Private constructor

  // ========== ROUTER INSTANCE ==========
  
  static late final GoRouter _router;
  
  /// Get the configured router instance
  static GoRouter get router => _router;
  
  // ========== ROUTER INITIALIZATION ==========
  
  /// Initialize the router configuration
  static void initialize({
    required AuthService authService,
  }) {
    _router = GoRouter(
      // Initial location
      initialLocation: AppRoutes.home,
      
      // Error page builder
      errorBuilder: (context, state) {
        return NotFoundPage(errorMessage: state.error?.toString());
      },
      
      // Redirect logic for authentication
      redirect: (context, state) {
        final isLoggedIn = authService.isLoggedIn;
        final isLoggingIn = state.matchedLocation == AppRoutes.adminLogin;
        final isAdminRoute = AppRoutes.isAdminRoute(state.matchedLocation);
        
        // If accessing admin route without login, redirect to login
        if (isAdminRoute && !isLoggedIn && !isLoggingIn) {
          return AppRoutes.adminLogin;
        }
        
        // If logged in and trying to access login page, redirect to dashboard
        if (isLoggedIn && isLoggingIn) {
          return AppRoutes.adminDashboard;
        }
        
        // No redirect needed
        return null;
      },
      
      // Refresh listener for auth changes
      refreshListenable: authService,
      
      // Route definitions
      routes: [
        // ========== MAIN ROUTES ==========
        
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.homeName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const HomePage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.about,
          name: AppRoutes.aboutName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AboutPage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.projects,
          name: AppRoutes.projectsName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const ProjectsPage(),
          ),
          routes: [
            // Project category route
            GoRoute(
              path: 'category/:category',
              name: AppRoutes.projectCategoryName,
              pageBuilder: (context, state) {
                final category = state.pathParameters['category']!;
                return _buildPage(
                  context: context,
                  state: state,
                  child: ProjectsPage(category: category),
                );
              },
            ),
            // Project detail route
            GoRoute(
              path: ':projectId',
              name: AppRoutes.projectDetailName,
              pageBuilder: (context, state) {
                final projectId = state.pathParameters['projectId']!;
                return _buildPage(
                  context: context,
                  state: state,
                  child: ProjectDetailPage(projectId: projectId),
                );
              },
            ),
          ],
        ),
        
        GoRoute(
          path: AppRoutes.skills,
          name: AppRoutes.skillsName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const SkillsPage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.experience,
          name: AppRoutes.experienceName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const ExperiencePage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.contact,
          name: AppRoutes.contactName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const ContactPage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.blog,
          name: AppRoutes.blogName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const BlogPage(),
          ),
          routes: [
            // Blog category route
            GoRoute(
              path: 'category/:category',
              name: AppRoutes.blogCategoryName,
              pageBuilder: (context, state) {
                final category = state.pathParameters['category']!;
                return _buildPage(
                  context: context,
                  state: state,
                  child: BlogPage(category: category),
                );
              },
            ),
            // Blog post route
            GoRoute(
              path: ':postId',
              name: AppRoutes.blogPostName,
              pageBuilder: (context, state) {
                final postId = state.pathParameters['postId']!;
                return _buildPage(
                  context: context,
                  state: state,
                  child: BlogPostPage(postId: postId),
                );
              },
            ),
          ],
        ),
        
        // ========== ADMIN ROUTES ==========
        
        GoRoute(
          path: AppRoutes.adminLogin,
          name: AppRoutes.adminLoginName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AdminLoginPage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.admin,
          name: AppRoutes.adminName,
          redirect: (context, state) => AppRoutes.adminDashboard,
        ),
        
        GoRoute(
          path: AppRoutes.adminDashboard,
          name: AppRoutes.adminDashboardName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AdminDashboardPage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.adminProjects,
          name: AppRoutes.adminProjectsName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AdminProjectsPage(),
          ),
          routes: [
            GoRoute(
              path: 'create',
              name: AppRoutes.adminProjectCreateName,
              pageBuilder: (context, state) => _buildPage(
                context: context,
                state: state,
                child: const AdminProjectFormPage(),
              ),
            ),
            GoRoute(
              path: 'edit/:projectId',
              name: AppRoutes.adminProjectEditName,
              pageBuilder: (context, state) {
                final projectId = state.pathParameters['projectId']!;
                return _buildPage(
                  context: context,
                  state: state,
                  child: AdminProjectFormPage(projectId: projectId),
                );
              },
            ),
          ],
        ),
        
        GoRoute(
          path: AppRoutes.adminBlog,
          name: AppRoutes.adminBlogName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AdminBlogPage(),
          ),
          routes: [
            GoRoute(
              path: 'create',
              name: AppRoutes.adminBlogCreateName,
              pageBuilder: (context, state) => _buildPage(
                context: context,
                state: state,
                child: const AdminBlogFormPage(),
              ),
            ),
            GoRoute(
              path: 'edit/:postId',
              name: AppRoutes.adminBlogEditName,
              pageBuilder: (context, state) {
                final postId = state.pathParameters['postId']!;
                return _buildPage(
                  context: context,
                  state: state,
                  child: AdminBlogFormPage(postId: postId),
                );
              },
            ),
          ],
        ),
        
        GoRoute(
          path: AppRoutes.adminGallery,
          name: AppRoutes.adminGalleryName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AdminGalleryPage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.adminSettings,
          name: AppRoutes.adminSettingsName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const AdminSettingsPage(),
          ),
        ),
        
        // ========== UTILITY ROUTES ==========
        
        GoRoute(
          path: AppRoutes.maintenance,
          name: AppRoutes.maintenanceName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const MaintenancePage(),
          ),
        ),
        
        GoRoute(
          path: AppRoutes.notFound,
          name: AppRoutes.notFoundName,
          pageBuilder: (context, state) => _buildPage(
            context: context,
            state: state,
            child: const NotFoundPage(),
          ),
        ),
      ],
    );
  }
  
  // ========== HELPER METHODS ==========
  
  /// Build a page with consistent transition and configuration
  static Page<T> _buildPage<T extends Object>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool opaque = true,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: transitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade transition for smooth navigation
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }
  
  // ========== NAVIGATION UTILITIES ==========
  
  /// Navigate to a route by path
  static void go(String path) {
    _router.go(path);
  }
  
  /// Navigate to a route by name with parameters
  static void goNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    _router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
  
  /// Push a route by path
  static void push(String path) {
    _router.push(path);
  }
  
  /// Push a route by name with parameters
  static void pushNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) {
    _router.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
  
  /// Pop the current route
  static void pop() {
    _router.pop();
  }
  
  /// Replace the current route with a new one
  static void pushReplacement(String path) {
    _router.pushReplacement(path);
  }
  
  /// Get current location
  static String get currentLocation => _router.routerDelegate.currentConfiguration.uri.toString();
  
  /// Check if we can pop
  static bool canPop() => _router.canPop();
  
  // ========== SPECIFIC NAVIGATION METHODS ==========
  
  /// Navigate to home page
  static void goToHome() => go(AppRoutes.home);
  
  /// Navigate to specific section (for scrolling on home page)
  static void goToSection(String sectionId) {
    go('${AppRoutes.home}#$sectionId');
  }
  
  /// Navigate to project detail
  static void goToProject(String projectId) {
    goNamed(AppRoutes.projectDetailName, pathParameters: {'projectId': projectId});
  }
  
  /// Navigate to project category
  static void goToProjectCategory(String category) {
    goNamed(AppRoutes.projectCategoryName, pathParameters: {'category': category});
  }
  
  /// Navigate to blog post
  static void goToBlogPost(String postId) {
    goNamed(AppRoutes.blogPostName, pathParameters: {'postId': postId});
  }
  
  /// Navigate to blog category
  static void goToBlogCategory(String category) {
    goNamed(AppRoutes.blogCategoryName, pathParameters: {'category': category});
  }
  
  /// Navigate to admin login
  static void goToAdminLogin() => go(AppRoutes.adminLogin);
  
  /// Navigate to admin dashboard
  static void goToAdminDashboard() => go(AppRoutes.adminDashboard);
  
  /// Navigate to admin project edit
  static void goToAdminProjectEdit(String projectId) {
    goNamed(AppRoutes.adminProjectEditName, pathParameters: {'projectId': projectId});
  }
  
  /// Navigate to admin blog edit
  static void goToAdminBlogEdit(String postId) {
    goNamed(AppRoutes.adminBlogEditName, pathParameters: {'postId': postId});
  }
  
  // ========== ROUTE INFORMATION ==========
  
  /// Get current route information
  static RouteInformation get currentRoute {
    final location = currentLocation;
    final uri = Uri.parse(location);
    
    return RouteInformation(
      path: uri.path,
      query: uri.query.isNotEmpty ? uri.query : null,
      fragment: uri.fragment.isNotEmpty ? uri.fragment : null,
    );
  }
  
  /// Check if currently on admin route
  static bool get isOnAdminRoute => AppRoutes.isAdminRoute(currentLocation);
  
  /// Check if currently on public route
  static bool get isOnPublicRoute => AppRoutes.isPublicRoute(currentLocation);
  
  /// Get current section ID (for homepage scrolling)
  static String? get currentSectionId {
    final route = currentRoute;
    if (route.path == AppRoutes.home && route.fragment != null) {
      return route.fragment;
    }
    return AppRoutes.getSectionId(route.path ?? '');
  }
}

// ========== ROUTE INFORMATION CLASS ==========

/// Extended route information with additional properties
class RouteInformation {
  final String path;
  final String? query;
  final String? fragment;

  const RouteInformation({
    required this.path,
    this.query,
    this.fragment,
  });

  /// Get full URI string
  String get fullPath {
    final buffer = StringBuffer(path);
    if (query != null && query!.isNotEmpty) {
      buffer.write('?$query');
    }
    if (fragment != null && fragment!.isNotEmpty) {
      buffer.write('#$fragment');
    }
    return buffer.toString();
  }

  /// Check if this is an admin route
  bool get isAdminRoute => AppRoutes.isAdminRoute(path);

  /// Check if this is a public route
  bool get isPublicRoute => AppRoutes.isPublicRoute(path);

  /// Get section ID if applicable
  String? get sectionId => AppRoutes.getSectionId(path);

  @override
  String toString() => fullPath;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteInformation &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          query == other.query &&
          fragment == other.fragment;

  @override
  int get hashCode => path.hashCode ^ query.hashCode ^ fragment.hashCode;
}