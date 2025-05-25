// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_constants.dart';

/// A comprehensive theme class for the Portfolio application.
/// Contains design tokens, theme data, and utility methods for styling.
/// Uses a minimalistic color palette: #CFFCFF, #508991, #172A3A, Black, White
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation
  
  // ========== MODE DETECTION ==========
  /// Determines if the current theme mode is dark
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  
  // ========== THEME MODES ==========
  /// Gets the appropriate theme based on the system preference
  static ThemeData getTheme(Brightness brightness) =>
      brightness == Brightness.dark ? darkTheme : lightTheme;
      
  // ========== CUSTOM COLOR PALETTE ==========
  
  // Your custom colors
  static const Color lightCyan = Color(0xFFCFFCFF);     // #CFFCFF - Light cyan
  static const Color mediumTeal = Color(0xFF508991);    // #508991 - Medium teal 
  static const Color darkNavy = Color(0xFF172A3A);      // #172A3A - Dark navy
  static const Color pureBlack = Color(0xFF000000);     // #000000 - Pure black
  static const Color pureWhite = Color(0xFFFFFFFF);     // #FFFFFF - Pure white
  
  // Derived colors for better UX
  static const Color lightCyanHover = Color(0xFFB8F5F8);    // Darker cyan for hover
  static const Color mediumTealLight = Color(0xFF6BA3AD);    // Lighter teal
  static const Color mediumTealDark = Color(0xFF3D6B73);     // Darker teal
  static const Color darkNavyLight = Color(0xFF243644);      // Lighter navy
  static const Color softGray = Color(0xFFF8FAFB);          // Very light gray
  static const Color mediumGray = Color(0xFFE2E8F0);        // Medium gray
  static const Color darkGray = Color(0xFF64748B);          // Dark gray
  
  // ========== COLOR ASSIGNMENTS ==========
  
  // Light theme colors
  static const Color _lightPrimaryColor = mediumTeal;
  static const Color _lightSecondaryColor = mediumTealLight;
  static const Color _lightTertiaryColor = lightCyan;
  
  static const Color _lightNeutralBg = pureWhite;
  static const Color _lightNeutralCard = pureWhite;
  static const Color _lightNeutralSurface = softGray;
  static const Color _lightNeutralBorder = mediumGray;
  static const Color _lightNeutralDisabled = Color(0xFFCBD5E1);
  
  static const Color _lightTextPrimary = darkNavy;
  static const Color _lightTextSecondary = Color(0xFF475569);
  static const Color _lightTextTertiary = darkGray;
  static const Color _lightTextOnPrimary = pureWhite;
  
  // Dark theme colors
  static const Color _darkPrimaryColor = lightCyan;
  static const Color _darkSecondaryColor = mediumTealLight;
  static const Color _darkTertiaryColor = mediumTeal;
  
  static const Color _darkNeutralBg = darkNavy;
  static const Color _darkNeutralCard = darkNavyLight;
  static const Color _darkNeutralSurface = Color(0xFF334155);
  static const Color _darkNeutralBorder = Color(0xFF475569);
  static const Color _darkNeutralDisabled = Color(0xFF64748B);
  
  static const Color _darkTextPrimary = pureWhite;
  static const Color _darkTextSecondary = Color(0xFFE2E8F0);
  static const Color _darkTextTertiary = Color(0xFFCBD5E1);
  static const Color _darkTextOnPrimary = darkNavy;
  
  // Status colors - Universal
  static const Color _lightError = Color(0xFFDC2626);     // Red 600
  static const Color _lightSuccess = Color(0xFF16A34A);   // Green 600
  static const Color _lightWarning = Color(0xFFD97706);   // Amber 600
  static const Color _lightInfo = mediumTeal;             // Our teal color
  
  static const Color _darkError = Color(0xFFEF4444);      // Red 500
  static const Color _darkSuccess = Color(0xFF22C55E);    // Green 500
  static const Color _darkWarning = Color(0xFFF59E0B);    // Amber 500
  static const Color _darkInfo = lightCyan;               // Our light cyan
  
  // ========== TYPOGRAPHY SCALE ==========
  static const TextStyle _displayLargeBase = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -1.0,
  );
  
  static const TextStyle _displayMediumBase = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static const TextStyle _displaySmallBase = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.25,
  );
  
  static const TextStyle _headlineLargeBase = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );
  
  static const TextStyle _headlineMediumBase = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  
  static const TextStyle _headlineSmallBase = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static const TextStyle _titleLargeBase = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );
  
  static const TextStyle _titleMediumBase = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const TextStyle _titleSmallBase = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  static const TextStyle _bodyLargeBase = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );
  
  static const TextStyle _bodyMediumBase = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const TextStyle _bodySmallBase = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  
  static const TextStyle _labelLargeBase = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  static const TextStyle _labelMediumBase = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static const TextStyle _labelSmallBase = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  // ========== SHADOWS ==========
  static List<BoxShadow> get shadowSmall => [
        BoxShadow(
          color: darkNavy.withOpacity(0.08),
          offset: const Offset(0, 1),
          blurRadius: 3,
        ),
      ];
  
  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: darkNavy.withOpacity(0.1),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];
  
  static List<BoxShadow> get shadowLarge => [
        BoxShadow(
          color: darkNavy.withOpacity(0.12),
          offset: const Offset(0, 8),
          blurRadius: 24,
          spreadRadius: 0,
        ),
      ];
      
  // Dark theme shadows are more subtle
  static List<BoxShadow> get shadowSmallDark => [
        BoxShadow(
          color: pureBlack.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 3,
        ),
      ];
  
  static List<BoxShadow> get shadowMediumDark => [
        BoxShadow(
          color: pureBlack.withOpacity(0.25),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];
  
  static List<BoxShadow> get shadowLargeDark => [
        BoxShadow(
          color: pureBlack.withOpacity(0.3),
          offset: const Offset(0, 8),
          blurRadius: 24,
          spreadRadius: 0,
        ),
      ];
  
  // ========== LIGHT THEME ==========
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        primary: _lightPrimaryColor,
        onPrimary: _lightTextOnPrimary,
        primaryContainer: lightCyan,
        onPrimaryContainer: darkNavy,
        secondary: _lightSecondaryColor,
        onSecondary: _lightTextOnPrimary,
        secondaryContainer: Color(0xFFE0F2F1),
        onSecondaryContainer: darkNavy,
        tertiary: _lightTertiaryColor,
        onTertiary: darkNavy,
        tertiaryContainer: Color(0xFFE8FFFE),
        onTertiaryContainer: darkNavy,
        error: _lightError,
        onError: _lightTextOnPrimary,
        errorContainer: Color(0xFFFFEBEE),
        onErrorContainer: Color(0xFF991B1B),
        background: _lightNeutralBg,
        onBackground: _lightTextPrimary,
        surface: _lightNeutralCard,
        onSurface: _lightTextPrimary,
        surfaceVariant: _lightNeutralSurface,
        onSurfaceVariant: _lightTextSecondary,
        outline: _lightNeutralBorder,
        outlineVariant: _lightNeutralDisabled,
        shadow: darkNavy,
        scrim: pureBlack,
        inverseSurface: darkNavy,
        onInverseSurface: _lightNeutralCard,
        inversePrimary: lightCyan,
        brightness: Brightness.light,
      ),
      
      // Typography
      textTheme: const TextTheme(
        displayLarge: _displayLargeBase,
        displayMedium: _displayMediumBase,
        displaySmall: _displaySmallBase,
        headlineLarge: _headlineLargeBase,
        headlineMedium: _headlineMediumBase,
        headlineSmall: _headlineSmallBase,
        titleLarge: _titleLargeBase,
        titleMedium: _titleMediumBase,
        titleSmall: _titleSmallBase,
        bodyLarge: _bodyLargeBase,
        bodyMedium: _bodyMediumBase,
        bodySmall: _bodySmallBase,
        labelLarge: _labelLargeBase,
        labelMedium: _labelMediumBase,
        labelSmall: _labelSmallBase,
      ).apply(
        bodyColor: _lightTextPrimary,
        displayColor: _lightTextPrimary,
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          side: const BorderSide(color: _lightNeutralBorder, width: 1),
        ),
        color: _lightNeutralCard,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.all(AppConstants.spaceMD),
        clipBehavior: Clip.antiAlias,
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _lightPrimaryColor,
          foregroundColor: _lightTextOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLG,
            vertical: AppConstants.spaceMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _lightPrimaryColor,
          side: const BorderSide(color: _lightPrimaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLG,
            vertical: AppConstants.spaceMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _lightPrimaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceMD,
            vertical: AppConstants.spaceSM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(0, 40),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightNeutralSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMD,
          vertical: AppConstants.spaceMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(color: _lightPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(color: _lightError, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(color: _lightError, width: 2),
        ),
        hintStyle: const TextStyle(
          color: _lightTextTertiary,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: _lightTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        helperStyle: const TextStyle(
          color: _lightTextTertiary,
          fontSize: 12,
        ),
        errorStyle: const TextStyle(
          color: _lightError,
          fontSize: 12,
        ),
        prefixIconColor: _lightTextSecondary,
        suffixIconColor: _lightTextSecondary,
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _lightNeutralCard,
        foregroundColor: _lightTextPrimary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _lightTextPrimary,
        ),
        iconTheme: IconThemeData(
          color: _lightTextPrimary,
          size: 24,
        ),
        centerTitle: false,
        scrolledUnderElevation: 4,
        surfaceTintColor: Colors.transparent,
      ),
      
      // Additional properties
      splashColor: _lightPrimaryColor.withOpacity(0.1),
      highlightColor: _lightPrimaryColor.withOpacity(0.05),
      scaffoldBackgroundColor: _lightNeutralBg,
      dividerColor: _lightNeutralBorder,
      disabledColor: _lightNeutralDisabled,
      hintColor: _lightTextTertiary,
      iconTheme: const IconThemeData(
        color: _lightTextSecondary,
        size: 24,
      ),
      primaryIconTheme: const IconThemeData(
        color: _lightTextOnPrimary,
        size: 24,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
  
  // ========== DARK THEME ==========
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        primary: _darkPrimaryColor,
        onPrimary: _darkTextOnPrimary,
        primaryContainer: mediumTeal,
        onPrimaryContainer: lightCyan,
        secondary: _darkSecondaryColor,
        onSecondary: _darkTextOnPrimary,
        secondaryContainer: mediumTealDark,
        onSecondaryContainer: lightCyan,
        tertiary: _darkTertiaryColor,
        onTertiary: pureWhite,
        tertiaryContainer: Color(0xFF0F3A47),
        onTertiaryContainer: lightCyan,
        error: _darkError,
        onError: pureWhite,
        errorContainer: Color(0xFF7F1D1D),
        onErrorContainer: Color(0xFFFFEBEE),
        background: _darkNeutralBg,
        onBackground: _darkTextPrimary,
        surface: _darkNeutralCard,
        onSurface: _darkTextPrimary,
        surfaceVariant: _darkNeutralSurface,
        onSurfaceVariant: _darkTextSecondary,
        outline: _darkNeutralBorder,
        outlineVariant: _darkNeutralDisabled,
        shadow: pureBlack,
        scrim: pureBlack,
        inverseSurface: _darkTextPrimary,
        onInverseSurface: _darkNeutralCard,
        inversePrimary: mediumTeal,
        brightness: Brightness.dark,
      ),
      
      // Typography (same as light theme but with dark colors)
      textTheme: const TextTheme(
        displayLarge: _displayLargeBase,
        displayMedium: _displayMediumBase,
        displaySmall: _displaySmallBase,
        headlineLarge: _headlineLargeBase,
        headlineMedium: _headlineMediumBase,
        headlineSmall: _headlineSmallBase,
        titleLarge: _titleLargeBase,
        titleMedium: _titleMediumBase,
        titleSmall: _titleSmallBase,
        bodyLarge: _bodyLargeBase,
        bodyMedium: _bodyMediumBase,
        bodySmall: _bodySmallBase,
        labelLarge: _labelLargeBase,
        labelMedium: _labelMediumBase,
        labelSmall: _labelSmallBase,
      ).apply(
        bodyColor: _darkTextPrimary,
        displayColor: _darkTextPrimary,
      ),
      
      // Component themes (similar to light theme but with dark colors)
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusLG),
          side: const BorderSide(color: _darkNeutralBorder, width: 1),
        ),
        color: _darkNeutralCard,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.all(AppConstants.spaceMD),
        clipBehavior: Clip.antiAlias,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkPrimaryColor,
          foregroundColor: _darkTextOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLG,
            vertical: AppConstants.spaceMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _darkPrimaryColor,
          side: const BorderSide(color: _darkPrimaryColor, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceLG,
            vertical: AppConstants.spaceMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _darkPrimaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spaceMD,
            vertical: AppConstants.spaceSM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(0, 40),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkNeutralSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMD,
          vertical: AppConstants.spaceMD,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(color: _darkPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(color: _darkError, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          borderSide: const BorderSide(color: _darkError, width: 2),
        ),
        hintStyle: const TextStyle(
          color: _darkTextTertiary,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(
          color: _darkTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        helperStyle: const TextStyle(
          color: _darkTextTertiary,
          fontSize: 12,
        ),
        errorStyle: const TextStyle(
          color: _darkError,
          fontSize: 12,
        ),
        prefixIconColor: _darkTextSecondary,
        suffixIconColor: _darkTextSecondary,
      ),
      
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: _darkNeutralCard,
        foregroundColor: _darkTextPrimary,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: _darkTextPrimary,
        ),
        iconTheme: IconThemeData(
          color: _darkTextPrimary,
          size: 24,
        ),
        centerTitle: false,
        scrolledUnderElevation: 4,
        surfaceTintColor: Colors.transparent,
      ),
      
      // Additional properties
      splashColor: _darkPrimaryColor.withOpacity(0.1),
      highlightColor: _darkPrimaryColor.withOpacity(0.05),
      scaffoldBackgroundColor: _darkNeutralBg,
      dividerColor: _darkNeutralBorder,
      disabledColor: _darkNeutralDisabled,
      hintColor: _darkTextTertiary,
      iconTheme: const IconThemeData(
        color: _darkTextSecondary,
        size: 24,
      ),
      primaryIconTheme: const IconThemeData(
        color: _darkTextOnPrimary,
        size: 24,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
  
  // ========== SYSTEM UI OVERLAY STYLES ==========
  static SystemUiOverlayStyle get lightSystemOverlayStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: _lightNeutralCard,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  
  static SystemUiOverlayStyle get darkSystemOverlayStyle => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: _darkNeutralCard,
    systemNavigationBarIconBrightness: Brightness.light,
  );
  
  static SystemUiOverlayStyle getSystemOverlayStyle(Brightness brightness) =>
      brightness == Brightness.dark ? darkSystemOverlayStyle : lightSystemOverlayStyle;
  
  // ========== UTILITY METHODS ==========
  
  /// Get card decoration with theme awareness
  static BoxDecoration getCardDecoration({
    required Brightness brightness,
    bool hasShadow = true,
    bool hasBorder = true,
    double radius = AppConstants.radiusLG,
  }) {
    final cardColor = brightness == Brightness.dark ? _darkNeutralCard : _lightNeutralCard;
    final borderColor = brightness == Brightness.dark ? _darkNeutralBorder : _lightNeutralBorder;
    final shadows = brightness == Brightness.dark 
        ? (hasShadow ? shadowMediumDark : null)
        : (hasShadow ? shadowMedium : null);
    
    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(radius),
      border: hasBorder ? Border.all(color: borderColor, width: 1) : null,
      boxShadow: shadows,
    );
  }
  
  /// Get status color with theme awareness
  static Color getStatusColor({
    required String status,
    required Brightness brightness,
  }) {
    final isLight = brightness == Brightness.light;
    switch (status.toLowerCase()) {
      case 'success':
      case 'complete':
      case 'completed':
      case 'active':
        return isLight ? _lightSuccess : _darkSuccess;
      case 'warning':
      case 'pending':
      case 'in progress':
        return isLight ? _lightWarning : _darkWarning;
      case 'error':
      case 'failed':
        return isLight ? _lightError : _darkError;
      case 'info':
      case 'draft':
        return isLight ? _lightInfo : _darkInfo;
      default:
        return isLight ? _lightTextSecondary : _darkTextSecondary;
    }
  }
  
  /// Get gradient for hero sections
  static LinearGradient getHeroGradient(Brightness brightness) {
    if (brightness == Brightness.dark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          darkNavy,
          darkNavyLight,
          Color(0xFF334155),
        ],
      );
    }
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        pureWhite,
        lightCyan,
        Color(0xFFE8FFFE),
      ],
    );
  }
}

