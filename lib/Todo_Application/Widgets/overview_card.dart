import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final texttheme = theme.textTheme;
    final colorschema = theme.colorScheme;
    return Card(
      color: theme.cardColor.withAlpha(100),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Todo Progress",style: texttheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                  ),),
                  Text("Complete your first task",style: texttheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),),
                ],
              ),
            ),
            SizedBox(width: 12,),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10
              ),
              decoration: BoxDecoration(
                color: colorschema.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("0/10",style: texttheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}
