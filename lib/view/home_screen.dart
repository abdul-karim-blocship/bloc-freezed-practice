import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/cubits/user_cubit/user_cubit.dart';

import '../cubits/counter_cubit/counter_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<UserCubit, UserState>(
              builder: (context, UserState state) {
                return Text(
                  '${state.userModel.toJson()}',
                );
              },
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserScreen())),
              child: Text('2nd'),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, CounterState state) {
                return Text(
                  '${state.counterValue}',
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'increment_fab', // Unique tag for the decrement FAB
                  onPressed: () => context.read<CounterCubit>().increment(),
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: 'decrement_fab',
                  onPressed: () => context.read<CounterCubit>().decrement(),
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, UserState state) {
              return Text(
                '${state.userModel.toJson()}',
              );
            },
          ),
          TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: "Enter your name",
              suffixIcon: IconButton(
                  onPressed: () =>
                      context.read<UserCubit>().updateName(textController.text),
                  icon: const Icon(Icons.update)),
            ),
          ),
        ],
      ),
    );
  }
}
