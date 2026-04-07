import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cape_tours_cubit.dart';
import '../logic/cape_tours_state.dart';
import '../models/tour.dart';
import '../config/app_theme.dart';
import 'tour_card.dart';

class ToursGrid extends StatelessWidget {
  const ToursGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'OUR TOURS',
                  style: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Unforgettable Experiences\nAwaiting You',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Choose from our curated selection of Cape Town\'s most breathtaking tours',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 50),
              BlocBuilder<CapeToursCubit, CapeToursState>(
                builder: (context, state) {
                  if (state is CapeToursLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<Tour> tours = [];
                  if (state is CapeToursLoaded) {
                    tours = state.tours;
                  }

                  if (tours.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (constraints.maxWidth > 700) crossAxisCount = 2;
                      if (constraints.maxWidth > 1000) crossAxisCount = 3;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: tours.length,
                        itemBuilder: (context, index) {
                          return TourCard(tour: tours[index]);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
