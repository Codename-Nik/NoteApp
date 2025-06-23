import 'package:flutter/material.dart';
import '../models/note.dart';
import '../utils/constants.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Function() onDelete;
  final Function() onTap;

  const NoteCard({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                note.title,
                style: AppTextStyles.noteTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${note.date.day}.${note.date.month}.${note.date.year}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16.0),
                  Icon(
                    Icons.access_time,
                    size: 14.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${note.time.hour}:${note.time.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
