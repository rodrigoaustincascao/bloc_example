import 'package:bloc_example/bloc_example/bloc/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExampleBlocPage extends StatelessWidget {
  const ExampleBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Example')),
      body: BlocListener<ExampleBloc, ExampleState>(
        listener: (context, state) {
          if (state is ExampleStateData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'BlocListener => Existem ${state.names.length} nomes',
                ),
              ),
            );
          }
        },
        child: Column(
          children: [
            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }
                return false;
              },
              builder: (context, showLoader) {
                if (showLoader) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            BlocConsumer<ExampleBloc, ExampleState>(
              listener: (context, state) {
                print('BlocConsumer (listener) => ${state.runtimeType}');
              },
              builder: (_, state) {
                if (state is ExampleStateData) {
                  return Text(
                    'BlocConsumer (build) => Total de nomes é ${state.names.length}',
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            BlocBuilder<ExampleBloc, ExampleState>(
              builder: (context, state) {
                print(state.runtimeType);
                if (state is ExampleStateData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.names.length,
                    itemBuilder: (context, index) {
                      final name = state.names[index];
                      return ListTile(
                        onTap: () {
                          context.read<ExampleBloc>().add(
                            ExampleRemoveNameEvent(name: name),
                          );
                        },
                        title: Text(name),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
