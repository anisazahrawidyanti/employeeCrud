import 'package:flutter/material.dart';
import './pages/employee.dart';
import 'package:provider/provider.dart';
import 'package:employee_crud/providers/employee_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        )
      ],
      child: MaterialApp(
        home: Employee(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}