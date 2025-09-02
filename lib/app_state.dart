import 'package:flutter/material.dart';

enum Role { worker, homeowner }

String roleLabel(Role r) => r == Role.worker ? 'Worker' : 'Homeowner';

class Person {
  String firstName;
  String lastName;
  String username;
  String email;
  String phone;
  Role role;
  bool approved;

  Person({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.role,
    this.approved = false,
  });

  String get fullName => '$firstName $lastName';
}

class ReportItem {
  final String title;
  final String details;
  final DateTime createdAt;

  ReportItem(this.title, this.details, this.createdAt);
}

class AdminProfile {
  String firstName = 'Loren';
  String lastName = 'Ipsum';
  String username = 'admin';
  String email = 'admin@fixit.com';
  String address = 'LoremIpsum city';
  String phone = '09123456789';
}

class AppState extends ChangeNotifier {
  final AdminProfile admin = AdminProfile();

  bool isLoggedIn = false;

  // Mock seed data
  final List<Person> _workers = [
    Person(
      firstName: 'Loren',
      lastName: 'Syson',
      username: 'lsyson',
      email: 'ls@ex.com',
      phone: '0912000111',
      role: Role.worker,
      approved: true,
    ),
    Person(
      firstName: 'Maria',
      lastName: 'Klein',
      username: 'mklein',
      email: 'mk@ex.com',
      phone: '0912000222',
      role: Role.worker,
      approved: true,
    ),
  ];

  final List<Person> _homeowners = [
    Person(
      firstName: 'James',
      lastName: 'Young',
      username: 'jyoung',
      email: 'jy@ex.com',
      phone: '0912333444',
      role: Role.homeowner,
      approved: true,
    ),
    Person(
      firstName: 'Ava',
      lastName: 'Lopez',
      username: 'alopez',
      email: 'al@ex.com',
      phone: '0912555666',
      role: Role.homeowner,
      approved: true,
    ),
  ];

  final List<Person> _pending = [
    Person(
      firstName: 'Lauren',
      lastName: 'Byrne',
      username: 'lbyrne',
      email: 'lb@ex.com',
      phone: '0912777888',
      role: Role.worker,
      approved: false,
    ),
    Person(
      firstName: 'Ethan',
      lastName: 'Park',
      username: 'epark',
      email: 'ep@ex.com',
      phone: '0912999000',
      role: Role.homeowner,
      approved: false,
    ),
  ];

  final List<ReportItem> _reports = [
    // Example:
    // ReportItem('Leaky faucet', 'Reported by Homeowner: James Young', DateTime.now().subtract(const Duration(hours: 5))),
  ];

  List<Person> get workers => List.unmodifiable(_workers);
  List<Person> get homeowners => List.unmodifiable(_homeowners);
  List<Person> get pending => List.unmodifiable(_pending);
  List<ReportItem> get reports => List.unmodifiable(_reports);

  int get totalWorkers => _workers.length;
  int get totalHomeowners => _homeowners.length;

  bool login(String email, String password) {
    // super simple: fixed admin/pass
    if (email.trim() == 'admin@fixit.com' && password == 'admin123') {
      isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }

  void addSignup(Person p) {
    _pending.add(p);
    notifyListeners();
  }

  void approve(Person p) {
    p.approved = true;
    _pending.remove(p);
    if (p.role == Role.worker) {
      _workers.add(p);
    } else {
      _homeowners.add(p);
    }
    notifyListeners();
  }

  void reject(Person p) {
    _pending.remove(p);
    notifyListeners();
  }

  void deleteWorker(Person p) {
    _workers.remove(p);
    notifyListeners();
  }

  void deleteHomeowner(Person p) {
    _homeowners.remove(p);
    notifyListeners();
  }

  void updateAdmin({
    required String first,
    required String last,
    required String user,
    required String addr,
    required String mail,
    required String phone,
  }) {
    admin.firstName = first;
    admin.lastName = last;
    admin.username = user;
    admin.address = addr;
    admin.email = mail;
    admin.phone = phone;
    notifyListeners();
  }
}

final appState = AppState();
