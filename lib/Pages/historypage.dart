import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soiscan/Bloc/History/history_bloc.dart';
import 'package:soiscan/Widgets/history_card_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(LoadHistory());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("History"),
      ),
      body: SafeArea(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: ListView.builder(
                  itemCount: state.interactions.length,
                  itemBuilder: (context, index) {
                    return HistoryCard(interaction: state.interactions[index]);
                  },
                ),
              );
            } else if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryError) {
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/underconstruction.jpg"),
                    const Text("This Feature is unavailable.")
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/underconstruction.jpg"),
                    const Text("Opps Something Went Wrong!.")
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
