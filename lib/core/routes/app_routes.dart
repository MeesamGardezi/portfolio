// lib/core/routes/app_routes.dart
class AppRoutes {
  AppRoutes._(); // Private constructor to prevent instantiation

  // ========== ROUTE PATHS ==========
  
  // Main routes
  static const String home = '/';
  static const String about = '/about';
  static const String projects = '/projects';
  static const String skills = '/skills';
  static const String experience = '/experience';
  static const String contact = '/contact';
  static const String blog = '/blog';
  static const String resume = '/resume';
  
  // Project routes
  static const String projectDetail = '/projects/:projectId';
  static const String projectCategory = '/projects/category/:category';
  
  // Blog routes
  static const String blogPost = '/blog/:postId';
  static const String blogCategory = '/blog/category/:category';
  
  // Admin routes
  static const String admin = '/admin';
  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminProjects = '/admin/projects';
  static const String adminProjectCreate = '/admin/projects/create';
  static const String adminProjectEdit = '/admin/projects/edit/:projectId';
  static const String adminBlog = '/admin/blog';
  static const String adminBlogCreate = '/admin/blog/create';
  static const String adminBlogEdit = '/admin/blog/edit/:postId';
  static const String adminGallery = '/admin/gallery';
  static const String adminSettings = '/admin/settings';
  
  // Utility routes
  static const String notFound = '/404';
  static const String maintenance = '/maintenance';
  
  // ========== ROUTE NAMES ==========
  
  // Main route names
  static const String homeName = 'home';
  static const String aboutName = 'about';
  static const String projectsName = 'projects';
  static const String skillsName = 'skills';
  static const String experienceName = 'experience';
  static const String contactName = 'contact';
  static const String blogName = 'blog';
  static const String resumeName = 'resume';
  
  // Project route names
  static const String projectDetailName = 'project-detail';
  static const String projectCategoryName = 'project-category';
  
  // Blog route names
  static const String blogPostName = 'blog-post';
  static const String blogCategoryName = 'blog-category';
  
  // Admin route names
  static const String adminName = 'admin';
  static const String adminLoginName = 'admin-login';
  static const String adminDashboardName = 'admin-dashboard';
  static const String adminProjectsName = 'admin-projects';
  static const String adminProjectCreateName = 'admin-project-create';
  static const String adminProjectEditName = 'admin-project-edit';
  static const String adminBlogName = 'admin-blog';
  static const String adminBlogCreateName = 'admin-blog-create';
  static const String adminBlogEditName = 'admin-blog-edit';
  static const String adminGalleryName = 'admin-gallery';
  static const String adminSettingsName = 'admin-settings';
  
  // Utility route names
  static const String notFoundName = 'not-found';
  static const String maintenanceName = 'maintenance';
  
  // ========== NAVIGATION SECTIONS ==========
  
  /// Main navigation sections for the homepage
  static const List<NavigationSection> mainSections = [
    NavigationSection(
      name: 'Home',
      path: home,
      routeName: homeName,
      sectionId: 'hero',
      icon: 'home',
    ),
    NavigationSection(
      name: 'About',
      path: about,
      routeName: aboutName,
      sectionId: 'about',
      icon: 'person',
    ),
    NavigationSection(
      name: 'Projects',
      path: projects,
      routeName: projectsName,
      sectionId: 'projects',
      icon: 'work',
    ),
    NavigationSection(
      name: 'Skills',
      path: skills,
      routeName: skillsName,
      sectionId: 'skills',
      icon: 'star',
    ),
    NavigationSection(
      name: 'Experience',
      path: experience,
      routeName: experienceName,
      sectionId: 'experience',
      icon: 'timeline',
    ),
    NavigationSection(
      name: 'Blog',
      path: blog,
      routeName: blogName,
      sectionId: 'blog',
      icon: 'article',
    ),
    NavigationSection(
      name: 'Contact',
      path: contact,
      routeName: contactName,
      sectionId: 'contact',
      icon: 'email',
    ),
  ];
  
  // ========== ROUTE UTILITIES ==========
  
  /// Generate project detail path
  static String projectDetailPath(String projectId) => '/projects/$projectId';
  
  /// Generate project category path
  static String projectCategoryPath(String category) => '/projects/category/$category';
  
  /// Generate blog post path
  static String blogPostPath(String postId) => '/blog/$postId';
  
  /// Generate blog category path
  static String blogCategoryPath(String category) => '/blog/category/$category';
  
  /// Generate admin project edit path
  static String adminProjectEditPath(String projectId) => '/admin/projects/edit/$projectId';
  
  /// Generate admin blog edit path
  static String adminBlogEditPath(String postId) => '/admin/blog/edit/$postId';
  
  /// Check if route requires authentication
  static bool requiresAuth(String routePath) {
    return routePath.startsWith('/admin') && routePath != adminLogin;
  }
  
  /// Check if route is admin route
  static bool isAdminRoute(String routePath) {
    return routePath.startsWith('/admin');
  }
  
  /// Check if route is public route (no auth needed)
  static bool isPublicRoute(String routePath) {
    return !requiresAuth(routePath);
  }
  
  /// Get section ID from route path
  static String? getSectionId(String routePath) {
    switch (routePath) {
      case home:
        return 'hero';
      case about:
        return 'about';
      case projects:
        return 'projects';
      case skills:
        return 'skills';
      case experience:
        return 'experience';
      case blog:
        return 'blog';
      case contact:
        return 'contact';
      default:
        return null;
    }
  }
  
  /// Get route name from path
  static String? getRouteName(String routePath) {
    switch (routePath) {
      case home:
        return homeName;
      case about:
        return aboutName;
      case projects:
        return projectsName;
      case skills:
        return skillsName;
      case experience:
        return experienceName;
      case blog:
        return blogName;
      case contact:
        return contactName;
      case admin:
        return adminName;
      case adminLogin:
        return adminLoginName;
      case adminDashboard:
        return adminDashboardName;
      case adminProjects:
        return adminProjectsName;
      case adminProjectCreate:
        return adminProjectCreateName;
      case adminBlog:
        return adminBlogName;
      case adminBlogCreate:
        return adminBlogCreateName;
      case adminGallery:
        return adminGalleryName;
      case adminSettings:
        return adminSettingsName;
      default:
        return null;
    }
  }
}

// ========== NAVIGATION SECTION CLASS ==========

/// Represents a navigation section in the app
class NavigationSection {
  final String name;
  final String path;
  final String routeName;
  final String sectionId;
  final String icon;
  final bool isExternal;

  const NavigationSection({
    required this.name,
    required this.path,
    required this.routeName,
    required this.sectionId,
    required this.icon,
    this.isExternal = false,
  });

  /// Check if this section is currently active based on current path
  bool isActive(String currentPath) {
    if (path == AppRoutes.home) {
      return currentPath == AppRoutes.home;
    }
    return currentPath.startsWith(path);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationSection &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          path == other.path &&
          routeName == other.routeName &&
          sectionId == other.sectionId &&
          icon == other.icon &&
          isExternal == other.isExternal;

  @override
  int get hashCode =>
      name.hashCode ^
      path.hashCode ^
      routeName.hashCode ^
      sectionId.hashCode ^
      icon.hashCode ^
      isExternal.hashCode;

  @override
  String toString() {
    return 'NavigationSection{name: $name, path: $path, routeName: $routeName, sectionId: $sectionId, icon: $icon, isExternal: $isExternal}';
  }
}