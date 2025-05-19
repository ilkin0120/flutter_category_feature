part of './theme.dart';

class ThemeTextStyles extends ThemeExtension<ThemeTextStyles> {
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  ThemeTextStyles({
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

  @override
  ThemeExtension<ThemeTextStyles> copyWith({
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
  }) {
    return ThemeTextStyles(
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
    );
  }

  @override
  ThemeExtension<ThemeTextStyles> lerp(
    ThemeExtension<ThemeTextStyles>? other,
    double t,
  ) {
    if (other is! ThemeTextStyles) {
      return this;
    }

    return ThemeTextStyles(
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
    );
  }

  static get dark => ThemeTextStyles(
        titleLarge: titleL.copyWith(
          color: DarkModeColors.base100,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: titleM.copyWith(
          color: DarkModeColors.base100,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: titleS.copyWith(
            fontWeight: FontWeight.w400, color: DarkModeColors.base100),
        bodyLarge: bodyL.copyWith(
          color: DarkModeColors.base100,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: bodyM.copyWith(
          color: DarkModeColors.base100,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: bodyS.copyWith(
          color: DarkModeColors.base100,
          fontWeight: FontWeight.w400,
        ),
      );

  static get light => ThemeTextStyles(
        titleLarge: titleL.copyWith(
          color: LightModeColors.base0,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: titleM.copyWith(
          color: LightModeColors.base0,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: titleS.copyWith(
            fontWeight: FontWeight.w400, color: LightModeColors.base0),
        bodyLarge: bodyL.copyWith(
          color: LightModeColors.base0,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: bodyM.copyWith(
          color: LightModeColors.base0,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: bodyS.copyWith(
          color: LightModeColors.base0,
          fontWeight: FontWeight.w400,
        ),
      );
}
