import 'package:countdown_events_app/screen/edit_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/event.dart';
import '../provider/event_provider.dart';

import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final Event event;

  const EventItem({Key? key, required this.event}) : super(key: key);

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text('Are you sure to delete this event?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<EventProvider>(context, listen: false)
                  .removeEvent(event);
              Navigator.of(ctx).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysRemaining = event.date.difference(DateTime.now()).inDays;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => EditEventScreen(event: event)),
        );
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color:
            Colors.white.withOpacity(0.8), // Soft beige color with transparency
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  '$daysRemaining\nDays',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            event.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(event.date),
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () => _confirmDelete(context),
          ),
        ),
      ),
    );
  }
}
