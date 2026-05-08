import 'package:blueprint_mobile_flutter/core/login/bloc/login_bloc.dart';
import 'package:blueprint_mobile_flutter/screens/auth/login/body/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late LoginBloc bloc;

  setUp(() {
    bloc = MockLoginBloc();
  });

  // Helper function to find TextField by key
  // Since TextFields are inside custom widgets with keys, we find them by order:
  // First TextField = email, Second TextField = password
  Finder findTextFieldByKey(WidgetTester tester, Key key) {
    // Verify the keyed widget exists
    final keyedFinder = find.byKey(key);
    expect(keyedFinder, findsOneWidget);

    // Find all TextFields and convert to list
    final allTextFields = find.byType(TextField);
    final textFieldList = allTextFields.evaluate().toList();

    // Determine which TextField index based on key
    if (key == const Key('login_email')) {
      // Email is the first TextField
      if (textFieldList.isNotEmpty) {
        return find.byWidget(textFieldList.first.widget);
      }
    } else if (key == const Key('login_password')) {
      // Password is the second TextField
      if (textFieldList.length >= 2) {
        return find.byWidget(textFieldList[1].widget);
      }
    }

    // Fallback: try descendant finder
    return find.descendant(
      of: keyedFinder,
      matching: find.byType(TextField),
    );
  }

  testWidgets('login button disabled until email & password filled',
      (tester) async {
    when(() => bloc.state).thenReturn(LoginIdleState());
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: bloc,
          child: const LoginBody(),
        ),
      ),
    );

    // Wait for widget to fully build and animations to complete
    // Use timeout to prevent hanging on long animations
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Additional pump to ensure async operations complete
    await tester.pump();
    await tester.pump();

    final btnFinder = find.byKey(const Key('login_button'));

    // Verify button exists
    expect(btnFinder, findsOneWidget);

    // Initially disabled
    final btn1 = tester.widget(btnFinder) as dynamic;
    expect(btn1.onPressed, isNull);

    // Find and enter email
    final emailTextField = findTextFieldByKey(tester, const Key('login_email'));
    expect(emailTextField, findsOneWidget);
    await tester.enterText(emailTextField, 'demo.account@gmail.com');
    await tester.pumpAndSettle();

    final btn2 = tester.widget(btnFinder) as dynamic;
    expect(btn2.onPressed, isNull);

    // Find and enter password
    final passwordTextField =
        findTextFieldByKey(tester, const Key('login_password'));
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(passwordTextField, '01012000');
    await tester.pumpAndSettle();

    final btn3 = tester.widget(btnFinder) as dynamic;
    expect(btn3.onPressed, isNotNull);
  });

  testWidgets('pressing login triggers LoginFetched event', (tester) async {
    when(() => bloc.state).thenReturn(LoginIdleState());
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: bloc,
          child: const LoginBody(),
        ),
      ),
    );

    // Wait for widget to fully build and animations to complete
    // Use timeout to prevent hanging on long animations
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Additional pump to ensure async operations complete
    await tester.pump();
    await tester.pump();

    // Find and enter email
    final emailTextField = findTextFieldByKey(tester, const Key('login_email'));
    expect(emailTextField, findsOneWidget);
    await tester.enterText(emailTextField, 'demo.account@gmail.com');
    await tester.pumpAndSettle();

    // Find and enter password
    final passwordTextField =
        findTextFieldByKey(tester, const Key('login_password'));
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(passwordTextField, '01012000');
    await tester.pumpAndSettle();

    // Tap login button
    final btnFinder = find.byKey(const Key('login_button'));
    expect(btnFinder, findsOneWidget);
    await tester.tap(btnFinder);
    await tester.pumpAndSettle();

    verify(() => bloc.add(any(that: isA<LoginFetched>()))).called(1);
  });
}
