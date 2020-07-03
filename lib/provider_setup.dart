import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/services/authentication_service.dart';
import 'core/services/data_service.dart';
import 'core/services/localstorage_service.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: LocalStorageService()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<LocalStorageService, AuthenticationService>(
    update: (BuildContext context, LocalStorageService value,
            AuthenticationService previous) =>
        AuthenticationService(localStorageService: value),
  ),
  ProxyProvider<LocalStorageService, DataService>(
    update: (BuildContext context, LocalStorageService value,
            DataService dataService) =>
        DataService(localStorageService: value),
  ),
];
