import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_bloc/domain/bloc/main_bloc.dart';
import 'package:imdb_bloc/domain/event/main_event.dart';
import 'package:imdb_bloc/utils/colors.dart';
import 'package:imdb_bloc/utils/extensions.dart';

class BottomNavbarItem extends StatelessWidget {
  const BottomNavbarItem(
      {super.key,
      required this.isSelected,
      required this.index,
      required this.icon});

  final bool isSelected;
  final int index;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () =>
            BlocProvider.of<MainBloc>(context).add(ChangeTabEvent(index)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: !isSelected ? AppColors.white : AppColors.primary,
                ),
              ),
              10.h,
              Icon(
                icon,
                size: 24,
                color: !isSelected ? AppColors.grey : AppColors.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
