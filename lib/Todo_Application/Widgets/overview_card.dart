import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_flutter/Todo_Application/Widgets/todo_adding.dart';

class OverviewCard extends ConsumerStatefulWidget {
  const OverviewCard({super.key});

  @override
  ConsumerState<OverviewCard> createState() => _OverviewCardState();
}

class _OverviewCardState extends ConsumerState<OverviewCard> {
  @override
  Widget build(BuildContext context) {

    final todos = ref.watch(addprovider).length;

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
              child: Text("$todos/10",style: texttheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}
