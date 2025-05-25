// lib/features/shared/widgets/footer_widget.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _emailController = TextEditingController();
  bool _isSubscribing = false;
  String? _subscriptionMessage;

  final List<FooterSection> _footerSections = [
    FooterSection(
      title: 'Quick Links',
      items: [
        FooterItem(name: 'Home', path: '/'),
        FooterItem(name: 'About', path: '/about'),
        FooterItem(name: 'Projects', path: '/projects'),
        FooterItem(name: 'Contact', path: '/contact'),
      ],
    ),
    FooterSection(
      title: 'Services',
      items: [
        FooterItem(name: 'Web Development', path: '/projects'),
        FooterItem(name: 'Mobile Apps', path: '/projects'),
        FooterItem(name: 'UI/UX Design', path: '/projects'),
        FooterItem(name: 'Consulting', path: '/contact'),
      ],
    ),
    FooterSection(
      title: 'Resources',
      items: [
        FooterItem(name: 'Blog', path: '/blog'),
        FooterItem(name: 'Resume', isDownload: true),
        FooterItem(name: 'Portfolio', path: '/projects'),
        FooterItem(name: 'Skills', path: '/skills'),
      ],
    ),
  ];

  final List<SocialMediaLink> _socialLinks = [
    SocialMediaLink(
      name: 'GitHub',
      icon: Icons.code,
      url: 'https://github.com',
      color: Color(0xFF333333),
    ),
    SocialMediaLink(
      name: 'LinkedIn',
      icon: Icons.work_outline,
      url: 'https://linkedin.com',
      color: Color(0xFF0077B5),
    ),
    SocialMediaLink(
      name: 'Twitter',
      icon: Icons.alternate_email,
      url: 'https://twitter.com',
      color: Color(0xFF1DA1F2),
    ),
    SocialMediaLink(
      name: 'Instagram',
      icon: Icons.camera_alt_outlined,
      url: 'https://instagram.com',
      color: Color(0xFFE4405F),
    ),
    SocialMediaLink(
      name: 'YouTube',
      icon: Icons.play_arrow_outlined,
      url: 'https://youtube.com',
      color: Color(0xFFFF0000),
    ),
    SocialMediaLink(
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
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = AppConstants.isMobile(screenWidth);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Main footer content
              Container(
                constraints: const BoxConstraints(
                  maxWidth: AppConstants.maxContentWidth,
                ),
                padding: EdgeInsets.all(
                  isMobile ? AppConstants.spaceLG : AppConstants.spaceXL,
                ),
                child: isMobile
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context),
              ),

              // Bottom bar
              _buildBottomBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand section
            Expanded(
              flex: 2,
              child: _buildBrandSection(context),
            ),

            // Navigation sections
            ..._footerSections.map((section) {
              return Expanded(
                child: _buildFooterSection(context, section),
              );
            }),

            // Newsletter section
            Expanded(
              flex: 2,
              child: _buildNewsletterSection(context),
            ),
          ],
        ),

        const SizedBox(height: AppConstants.spaceXL),

        // Social links
        _buildSocialLinksSection(context),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Brand section
        _buildBrandSection(context),

        const SizedBox(height: AppConstants.spaceXL),

        // Newsletter section
        _buildNewsletterSection(context),

        const SizedBox(height: AppConstants.spaceXL),

        // Navigation sections in grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: AppConstants.spaceMD,
            mainAxisSpacing: AppConstants.spaceMD,
          ),
          itemCount: _footerSections.length,
          itemBuilder: (context, index) {
            return _buildFooterSection(context, _footerSections[index]);
          },
        ),

        const SizedBox(height: AppConstants.spaceXL),

        // Social links
        _buildSocialLinksSection(context),
      ],
    );
  }

  Widget _buildBrandSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and brand
        Row(
          children: [
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
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                Icons.code,
                color: theme.colorScheme.onPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppConstants.spaceMD),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Portfolio',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  'Developer',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: AppConstants.spaceLG),

        // Description
        Text(
          'Crafting digital experiences with passion and precision. Specialized in modern web and mobile development.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.6,
          ),
        ),

        const SizedBox(height: AppConstants.spaceLG),

        // Contact info
        _buildContactInfo(context),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(
          context,
          Icons.email_outlined,
          'hello@portfolio.com',
          'mailto:hello@portfolio.com',
        ),
        const SizedBox(height: AppConstants.spaceSM),
        _buildContactItem(
          context,
          Icons.phone_outlined,
          '+1 (555) 123-4567',
          'tel:+15551234567',
        ),
        const SizedBox(height: AppConstants.spaceSM),
        _buildContactItem(
          context,
          Icons.location_on_outlined,
          'San Francisco, CA',
          null,
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    String? url,
  ) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: url != null ? () => _launchUrl(url) : null,
      borderRadius: BorderRadius.circular(AppConstants.radiusSM),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceXS),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: AppConstants.spaceSM),
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context, FooterSection section) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.spaceMD),
        ...section.items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spaceSM),
            child: InkWell(
              onTap: () => _handleFooterItemTap(item),
              borderRadius: BorderRadius.circular(AppConstants.radiusSM),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spaceXS,
                ),
                child: Text(
                  item.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNewsletterSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stay Updated',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.spaceSM),
        Text(
          'Get the latest updates on new projects and tech insights.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppConstants.spaceLG),

        // Newsletter form
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spaceMD,
                    vertical: AppConstants.spaceMD,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(width: AppConstants.spaceSM),
            ElevatedButton(
              onPressed: _isSubscribing ? null : _subscribeToNewsletter,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(AppConstants.spaceMD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
              ),
              child: _isSubscribing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.arrow_forward),
            ),
          ],
        ),

        if (_subscriptionMessage != null) ...[
          const SizedBox(height: AppConstants.spaceSM),
          Text(
            _subscriptionMessage!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: _subscriptionMessage!.contains('Success')
                  ? theme.colorScheme.primary
                  : theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSocialLinksSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          'Connect with me',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.spaceLG),
        Wrap(
          spacing: AppConstants.spaceMD,
          runSpacing: AppConstants.spaceMD,
          alignment: WrapAlignment.center,
          children: _socialLinks.map((link) {
            return _buildSocialButton(context, link);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, SocialMediaLink link) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _launchUrl(link.url),
      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      child: Container(
        width: 48,
        height: 48,
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
          size: 24,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final currentYear = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© $currentYear Portfolio. All rights reserved.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => _showPrivacyDialog(context),
                        child: Text(
                          'Privacy',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showTermsDialog(context),
                        child: Text(
                          'Terms',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceSM),
              Text(
                'Made with ❤️ using Flutter',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFooterItemTap(FooterItem item) {
    if (item.isDownload) {
      _downloadResume();
    } else if (item.path != null) {
      context.go(item.path!);
    }
  }

  Future<void> _subscribeToNewsletter() async {
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _subscriptionMessage = 'Please enter your email address';
      });
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      setState(() {
        _subscriptionMessage = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      _isSubscribing = true;
      _subscriptionMessage = null;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSubscribing = false;
      _subscriptionMessage = 'Success! You\'ve been subscribed to our newsletter.';
    });

    _emailController.clear();

    // Clear message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _subscriptionMessage = null;
        });
      }
    });
  }

  void _downloadResume() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Resume download started!'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Would open the PDF
          },
        ),
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text(
          'This portfolio website respects your privacy. We do not collect personal information without your consent.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const Text(
          'By using this website, you agree to our terms of service. This portfolio is for demonstration purposes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
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
class FooterSection {
  final String title;
  final List<FooterItem> items;

  const FooterSection({
    required this.title,
    required this.items,
  });
}

class FooterItem {
  final String name;
  final String? path;
  final bool isDownload;

  const FooterItem({
    required this.name,
    this.path,
    this.isDownload = false,
  });
}

class SocialMediaLink {
  final String name;
  final IconData icon;
  final String url;
  final Color color;

  const SocialMediaLink({
    required this.name,
    required this.icon,
    required this.url,
    required this.color,
  });
}