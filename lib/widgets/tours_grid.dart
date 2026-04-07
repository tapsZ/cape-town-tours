import 'package:flutter/material.dart';
import '../data/tour_data.dart';
import 'tour_card.dart';

class ToursGrid extends StatelessWidget {
  const ToursGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'OUR TOURS',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Explore the best of Cape Town with our expert guides.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              if (constraints.maxWidth > 700) crossAxisCount = 2;
              if (constraints.maxWidth > 1100) crossAxisCount = 3;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio: 0.8,
                ),
                itemCount: TourData.tours.length,
                itemBuilder: (context, index) {
                  return TourCard(tour: TourData.tours[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
