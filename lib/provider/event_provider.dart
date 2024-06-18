import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/event.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  EventProvider() {
    loadEvents();
  }

  void addEvent(Event event) {
    _events.add(event);
    saveEvents();
    notifyListeners();
  }

  void removeEvent(Event event) {
    _events.remove(event);
    saveEvents();
    notifyListeners();
  }

  void editEvent(Event oldEvent, Event newEvent) {
    final eventIndex = _events.indexWhere((event) => event == oldEvent);
    if (eventIndex >= 0) {
      print('Updating event at index: $eventIndex');
      _events[eventIndex] = newEvent;
      saveEvents();
      notifyListeners();
    } else {
      print('Event not found');
    }
  }

  Future<void> loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('events') ?? '[]';
    final List<dynamic> jsonData = json.decode(data);
    _events = jsonData
        .map((json) =>
            Event(title: json['title'], date: DateTime.parse(json['date'])))
        .toList();
    notifyListeners();
  }

  Future<void> saveEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(_events
        .map((event) =>
            {'title': event.title, 'date': event.date.toIso8601String()})
        .toList());
    prefs.setString('events', data);
  }
}
