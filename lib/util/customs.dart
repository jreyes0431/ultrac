part of util;

class CustomColors {
  static const Color primary100 = Color(0xFFFF5722);
  static const Color primary200 = Color(0xFFfff3b0);
  static const Color primary300 = Color(0xFFFf8a50);

  static const Color accent100 = Color(0xFF4CAF50);
  static const Color accentDeep100 = Color(0xFF005100);

  static const Color text100 = Color(0xFF333333);

  static const Color ligth = Color(0xFFFDE0DB);
  static const Color dark = Color(0xFF3D3635);
}

class CustomTextStyles {
  static final _base = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: CustomColors.text100,
  );

  static final disclaimerXs = _base.copyWith(
    fontWeight: FontWeight.w200,
    fontSize: 10,
  );

  static final medium = _base.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static final large = _base.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}

class CustomTitleStyles {
  static final _base = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: CustomColors.text100,
  );

  static final large = _base.copyWith(
    color: CustomColors.accentDeep100,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );
}
