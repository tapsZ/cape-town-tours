import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_constants.dart';
import '../logic/cape_tours_cubit.dart';
import '../logic/cape_tours_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/tour.dart';
import '../models/booking_request.dart';
import '../config/app_theme.dart';
import '../core/widgets/nav_bar.dart';
import '../core/widgets/footer.dart';
import '../widgets/tour_card.dart';
import '../widgets/whatsapp_button.dart';

class TourDetailPage extends StatelessWidget {
  final String slug;
  const TourDetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CapeToursCubit, CapeToursState>(
      builder: (context, state) {
        if (state is CapeToursLoading) {
          return const Scaffold(
            appBar: NavBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        List<Tour> tours = [];
        if (state is CapeToursLoaded) {
          tours = state.tours;
        }

        final matchingTours = tours.where((t) => t.slug == slug).toList();

        if (matchingTours.isEmpty) {
          return const Scaffold(
            appBar: NavBar(),
            body: Center(child: Text('Tour not found')),
          );
        }

        final tour = matchingTours.first;

        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 900;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const NavBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TourHero(tour: tour),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 60,
                        horizontal: isMobile ? 20 : 60,
                      ),
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _MainContent(tour: tour, isMobile: isMobile),
                              const SizedBox(height: 80),
                              _GallerySection(tour: tour),
                              const SizedBox(height: 80),
                              _TestimonialsSection(tourSlug: tour.slug),
                              const SizedBox(height: 80),
                              _RelatedToursSection(
                                currentTourSlug: tour.slug,
                                allTours: tours,
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

class _TourHero extends StatelessWidget {
  final Tour tour;
  const _TourHero({required this.tour});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Hero(
          tag: 'tour-${tour.id}',
          child: tour.imagePath.startsWith('http')
              ? Image.network(
                  tour.imagePath,
                  width: double.infinity,
                  height: size.height * 0.7,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  tour.imagePath,
                  width: double.infinity,
                  height: size.height * 0.7,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          width: double.infinity,
          height: size.height * 0.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.7),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.accentOrange,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    tour.category.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ).animate().fadeIn().scale(),
                const SizedBox(height: 20),
                Text(
                  tour.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: size.width < 600 ? 36 : 64,
                        fontWeight: FontWeight.w900,
                      ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '${tour.rating} (${tour.reviewCount} Reviews)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  final Tour tour;
  final bool isMobile;
  const _MainContent({required this.tour, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Overview(tour: tour),
          const SizedBox(height: 40),
          _BookingCard(tour: tour),
          const SizedBox(height: 40),
          _HighlightsIncluded(tour: tour),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Overview(tour: tour),
              const SizedBox(height: 60),
              _HighlightsIncluded(tour: tour),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _StickySidebar(tour: tour),
        ),
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  final Tour tour;
  const _Overview({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Overview'),
        const SizedBox(height: 20),
        Text(
          tour.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: Colors.grey[700],
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: _DetailRow(
                icon: Icons.location_on_outlined,
                label: 'Meeting Point:\n${tour.meetingPoint.isEmpty ? "V&A Waterfront" : tour.meetingPoint}',
              ),
            ),
            Expanded(
              child: _DetailRow(
                icon: Icons.group_outlined,
                label: 'Max Capacity:\n${tour.maxCapacity} persons',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HighlightsIncluded extends StatelessWidget {
  final Tour tour;
  const _HighlightsIncluded({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Highlights'),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: tour.highlights.map((h) => _Tag(label: h)).toList(),
        ),
        const SizedBox(height: 60),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobileLayout = constraints.maxWidth < 700;
            if (isMobileLayout) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconList(
                    title: 'What\'s Included',
                    items: tour.included,
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                  ),
                  const SizedBox(height: 40),
                  _IconList(
                    title: 'What to Bring',
                    items: tour.whatToBring,
                    icon: Icons.info_outline,
                    iconColor: AppTheme.accentOrange,
                  ),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _IconList(
                    title: 'What\'s Included',
                    items: tour.included,
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: _IconList(
                    title: 'What to Bring',
                    items: tour.whatToBring,
                    icon: Icons.info_outline,
                    iconColor: AppTheme.accentOrange,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _StickySidebar extends StatelessWidget {
  final Tour tour;
  const _StickySidebar({required this.tour});

  @override
  Widget build(BuildContext context) {
    return _BookingCard(tour: tour);
  }
}

class _BookingCard extends StatelessWidget {
  final Tour tour;
  const _BookingCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return _BookingForm(tour: tour);
  }
}

class _BookingForm extends StatefulWidget {
  final Tour tour;
  const _BookingForm({required this.tour});

  @override
  State<_BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<_BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _guestsController = TextEditingController(text: '1');
  final _notesController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _guestsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submitBooking() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final request = BookingRequest(
      tourId: widget.tour.id,
      customerName: _nameController.text,
      customerEmail: _emailController.text,
      customerPhone: _phoneController.text,
      bookingDate: _selectedDate!,
      numberOfGuests: int.tryParse(_guestsController.text) ?? 1,
      notes: _notesController.text,
    );

    final success = await context.read<CapeToursCubit>().createBooking(request);

    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking failed. Please try again.')),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Requested!'),
        content: const Text(
            'We have received your booking request. Our team will contact you shortly to confirm your booking and arrange payment.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _formKey.currentState?.reset();
              setState(() {
                _selectedDate = null;
                _nameController.clear();
                _emailController.clear();
                _phoneController.clear();
                _guestsController.text = '1';
                _notesController.clear();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BOOK THIS TOUR',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppTheme.primaryBlue,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'From R${widget.tour.priceFrom.toInt()}',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textLight,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email_outlined,
              validator: (v) => v!.contains('@') ? null : 'Invalid email',
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 18, color: Colors.grey[600]),
                          const SizedBox(width: 10),
                          Text(
                            _selectedDate == null
                                ? 'Date'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            style: TextStyle(
                              color: _selectedDate == null
                                  ? Colors.grey[600]
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(
                    controller: _guestsController,
                    label: 'Guests',
                    icon: Icons.people_outline,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _notesController,
              label: 'Notes (optional)',
              icon: Icons.notes,
              maxLines: 2,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitBooking,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'BOOK NOW',
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () => launchUrl(Uri.parse(
                    'https://wa.me/27123456789?text=Hello! I would like to book the ${widget.tour.title} tour.')),
                child: const Text('OR BOOK VIA WHATSAPP'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue, size: 24),
        const SizedBox(width: 15),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
      ],
    );
  }
}

class _GallerySection extends StatelessWidget {
  final Tour tour;
  const _GallerySection({required this.tour});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Photo Gallery'),
        const SizedBox(height: 30),
        CarouselSlider(
          options: CarouselOptions(
            height: isMobile ? 300 : 500,
            viewportFraction: isMobile ? 1.0 : 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: tour.galleryImages.map((img) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: img.startsWith('http')
                  ? Image.network(
                      img,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      img,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  final String tourSlug;
  const _TestimonialsSection({required this.tourSlug});

  @override
  Widget build(BuildContext context) {
    final testimonials =
        AppConstants.testimonials.where((t) => t.tourSlug == tourSlug).toList();

    if (testimonials.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'Guest Reviews'),
        const SizedBox(height: 30),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: testimonials.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final t = testimonials[index];
            return Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                        5, (i) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '"${t.text}"',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '— ${t.name}, ${t.country}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RelatedToursSection extends StatelessWidget {
  final String currentTourSlug;
  final List<Tour> allTours;
  const _RelatedToursSection({
    required this.currentTourSlug,
    required this.allTours,
  });

  @override
  Widget build(BuildContext context) {
    final relatedTours = allTours
        .where((t) => t.slug != currentTourSlug)
        .take(3)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: 'You Might Also Like'),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 800;
            if (isMobile) {
              return Column(
                children: relatedTours
                    .map((t) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TourCard(tour: t),
                        ))
                    .toList(),
              );
            }
            return Row(
              children: relatedTours
                  .map((t) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TourCard(tour: t),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: AppTheme.textDark,
        letterSpacing: -0.5,
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.1)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primaryBlue,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _IconList extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;
  final Color iconColor;

  const _IconList({
    required this.title,
    required this.items,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 20),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: iconColor, size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.grey[700], height: 1.4),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

