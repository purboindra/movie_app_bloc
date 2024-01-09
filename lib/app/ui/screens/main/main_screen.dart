import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/app/ui/screens/main/home/home_screen.dart';
import 'package:imdb_bloc/app/ui/screens/main/home/home_screen_view_model.dart';
import 'package:imdb_bloc/app/ui/screens/main/main_view_model.dart';
import 'package:imdb_bloc/app/ui/screens/main/widgets/bottom_navbar_item.dart';
import 'package:imdb_bloc/domain/bloc/auth_bloc.dart';
import 'package:imdb_bloc/domain/bloc/home_bloc.dart';
import 'package:imdb_bloc/domain/bloc/main_bloc.dart';
import 'package:imdb_bloc/domain/event/auth_event.dart';
import 'package:imdb_bloc/domain/state/auth_state.dart';
import 'package:imdb_bloc/domain/state/main_state.dart';
import 'package:imdb_bloc/utils/colors.dart';
import 'package:imdb_bloc/utils/typography.dart';

const List<BottomNavigationBarItem> _bottomNavbarItem = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
];

const List<IconData> _icons = [
  CupertinoIcons.home,
  CupertinoIcons.ticket,
  CupertinoIcons.film,
  CupertinoIcons.person,
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.viewModel});

  final MainScreenViewModel viewModel;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    context.read<AuthBloc>().close();
    context.read<HomeBloc>().close();

    super.dispose();
  }

  @override
  void initState() {
    context.read<AuthBloc>().add(GetCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 65,
            padding:
                const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 5),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _icons.length,
                  (index) => BottomNavbarItem(
                      isSelected: index == state.tabIndex,
                      index: index,
                      icon: _icons[index]),
                ),
              ),
            ),
          ),
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (_, state) {
                    if (state is SuccessGetCurrentUserState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: AppTypography.text.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Selamat datang kembali, ",
                                    style: AppTypography.text.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          "${state.user["email"].split("@")[0]}"),
                                ],
                              ),
                            ),
                            Text(
                              "Mau nonton apa hari ini?",
                              style: AppTypography.smallText.copyWith(
                                fontSize: 14,
                                color: AppColors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      HomeScreen(
                        homeScreenViewModel: HomeScreenViewModel(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
