import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cape_tours_cubit.dart';
import '../logic/cape_tours_state.dart';
import '../config/app_theme.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/guide_card.dart';
import '../widgets/whatsapp_button.dart';
import '../models/guide.dart';

class GuidesPage extends StatefulWidget {
  const GuidesPage({super.key});

  @override
  State<GuidesPage> createState() => _GuidesPageState();
}

class _GuidesPageState extends State<GuidesPage> {
  String _searchQuery = '';
  String _selectedSpecialty = 'All';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final isTablet = size.width >= 700 && size.width < 1100;

    return BlocBuilder<CapeToursCubit, CapeToursState>(
      builder: (context, state) {
        if (state is CapeToursLoading) {
          return const Scaffold(
            appBar: NavBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        List<Guide> allGuides = [];
        if (state is CapeToursLoaded) {
          allGuides = state.guides;
        }

        final specialties = [
          'All',
          ...allGuides.map((g) => g.specialty).where((s) => s.isNotEmpty).toSet()
        ];

        final filteredGuides = allGuides.where((guide) {
          final matchesSearch = guide.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              guide.languages.any((l) =>
                  l.toLowerCase().contains(_searchQuery.toLowerCase())) ||
              guide.specialty.toLowerCase().contains(_searchQuery.toLowerCase());

          final matchesSpecialty =
              _selectedSpecialty == 'All' || guide.specialty == _selectedSpecialty;

          return matchesSearch && matchesSpecialty;
        }).toList();

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const NavBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _GuidesHero(isMobile: isMobile),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 60,
                        horizontal: isMobile ? 20 : 60,
                      ),
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Column(
                            children: [
                              _SearchAndFilter(
                                specialties: specialties,
                                selectedSpecialty: _selectedSpecialty,
                                onSearchChanged: (val) =>
                                    setState(() => _searchQuery = val),
                                onSpecialtyChanged: (val) =>
                                    setState(() => _selectedSpecialty = val),
                              ),
                              const SizedBox(height: 60),
                              _GuidesGrid(
                                guides: filteredGuides,
                                crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Footer(),
                  ],
                ),
              ),
              const WhatsAppButton(),
            ],
          ),
        );
      },
    );
  }
}

class _GuidesHero extends StatelessWidget {
  const _GuidesHero({required bool isMobile});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      width: double.infinity,
      height: 450,
      decoration: const BoxDecoration(
        color: AppTheme.primaryBlue,
        image: DecorationImage(
          image: AssetImage('assets/images/portfolio/Bo-Kaap.jpg'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Text(
            'OUR EXPERT GUIDES',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 36 : 64,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              'Meet the passionate locals who bring Cape Town\'s stories to life. Our team of 25+ licensed guides speaks over 10 languages.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w300,
                height: 1.5,
              ),
            ),
          ).animate(delay: 200.ms).fadeIn(),
        ],
      ),
    );
  }
}

class _SearchAndFilter extends StatelessWidget {
  final List<String> specialties;
  final String selectedSpecialty;
  final Function(String) onSearchChanged;
  final Function(String) onSpecialtyChanged;

  const _SearchAndFilter({
    required this.specialties,
    required this.selectedSpecialty,
    required this.onSearchChanged,
    required this.onSpecialtyChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Search guides by name, language or specialty...',
              border: InputBorder.none,
              icon: Icon(Icons.search, color: AppTheme.primaryBlue),
              contentPadding: EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: specialties.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final specialty = specialties[index];
              final isSelected = specialty == selectedSpecialty;
              return FilterChip(
                label: Text(specialty),
                selected: isSelected,
                onSelected: (_) => onSpecialtyChanged(specialty),
                backgroundColor: Colors.white,
                selectedColor: AppTheme.primaryBlue.withValues(alpha: 0.1),
                checkmarkColor: AppTheme.primaryBlue,
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.primaryBlue : AppTheme.textDark,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? AppTheme.primaryBlue : Colors.grey[300]!,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _GuidesGrid extends StatelessWidget {
  final List<Guide> guides;
  final int crossAxisCount;

  const _GuidesGrid({required this.guides, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    if (guides.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            Icon(Icons.person_off_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              'No guides found matching your selection.',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.72,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
      itemCount: guides.length,
      itemBuilder: (context, index) {
        return GuideCard(guide: guides[index]);
      },
    );
  }
}
