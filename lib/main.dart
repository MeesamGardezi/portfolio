// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'features/shared/widgets/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(AppTheme.lightSystemOverlayStyle);
  
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final ThemeService _themeService = ThemeService();
  final AuthService _authService = AuthService();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _initializeRouter();
  }

  void _initializeRouter() {
    _router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final isAdminRoute = state.matchedLocation.startsWith('/admin');
        final isLoginRoute = state.matchedLocation == '/admin/login';
        
        if (isAdminRoute && !isLoginRoute && !_authService.isLoggedIn) {
          return '/admin/login';
        }
        if (isLoginRoute && _authService.isLoggedIn) {
          return '/admin/dashboard';
        }
        return null;
      },
      refreshListenable: _authService,
      routes: [
        // Public routes with AppLayout
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: HomePage(themeService: _themeService),
          ),
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: AboutPage(themeService: _themeService),
          ),
        ),
        GoRoute(
          path: '/projects',
          name: 'projects',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: ProjectsPage(themeService: _themeService),
          ),
          routes: [
            GoRoute(
              path: '/:projectId',
              name: 'project-detail',
              builder: (context, state) {
                final projectId = state.pathParameters['projectId']!;
                return AppLayout(
                  themeService: _themeService,
                  child: ProjectDetailPage(
                    projectId: projectId, 
                    themeService: _themeService,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/skills',
          name: 'skills',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: SkillsPage(themeService: _themeService),
          ),
        ),
        GoRoute(
          path: '/experience',
          name: 'experience',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: ExperiencePage(themeService: _themeService),
          ),
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: ContactPage(themeService: _themeService),
          ),
        ),
        GoRoute(
          path: '/blog',
          name: 'blog',
          builder: (context, state) => AppLayout(
            themeService: _themeService,
            child: BlogPage(themeService: _themeService),
          ),
          routes: [
            GoRoute(
              path: '/:postId',
              name: 'blog-post',
              builder: (context, state) {
                final postId = state.pathParameters['postId']!;
                return AppLayout(
                  themeService: _themeService,
                  child: BlogPostPage(
                    postId: postId, 
                    themeService: _themeService,
                  ),
                );
              },
            ),
          ],
        ),
        
        // Admin routes without AppLayout (minimal layout)
        GoRoute(
          path: '/admin/login',
          name: 'admin-login',
          builder: (context, state) => AdminLoginPage(
            authService: _authService,
            themeService: _themeService,
          ),
        ),
        GoRoute(
          path: '/admin/dashboard',
          name: 'admin-dashboard',
          builder: (context, state) => AdminDashboardPage(
            authService: _authService,
            themeService: _themeService,
          ),
        ),
        GoRoute(
          path: '/admin/projects',
          name: 'admin-projects',
          builder: (context, state) => AdminProjectsPage(
            authService: _authService,
            themeService: _themeService,
          ),
        ),
        GoRoute(
          path: '/admin/settings',
          name: 'admin-settings',
          builder: (context, state) => AdminSettingsPage(
            authService: _authService,
            themeService: _themeService,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeService.themeModeNotifier,
      builder: (context, themeMode, child) {
        // Update system UI overlay based on theme
        final brightness = themeMode == ThemeMode.dark 
            ? Brightness.dark 
            : themeMode == ThemeMode.light 
                ? Brightness.light 
                : MediaQuery.platformBrightnessOf(context);
                
        SystemChrome.setSystemUIOverlayStyle(
          AppTheme.getSystemOverlayStyle(brightness),
        );
        
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: _router,
        );
      },
    );
  }

  @override
  void dispose() {
    _themeService.dispose();
    _authService.dispose();
    super.dispose();
  }
}

// ========== THEME SERVICE ==========
class ThemeService extends ChangeNotifier {
  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.system);
  
  ValueNotifier<ThemeMode> get themeModeNotifier => _themeModeNotifier;
  ThemeMode get themeMode => _themeModeNotifier.value;
  
  void setThemeMode(ThemeMode mode) {
    if (_themeModeNotifier.value != mode) {
      _themeModeNotifier.value = mode;
      notifyListeners();
    }
  }
  
  void toggleTheme() {
    switch (_themeModeNotifier.value) {
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setThemeMode(ThemeMode.light);
        break;
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
        break;
    }
  }
  
  bool isDarkMode(BuildContext context) {
    switch (_themeModeNotifier.value) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
  }
  
  @override
  void dispose() {
    _themeModeNotifier.dispose();
    super.dispose();
  }
}

