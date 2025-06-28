import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomVerticalStepper extends StatelessWidget {
  final List<String> titles;
  final RxInt currentStep;
  final double lineWidth;

  const CustomVerticalStepper({
    super.key,
    required this.titles,
    required this.currentStep,
    this.lineWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(titles.length, (i) {
          final isCurrent = i == currentStep.value;
          final isDone = i < currentStep.value;

          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isDone || isCurrent
                          ? theme.colorScheme.primary
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${i + 1}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight:
                        isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    titles[i],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight:
                      isCurrent ? FontWeight.bold : FontWeight.normal,
                      color: isCurrent
                          ? theme.colorScheme.primary
                          : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),

              if (i < titles.length - 1)
                Container(
                  width: lineWidth,
                  height: isDone
                      ? 48
                      : (isCurrent ? 72 : 24), // current step gets longer
                  color: isDone || isCurrent
                      ? theme.colorScheme.primary
                      : Colors.grey.shade300,
                ),
            ],
          );
        }),
      );
    });
  }
}
