import 'package:eshop/blocs/choose_plan/choose_plan_bloc.dart';
import 'package:eshop/utils/utils.dart';
import 'package:flutter/material.dart';

class ChoosePlanPage extends StatefulWidget {
  @override
  _ChoosePlanPageState createState() => _ChoosePlanPageState();
}

class _ChoosePlanPageState extends State<ChoosePlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Choose Plan"),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: BlocBuilder(
                    bloc: ChoosePlanBloc()..add(ChoosePlanInitialEvent()),
                    builder: (context, state) {
                      if (state is ChoosePlanLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is ChoosePlanLoaded) {
                        return Text(
                          state.list[0].toString(),
                        );
                      } else {
                        return const Text("Unable to fetch");
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: BlocBuilder(
                    bloc: ChoosePlanBloc()..add(ChoosePlanInitialEvent()),
                    builder: (context, state) {
                      if (state is ChoosePlanLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is ChoosePlanLoaded) {
                        return Text(
                          state.list[1].toString(),
                        );
                      } else {
                        return const Text("Unable to fetch");
                      }
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: BlocBuilder(
                    bloc: ChoosePlanBloc()..add(ChoosePlanInitialEvent()),
                    builder: (context, state) {
                      if (state is ChoosePlanLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is ChoosePlanLoaded) {
                        return Text(
                          state.list[2].toString(),
                        );
                      } else {
                        return const Text("Unable to fetch");
                      }
                    },
                  ),
                ),
              ],
            ),
            const Text("Or"),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.navigate_next),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
