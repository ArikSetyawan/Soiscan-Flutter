import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:soiscan/Bloc/History/history_bloc.dart';
import 'package:soiscan/Widgets/history_card_widget.dart';
import 'package:soiscan/theme.dart';

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

  final _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("History"),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            switch (index) {
              case 0:
                context.goNamed('dashboard');
                break;
              case 1:
                context.goNamed('search');
                break;
              case 2:
                context.goNamed('scan');
                break;
              case 3:
                context.goNamed('history');
                break;
              case 4:
                context.goNamed('account');
                break;
            }
          }
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.window),
            title: const Text("Home"),
            selectedColor: darkgreyColor,
          ),
    
          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: darkgreyColor,
          ),
    
          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.add_circle_outline),
            title: const Text("Scan"),
            selectedColor: darkgreyColor,
          ),
    
          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.query_builder),
            title: const Text("History"),
            selectedColor: darkgreyColor,
          ),
    
          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: darkgreyColor,
          ),
        ],
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
