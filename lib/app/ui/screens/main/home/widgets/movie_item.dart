import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_bloc/app/navigation/app_router.dart';
import 'package:imdb_bloc/domain/entities/movie_data.dart';
import 'package:imdb_bloc/utils/colors.dart';
import 'package:imdb_bloc/utils/extensions.dart';
import 'package:imdb_bloc/utils/typography.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie, required this.index});

  final MovieData movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/main/${AppRouter.detail}', extra: {
          "id": movie.id,
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.5),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.infinity,
            ),
            4.h,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  2.h,
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.primary,
                      ),
                      2.w,
                      Text(
                        movie.rating.ceil().toString(),
                        style: AppTypography.smallTextSecondary,
                      )
                    ],
                  ),
                  4.h,
                  Text(
                    movie.title,
                    maxLines: 2,
                    style: AppTypography.text.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  5.h,
                  Text(
                    movie.overview,
                    maxLines: 2,
                    style: AppTypography.smallText.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
