part of widgets;

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.controller,
    this.hintText = '',
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: CustomTextStyles.medium.copyWith(
        color: CustomColors.primary200,
        fontWeight: FontWeight.w400,
      ),
      controller: controller,
      maxLines: maxLines,
      cursorColor: CustomColors.primary200,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: CustomColors.primary200,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: CustomColors.primary200,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: CustomColors.text100,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusColor: CustomColors.primary200,
        fillColor: CustomColors.primary200,
      ),
    );
  }
}
