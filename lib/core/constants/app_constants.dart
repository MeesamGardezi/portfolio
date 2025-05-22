// lib/core/constants/app_constants.dart
import 'dart:ui';

class AppConstants {
  AppConstants._(); // Private constructor to prevent instantiation

  // ========== APP INFORMATION ==========
  static const String appName = 'Portfolio';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Personal Portfolio Website';
  static const String appAuthor = 'Your Name'; // TODO: Replace with actual name
  static const String appUrl = 'https://yourportfolio.com'; // TODO: Replace with actual URL
  
  // ========== CONTACT INFORMATION ==========
  static const String email = 'your.email@example.com'; // TODO: Replace with actual email
  static const String phone = '+1 (555) 123-4567'; // TODO: Replace with actual phone
  static const String location = 'Your City, Country'; // TODO: Replace with actual location
  
  // Social media links
  static const String githubUrl = 'https://github.com/yourusername'; // TODO: Replace
  static const String linkedinUrl = 'https://linkedin.com/in/yourusername'; // TODO: Replace
  static const String twitterUrl = 'https://twitter.com/yourusername'; // TODO: Replace
  static const String instagramUrl = 'https://instagram.com/yourusername'; // TODO: Replace
  static const String youtubeUrl = 'https://youtube.com/@yourusername'; // TODO: Replace
  static const String dribbbleUrl = 'https://dribbble.com/yourusername'; // TODO: Replace
  static const String behanceUrl = 'https://behance.net/yourusername'; // TODO: Replace
  
  // ========== LAYOUT CONSTANTS ==========
  
  // Spacing system (8px base unit)
  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  static const double spaceXXXL = 64.0;
  static const double spaceMax = 128.0;
  
  // Container constraints
  static const double maxContentWidth = 1200.0;
  static const double maxSidebarWidth = 280.0;
  static const double minSidebarWidth = 72.0;
  static const double headerHeight = 80.0;
  static const double footerHeight = 200.0;
  
  // ========== RESPONSIVE BREAKPOINTS ==========
  static const double breakpointXS = 0;     // Mobile small
  static const double breakpointSM = 576;   // Mobile large
  static const double breakpointMD = 768;   // Tablet
  static const double breakpointLG = 992;   // Desktop small
  static const double breakpointXL = 1200;  // Desktop large
  static const double breakpointXXL = 1400; // Desktop extra large
  
  // ========== BORDER RADIUS ==========
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircular = 100.0;
  
  // ========== ANIMATION DURATIONS ==========
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration durationXSlow = Duration(milliseconds: 800);
  static const Duration durationPage = Duration(milliseconds: 600);
  
  // ========== ELEVATION LEVELS ==========
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationMax = 16.0;
  
  // ========== IMAGE DIMENSIONS ==========
  
  // Avatar sizes
  static const double avatarSizeXS = 24.0;
  static const double avatarSizeSM = 32.0;
  static const double avatarSizeMD = 48.0;
  static const double avatarSizeLG = 64.0;
  static const double avatarSizeXL = 96.0;
  static const double avatarSizeXXL = 128.0;
  
  // Project image dimensions
  static const double projectThumbnailWidth = 300.0;
  static const double projectThumbnailHeight = 200.0;
  static const double projectImageMaxWidth = 800.0;
  static const double projectImageMaxHeight = 600.0;
  
  // Blog image dimensions
  static const double blogThumbnailWidth = 400.0;
  static const double blogThumbnailHeight = 250.0;
  static const double blogImageMaxWidth = 1000.0;
  static const double blogImageMaxHeight = 600.0;
  
  // Gallery image dimensions
  static const double galleryThumbnailSize = 150.0;
  static const double galleryImageMaxSize = 1200.0;
  
  // ========== FILE SIZE LIMITS ==========
  static const int maxImageSizeMB = 5;
  static const int maxImageSizeBytes = maxImageSizeMB * 1024 * 1024;
  static const int maxDocumentSizeMB = 10;
  static const int maxDocumentSizeBytes = maxDocumentSizeMB * 1024 * 1024;
  