// ========== THEME EXTENSION ==========
extension ThemeExtension on ThemeData {
  // Quick access to custom colors
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get tertiaryColor => colorScheme.tertiary;
  
  Color get backgroundColor => colorScheme.background;
  Color get surfaceColor => colorScheme.surface;
  Color get surfaceVariantColor => colorScheme.surfaceVariant;
  
  Color get textPrimaryColor => colorScheme.onSurface;
  Color get textSecondaryColor => colorScheme.onSurfaceVariant;
  Color get textTertiaryColor => 
      brightness == Brightness.light ? AppTheme._lightTextTertiary : AppTheme._darkTextTertiary;
  
  Color get errorColor => colorScheme.error;
  Color get successColor => 
      brightness == Brightness.light ? AppTheme._lightSuccess : AppTheme._darkSuccess;
  Color get warningColor =>
      brightness == Brightness.light ? AppTheme._lightWarning : AppTheme._darkWarning;
  Color get infoColor =>
      brightness == Brightness.light ? AppTheme._lightInfo : AppTheme._darkInfo;
  
  Color get borderColor => colorScheme.outline;
  Color get disabledColor => colorScheme.outlineVariant;
  
  bool get isDarkMode => brightness == Brightness.dark;
  SystemUiOverlayStyle get systemOverlayStyle => 
      AppTheme.getSystemOverlayStyle(brightness);
      
  Color getStatusColor(String status) => 
      AppTheme.getStatusColor(status: status, brightness: brightness);
      
  BoxDecoration getCardDecoration({
    bool hasShadow = true,
    bool hasBorder = true,
    double radius = AppConstants.radiusLG,
  }) => AppTheme.getCardDecoration(
    brightness: brightness,
    hasShadow: hasShadow,
    hasBorder: hasBorder,
    radius: radius,
  );
  
  LinearGradient get heroGradient => AppTheme.getHeroGradient(brightness);
}