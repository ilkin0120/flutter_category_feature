part of './theme.dart';

class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color errorColor;
  final Color disableColor;
  final Color thumbSwitchColor;

  const ThemeColors(
      {required this.primaryTextColor,
      required this.secondaryTextColor,
      required this.primaryColor,
      required this.backgroundColor,
      required this.errorColor,
      required this.thumbSwitchColor,
      required this.disableColor,
      required this.secondaryColor});

  @override
  ThemeExtension<ThemeColors> copyWith(
      {Color? primaryTextColor,
      Color? secondaryTextColor,
      Color? disableColor,
      Color? primaryColor,
      Color? thumbSwitchColor,
      Color? errorColor,
      Color? backgroundColor,
      Color? secondaryColor}) {
    return ThemeColors(
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      thumbSwitchColor: thumbSwitchColor ?? this.thumbSwitchColor,
      errorColor: errorColor ?? this.errorColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      disableColor: disableColor ?? this.disableColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
    ThemeExtension<ThemeColors>? other,
    double t,
  ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(
        primaryTextColor:
            Color.lerp(primaryTextColor, other.primaryTextColor, t)!,
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
        thumbSwitchColor:
            Color.lerp(thumbSwitchColor, other.thumbSwitchColor, t)!,
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
        disableColor: Color.lerp(disableColor, other.disableColor, t)!,
        errorColor: Color.lerp(errorColor, other.errorColor, t)!,
        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
        secondaryTextColor:
            Color.lerp(secondaryTextColor, other.secondaryTextColor, t)!);
  }

  static get dark => const ThemeColors(
      secondaryColor: DarkModeColors.base60,
      backgroundColor: DarkModeColors.base0,
      thumbSwitchColor: DarkModeColors.base80,
      primaryTextColor: DarkModeColors.base100,
      errorColor: DarkModeColors.red100,
      disableColor: DarkModeColors.base40,
      primaryColor: DarkModeColors.green100,
      secondaryTextColor: DarkModeColors.base70);

  static get light => const ThemeColors(
      primaryColor: LightModeColors.green100,
      backgroundColor: LightModeColors.base100,
      thumbSwitchColor: LightModeColors.base100,
      primaryTextColor: LightModeColors.base0,
      secondaryColor: LightModeColors.base70,
      disableColor: LightModeColors.base50,
      errorColor: LightModeColors.red100,
      secondaryTextColor: LightModeColors.base40);
}