  // ========== SUPPORTED FILE TYPES ==========
  static const List<String> supportedImageTypes = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
    'svg',
  ];
  
  static const List<String> supportedDocumentTypes = [
    'pdf',
    'doc',
    'docx',
    'txt',
  ];
  
  // ========== PAGINATION ==========
  static const int defaultPageSize = 12;
  static const int maxPageSize = 50;
  static const int adminPageSize = 20;
  
  // ========== FIREBASE COLLECTIONS ==========
  static const String projectsCollection = 'projects';
  static const String blogPostsCollection = 'blog_posts';
  static const String categoriesCollection = 'categories';
  static const String tagsCollection = 'tags';
  static const String testimonialsCollection = 'testimonials';
  static const String galleryCollection = 'gallery';
  static const String settingsCollection = 'settings';
  static const String analyticsCollection = 'analytics';
  static const String messagesCollection = 'messages';
  
  // ========== FIREBASE STORAGE PATHS ==========
  static const String projectImagesPath = 'images/projects';
  static const String blogImagesPath = 'images/blog';
  static const String galleryImagesPath = 'images/gallery';
  static const String documentsPath = 'documents';
  static const String resumePath = 'documents/resume';
  static const String avatarPath = 'images/avatar';
  
  // ========== CACHE KEYS ==========
  static const String cacheKeyProjects = 'projects_cache';
  static const String cacheKeyBlogPosts = 'blog_posts_cache';
  static const String cacheKeyCategories = 'categories_cache';
  static const String cacheKeySettings = 'settings_cache';
  static const String cacheKeyTheme = 'theme_cache';
  
  // ========== LOCAL STORAGE KEYS ==========
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyAnalyticsEnabled = 'analytics_enabled';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  
  // ========== ADMIN CREDENTIALS ==========
  static const String adminUsername = 'admin'; // TODO: Change this
  static const String adminPasswordKey = 'admin_password'; // Stored in secure storage
  
  // ========== SEO CONSTANTS ==========
  static const String defaultMetaTitle = 'Portfolio - Your Name';
  static const String defaultMetaDescription = 'Personal portfolio showcasing projects, skills, and experience in software development.';
  static const List<String> defaultMetaKeywords = [
    'portfolio',
    'developer',
    'flutter',
    'web development',
    'mobile development',
    'software engineer',
  ];
  
  // ========== ERROR MESSAGES ==========
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorAuth = 'Authentication failed. Please check your credentials.';
  static const String errorNotFound = 'The requested resource was not found.';
  static const String errorPermission = 'You don\'t have permission to access this resource.';
  static const String errorFileSize = 'File size exceeds the maximum limit.';
  static const String errorFileType = 'File type is not supported.';
  static const String errorValidation = 'Please check your input and try again.';
  
  // ========== SUCCESS MESSAGES ==========
  static const String successSaved = 'Changes saved successfully!';
  static const String successDeleted = 'Item deleted successfully!';
  static const String successUploaded = 'File uploaded successfully!';
  static const String successSent = 'Message sent successfully!';
  static const String successLoggedIn = 'Logged in successfully!';
  static const String successLoggedOut = 'Logged out successfully!';
  
  // ========== LOADING MESSAGES ==========
  static const String loadingDefault = 'Loading...';
  static const String loadingProjects = 'Loading projects...';
  static const String loadingBlog = 'Loading blog posts...';
  static const String loadingSaving = 'Saving...';
  static const String loadingUploading = 'Uploading...';
  static const String loadingDeleting = 'Deleting...';
  
  // ========== PLACEHOLDER TEXTS ==========
  static const String placeholderSearchProjects = 'Search projects...';
  static const String placeholderSearchBlog = 'Search blog posts...';
  static const String placeholderEmail = 'Enter your email';
  static const String placeholderMessage = 'Enter your message';
  static const String placeholderProjectTitle = 'Enter project title';
  static const String placeholderBlogTitle = 'Enter blog post title';
  
  // ========== VALIDATION PATTERNS ==========
  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String urlPattern = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';
  
  // ========== PROJECT CATEGORIES ==========
  static const List<String> defaultProjectCategories = [
    'Web Development',
    'Mobile Development',
    'Desktop Application',
    'API Development',
    'Database Design',
    'UI/UX Design',
    'DevOps',
    'Machine Learning',
    'Other',
  ];
  
  // ========== BLOG CATEGORIES ==========
  static const List<String> defaultBlogCategories = [
    'Technology',
    'Tutorial',
    'Project Showcase',
    'Industry News',
    'Personal',
    'Career',
    'Tips & Tricks',
    'Review',
  ];
  
  // ========== SKILLS CATEGORIES ==========
  static const List<String> defaultSkillCategories = [
    'Programming Languages',
    'Frameworks & Libraries',
    'Databases',
    'Tools & Software',
    'Cloud Services',
    'Soft Skills',
  ];
  
  // ========== CONTACT FORM FIELDS ==========
  static const List<String> contactFormSubjects = [
    'General Inquiry',
    'Project Collaboration',
    'Job Opportunity',
    'Freelance Work',
    'Speaking Engagement',
    'Other',
  ];
  
  // ========== UTILITY METHODS ==========
  
  /// Check if file size is within limits
  static bool isValidFileSize(int sizeInBytes, {bool isDocument = false}) {
    final maxSize = isDocument ? maxDocumentSizeBytes : maxImageSizeBytes;
    return sizeInBytes <= maxSize;
  }
  
  /// Check if file type is supported
  static bool isValidFileType(String extension, {bool isDocument = false}) {
    final supportedTypes = isDocument ? supportedDocumentTypes : supportedImageTypes;
    return supportedTypes.contains(extension.toLowerCase());
  }
  
  /// Format file size to human readable format
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  
  /// Get responsive breakpoint name for given width
  static String getBreakpointName(double width) {
    if (width >= breakpointXXL) return 'XXL';
    if (width >= breakpointXL) return 'XL';
    if (width >= breakpointLG) return 'LG';
    if (width >= breakpointMD) return 'MD';
    if (width >= breakpointSM) return 'SM';
    return 'XS';
  }
  
  /// Check if screen size is mobile
  static bool isMobile(double width) => width < breakpointMD;
  
  /// Check if screen size is tablet
  static bool isTablet(double width) => width >= breakpointMD && width < breakpointLG;
  
  /// Check if screen size is desktop
  static bool isDesktop(double width) => width >= breakpointLG;
  
  /// Get appropriate avatar size based on screen size
  static double getAvatarSize(double screenWidth) {
    if (isMobile(screenWidth)) return avatarSizeMD;
    if (isTablet(screenWidth)) return avatarSizeLG;
    return avatarSizeXL;
  }
  
  /// Get appropriate project thumbnail dimensions based on screen size
  static Size getProjectThumbnailSize(double screenWidth) {
    if (isMobile(screenWidth)) {
      return const Size(projectThumbnailWidth * 0.8, projectThumbnailHeight * 0.8);
    }
    return const Size(projectThumbnailWidth, projectThumbnailHeight);
  }
  
  /// Get grid column count based on screen size
  static int getGridColumnCount(double screenWidth) {
    if (isMobile(screenWidth)) return 1;
    if (isTablet(screenWidth)) return 2;
    if (screenWidth < breakpointXXL) return 3;
    return 4;
  }
}