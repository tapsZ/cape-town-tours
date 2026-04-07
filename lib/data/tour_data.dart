import '../models/tour.dart';
import '../models/guide.dart';

class TourData {
  static const List<Tour> tours = [
    Tour(
      id: '1',
      slug: 'cape-town-city',
      title: 'Cape Town City',
      imagePath: 'images/portfolio/Cape-Town-City.jpg',
      description: 'Visit the Castle Of Good Hope, City Hall, Grand Parade, District Six Museum, and the Malay Quarter. Ascend to the top and marvel at the view to Kloof Nek and Table Mountain and see the Robben Island where Nelson Mandela was imprisoned.',
      highlights: [
        'Table Mountain',
        'Camps Bay',
        'Bo Kaap',
        'Robben Island',
        'Castle Of Good Hope',
        'District Six Museum',
      ],
    ),
    Tour(
      id: '2',
      slug: 'garden-route',
      title: 'Garden Route',
      imagePath: 'assets/images/portfolio/Garden-Route.jpg',
      description: 'Travel along South Africa\'s most iconic Garden Route, offering a mixture of ancient indigenous forests, mountain hideaways, glorious beaches and ecologically diverse vegetation and creatures.',
      highlights: [
        'Garden of Eden',
        'Knysna Heads',
        'Whale Watching',
        'Tsitsikamma Canopy',
        'Indigenous Forests',
        'Ecologically Diverse Creatures',
      ],
    ),
    Tour(
      id: '3',
      slug: 'cape-peninsula',
      title: 'Cape Peninsula',
      imagePath: 'assets/images/portfolio/Cape-Peninsula.jpg',
      description: 'Head for Cape point and some of the most amazing views in the world passing through Sea point and Camps, Hout Bay, Chapman\'s Peak, Cape point Nature Reserve, Simon\'s Town right down to the Kirstenbosch National Botanical Gardens.',
      highlights: [
        'Kalk Bay (Fishing Village)',
        'Groot Constantia',
        'Seals Island',
        'Simons Town',
        'Cape Point',
        'Penguin Colony',
      ],
    ),
    Tour(
      id: '4',
      slug: 'winelands',
      title: 'WineLands',
      imagePath: 'assets/images/portfolio/Stellenbosch-Wine-Farm.jpg',
      description: 'Start with a visit to Paarl winelands, continue to Franschhoek enjoying wine tasting in the vineyards. Head to Stellenbosch the town of oaks enjoying the final wine tasting before returning to Cape Town',
      highlights: [
        'Paarl Winelands',
        'Franschhoek Wine Tasting',
        'Stellenbosch Visit',
        'Vineyard Experience',
        'Historical Architecture',
        'Boutique Wineries',
      ],
    ),
    Tour(
      id: '5',
      slug: 'safari',
      title: 'Cape Point Nature Reserve (Safari)',
      imagePath: 'assets/images/portfolio/Safari.jpg',
      description: 'Travel along the Atlantic coast, passing through the glorious views of the Twelve Apostles right down to Cape Point Nature Reserve comprising of a wide variety of wildlife.',
      highlights: [
        'Atlantic Coast Views',
        'Twelve Apostles',
        'Wildlife Observation',
        'Cape Point Nature Reserve',
        'Pristine Beaches',
        'Endemic Flora',
      ],
    ),
    Tour(
      id: '6',
      slug: 'township',
      title: 'Township',
      imagePath: 'assets/images/portfolio/mzoli.jpg',
      description: 'You will be welcome in the traditional African manner in the townships of Langa and Khayelitsha. Visit the Malay Quarter and Gugulethu Township. Visit a "Shebeen", an informal tavern, meet and interact with local community.',
      highlights: [
        'Langa Township',
        'Khayelitsha Township',
        'Gugulethu Township',
        'Shebeen Experience',
        'Local Interaction',
        'Traditional African Greeting',
      ],
    ),
  ];

  static const List<Guide> guides = [
    Guide(id: '1', name: 'Brian Petersen', experience: '23 Years', imagePath: 'assets/images/team/driver14.jpg'),
    Guide(id: '2', name: 'Nancy Hendrics', experience: '25 Years', imagePath: 'assets/images/team/driver1.jpeg'),
    Guide(id: '3', name: 'Abe Persents', experience: '32 Years', imagePath: 'assets/images/team/driver2.jpg'),
    Guide(id: '4', name: 'Diana Petersen', experience: '33 Years', imagePath: 'assets/images/team/driver3.jpg'),
    Guide(id: '5', name: 'Nigel Burricks', experience: '30 Years', imagePath: 'assets/images/team/driver4.jpg'),
    Guide(id: '6', name: 'Siraj Fredericks', experience: '45 Years', imagePath: 'assets/images/team/driver5.jpg'),
    Guide(id: '7', name: 'Reidwaan Hassen', experience: '35 Years', imagePath: 'assets/images/team/driver6.jpeg'),
    Guide(id: '8', name: 'Ebrahim Btzimana', experience: '26 Years', imagePath: 'assets/images/team/driver7.jpg'),
    Guide(id: '9', name: 'Oleg Dimitrov', experience: '34 Years', imagePath: 'assets/images/team/driver8.jpeg'),
    Guide(id: '10', name: 'Fernando Figuiera', experience: '37 Years', imagePath: 'assets/images/team/driver9.jpg'),
    Guide(id: '11', name: 'Ivan Paulse', experience: '42 Years', imagePath: 'assets/images/team/driver10.jpg'),
    Guide(id: '12', name: 'Gregory Frazer', experience: '22 Years', imagePath: 'assets/images/team/driver11.jpg'),
    Guide(id: '13', name: 'Nadeem Antway', experience: '28 Years', imagePath: 'assets/images/team/driver12.jpg'),
    Guide(id: '14', name: 'Nizaam Parker', experience: '35 Years', imagePath: 'assets/images/team/driver13.jpg'),
  ];

  static const List<String> heroImages = [
    'assets/images/Slide/district-six-museum.jpg',
    'assets/images/Slide/CapetownCity.jpg',
    'assets/images/Slide/GardenRoute.jpg',
    'assets/images/Slide/Bo-Kaap.jpg',
    'assets/images/Slide/Cape-of-good-hope.jpg',
    'assets/images/Slide/Groot-Constantia-Garden.jpg',
    'assets/images/Slide/PenguinColony.jpg',
    'assets/images/Slide/Hermanus_Walker_Bay_springbok.jpg',
  ];
}