// ========== AUTH SERVICE ==========
class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  
  bool get isLoggedIn => _isLoggedIn;
  
  Future<bool> login(String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (password == 'admin123') {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }
  
  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

// ========== PUBLIC PAGES ==========
class HomePage extends StatelessWidget {
  final ThemeService themeService;
  
  const HomePage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hero section
            Container(
              padding: const EdgeInsets.all(AppConstants.spaceXL),
              decoration: BoxDecoration(
                gradient: theme.heroGradient,
                borderRadius: BorderRadius.circular(AppConstants.radiusLG),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome to My Portfolio',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  Text(
                    'Full Stack Developer & UI/UX Designer\nCreating amazing digital experiences',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppConstants.spaceXL),
                  Wrap(
                    spacing: AppConstants.spaceMD,
                    runSpacing: AppConstants.spaceMD,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => context.go('/projects'),
                        icon: const Icon(Icons.work_outline),
                        label: const Text('View Projects'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => context.go('/contact'),
                        icon: const Icon(Icons.email_outlined),
                        label: const Text('Get in Touch'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppConstants.spaceXXL),
            
            // Quick navigation
            Text(
              'Explore',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: AppConstants.isMobile(MediaQuery.of(context).size.width) ? 2 : 4,
              crossAxisSpacing: AppConstants.spaceMD,
              mainAxisSpacing: AppConstants.spaceMD,
              children: [
                _buildQuickNavCard(context, 'About', Icons.person_outline, '/about'),
                _buildQuickNavCard(context, 'Projects', Icons.work_outline, '/projects'),
                _buildQuickNavCard(context, 'Skills', Icons.star_outline, '/skills'),
                _buildQuickNavCard(context, 'Contact', Icons.email_outlined, '/contact'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickNavCard(BuildContext context, String title, IconData icon, String path) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: () => context.go(path),
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: AppConstants.spaceSM),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final ThemeService themeService;
  
  const AboutPage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'About Me',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppConstants.spaceLG),
              const Text(
                'This is the About page. Here you would typically include information about yourself, your background, experience, and what drives you as a developer.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  final ThemeService themeService;
  
  const ProjectsPage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          children: [
            Text(
              'My Projects',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            const Text(
              'Here are some of my featured projects:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spaceXL),
            ElevatedButton(
              onPressed: () => context.go('/projects/sample-project'),
              child: const Text('View Sample Project'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailPage extends StatelessWidget {
  final String projectId;
  final ThemeService themeService;
  
  const ProjectDetailPage({super.key, required this.projectId, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          children: [
            Text(
              'Project: $projectId',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            Text(
              'This is the detail page for project: $projectId',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spaceXL),
            ElevatedButton(
              onPressed: () => context.go('/projects'),
              child: const Text('Back to Projects'),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillsPage extends StatelessWidget {
  final ThemeService themeService;
  
  const SkillsPage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Skills',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            const Text(
              'Here you would showcase your technical skills, programming languages, frameworks, and tools you work with.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ExperiencePage extends StatelessWidget {
  final ThemeService themeService;
  
  const ExperiencePage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Experience',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            const Text(
              'This page would contain your work experience, education, and career timeline.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final ThemeService themeService;
  
  const ContactPage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact Me',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            const Text(
              'Get in touch! This page would contain a contact form and your contact information.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BlogPage extends StatelessWidget {
  final ThemeService themeService;
  
  const BlogPage({super.key, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Blog',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            const Text(
              'Welcome to my blog! Here you would find articles about development, tutorials, and insights.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BlogPostPage extends StatelessWidget {
  final String postId;
  final ThemeService themeService;
  
  const BlogPostPage({super.key, required this.postId, required this.themeService});
  
  @override
  Widget build(BuildContext context) {
    return AnimatedPageWrapper(
      child: SectionLayout(
        child: Column(
          children: [
            Text(
              'Blog Post: $postId',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            Text(
              'This is the content for blog post: $postId',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spaceXL),
            ElevatedButton(
              onPressed: () => context.go('/blog'),
              child: const Text('Back to Blog'),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== ADMIN PAGES ==========
class AdminLoginPage extends StatefulWidget {
  final AuthService authService;
  final ThemeService themeService;
  
  const AdminLoginPage({
    super.key, 
    required this.authService,
    required this.themeService,
  });
  
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
        actions: [
          IconButton(
            onPressed: widget.themeService.toggleTheme,
            icon: Icon(
              widget.themeService.isDarkMode(context) 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            margin: const EdgeInsets.all(AppConstants.spaceLG),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spaceXL),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  Text(
                    'Admin Access',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _errorMessage,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    onSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: AppConstants.spaceLG),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading 
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spaceMD),
                  Text(
                    'Hint: admin123',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    final success = await widget.authService.login(_passwordController.text);
    
    setState(() => _isLoading = false);
    
    if (success) {
      if (mounted) context.go('/admin/dashboard');
    } else {
      setState(() => _errorMessage = 'Invalid password');
    }
  }
  
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}

class AdminDashboardPage extends StatelessWidget {
  final AuthService authService;
  final ThemeService themeService;
  
  const AdminDashboardPage({
    super.key, 
    required this.authService,
    required this.themeService,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: themeService.toggleTheme,
            icon: Icon(
              themeService.isDarkMode(context) 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: () {
              authService.logout();
              context.go('/');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Admin Dashboard',
              style: theme.textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.spaceLG),
            const Text(
              'From here you can manage your portfolio content, projects, blog posts, and settings.',
            ),
            const SizedBox(height: AppConstants.spaceXL),
            Wrap(
              spacing: AppConstants.spaceMD,
              runSpacing: AppConstants.spaceMD,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.go('/admin/projects'),
                  icon: const Icon(Icons.work_outline),
                  label: const Text('Manage Projects'),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.go('/admin/settings'),
                  icon: const Icon(Icons.settings_outlined),
                  label: const Text('Settings'),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.public),
                  label: const Text('View Public Site'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdminProjectsPage extends StatelessWidget {
  final AuthService authService;
  final ThemeService themeService;
  
  const AdminProjectsPage({
    super.key, 
    required this.authService,
    required this.themeService,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Projects'),
        actions: [
          IconButton(
            onPressed: themeService.toggleTheme,
            icon: Icon(
              themeService.isDarkMode(context) 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Project management interface would go here'),
      ),
    );
  }
}

class AdminSettingsPage extends StatelessWidget {
  final AuthService authService;
  final ThemeService themeService;
  
  const AdminSettingsPage({
    super.key, 
    required this.authService,
    required this.themeService,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: themeService.toggleTheme,
            icon: Icon(
              themeService.isDarkMode(context) 
                  ? Icons.light_mode 
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Settings interface would go here'),
      ),
    );
  }
}