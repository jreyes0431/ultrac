part of widgets;

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.bgColor,
    this.title = '',
    this.description = '',
  });

  final Color bgColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 450,
        minHeight: 70,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 25),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.clip,
                    style: CustomTitleStyles.small.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline),
                ),
                const SizedBox(width: 25),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 25,
                top: 10,
              ),
              child: Align(
                alignment: const Alignment(-1, 0),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: CustomTextStyles.small.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
