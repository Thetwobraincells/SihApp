// lib/views/college_finder/college_finder_screen.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

// College Model
class College {
  final String name;
  final String distance;
  final List<String> courses;
  final String imageAsset;
  final List<String> tags;
  final double rating;
  final String location;
  final String? description;

  College({
    required this.name,
    required this.distance,
    required this.courses,
    required this.imageAsset,
    required this.tags,
    required this.rating,
    required this.location,
    this.description,
  });
}

class CollegeFinderScreen extends StatefulWidget {
  const CollegeFinderScreen({Key? key}) : super(key: key);

  @override
  State<CollegeFinderScreen> createState() => _CollegeFinderScreenState();
}

class _CollegeFinderScreenState extends State<CollegeFinderScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCourseFilter = '';
  String selectedTransportFilter = '';
  String selectedHostelFilter = '';
  
  // Sample college data for Ghawal district
  final List<College> colleges = [
    College(
      name: "Government Degree College Ghawal",
      distance: "1.2 km",
      courses: ["Arts", "Science", "Commerce"],
      imageAsset: "assets/college1.jpg",
      tags: ["Government", "Offline support", "Library", "Sports"],
      rating: 4.2,
      location: "Central Ghawal",
      description: "Established in 1985, Government Degree College Ghawal offers a wide range of undergraduate programs in Arts, Science, and Commerce. The college boasts experienced faculty, modern facilities, and a vibrant campus life with various extracurricular activities.",
    ),
    College(
      name: "Ghawal Polytechnic Institute",
      distance: "2.8 km",
      courses: ["Engineering", "Computer Science", "Electronics", "Mechanical"],
      imageAsset: "assets/college2.jpg",
      tags: ["Government", "Technical", "Labs", "Workshops"],
      rating: 4.0,
      location: "Industrial Area",
      description: "Ghawal Polytechnic Institute is a premier technical education institution offering diploma and certificate courses in various engineering disciplines. The institute has state-of-the-art labs, industry partnerships, and excellent placement records.",
    ),
    College(
      name: "District Education College",
      distance: "3.1 km",
      courses: ["B.Ed", "M.Ed", "B.A. Education", "M.A. Education"],
      imageAsset: "assets/college3.jpg",
      tags: ["Government", "Teaching", "Research", "Workshops"],
      rating: 4.3,
      location: "Education District",
      description: "District Education College is a leading institution for teacher education, offering B.Ed and M.Ed programs. The college focuses on innovative teaching methodologies and practical training to develop skilled educators for the future.",
    ),
    College(
      name: "Government Medical College Ghawal",
      distance: "4.5 km",
      courses: ["MBBS", "B.Sc Nursing", "B.Pharm", "D.Pharm", "Physiotherapy"],
      imageAsset: "assets/college4.jpg",
      tags: ["Government", "Medical", "Hospital", "Research"],
      rating: 4.6,
      location: "Medical Complex",
      description: "Government Medical College Ghawal is a prestigious medical institution offering various healthcare programs. With a 1000-bed teaching hospital, the college provides excellent clinical exposure and research opportunities to its students.",
    ),
    College(
      name: "Agriculture College Ghawal",
      distance: "5.2 km",
      courses: ["B.Sc Agriculture", "B.Sc Horticulture", "M.Sc Agriculture", "Agribusiness"],
      imageAsset: "assets/college5.jpg",
      tags: ["Government", "Agriculture", "Research Farm", "Greenhouse"],
      rating: 4.1,
      location: "Rural Campus",
      description: "Agriculture College Ghawal is a leading agricultural education and research institution. The college features extensive farmlands, modern laboratories, and focuses on sustainable farming practices and agricultural innovation.",
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 12),
                  _buildFilterButtons(),
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              color: AppColors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: _buildMapPlaceholder(),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${colleges.length} colleges found',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _buildCollegeCard(colleges[index]),
              ),
              childCount: colleges.length,
            ),
          ),
        ],
      ),
    );
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.darkBlue),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_outline, color: AppColors.darkBlue),
          onPressed: () {},
        ),
      ],
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Search for colleges...',
          hintStyle: TextStyle(color: AppColors.gray),
          prefixIcon: Icon(Icons.search, color: AppColors.secondaryBlue),
          filled: true,
          fillColor: AppColors.lightBlue,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(color: AppColors.darkBlue),
      ),
    );
  }

  // Filter Buttons
  Widget _buildFilterButtons() {
    return Row(
      children: [
        Expanded(child: _buildFilterButton('Course', selectedCourseFilter.isNotEmpty)),
        const SizedBox(width: 8),
        Expanded(child: _buildFilterButton('Transport', selectedTransportFilter.isNotEmpty)),
        const SizedBox(width: 8),
        Expanded(child: _buildFilterButton('Hostel', selectedHostelFilter.isNotEmpty)),
      ],
    );
  }

  Widget _buildFilterButton(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        // Handle filter selection
        setState(() {
          if (title == 'Course') {
            selectedCourseFilter = isActive ? '' : 'Engineering';
          } else if (title == 'Transport') {
            selectedTransportFilter = isActive ? '' : 'Available';
          } else if (title == 'Hostel') {
            selectedHostelFilter = isActive ? '' : 'Available';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primaryBlue : AppColors.gray.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getFilterIcon(title),
              size: 16,
              color: isActive ? AppColors.white : AppColors.gray,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? AppColors.white : AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFilterIcon(String title) {
    switch (title) {
      case 'Course':
        return Icons.school_outlined;
      case 'Transport':
        return Icons.directions_bus_outlined;
      case 'Hostel':
        return Icons.home_outlined;
      default:
        return Icons.filter_list;
    }
  }

  // Map Placeholder
  Widget _buildMapPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Map background pattern
          Center(
            child: Icon(
              Icons.map_outlined,
              size: 60,
              color: AppColors.primaryBlue.withOpacity(0.3),
            ),
          ),
          
          // College markers
          const Positioned(
            top: 30,
            left: 50,
            child: _MapMarker(label: "GDC"),
          ),
          const Positioned(
            top: 80,
            right: 60,
            child: _MapMarker(label: "GPI"),
          ),
          const Positioned(
            bottom: 40,
            left: 80,
            child: _MapMarker(label: "DEC"),
          ),
          const Positioned(
            bottom: 60,
            right: 40,
            child: _MapMarker(label: "GMC"),
          ),
          
          // Location info
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 14, color: AppColors.orange),
                  SizedBox(width: 4),
                  Text(
                    'Ghawal District',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCollegeDetails(College college) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              college.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: AppColors.gray),
                const SizedBox(width: 4),
                Text(
                  college.location,
                  style: const TextStyle(color: AppColors.gray, fontSize: 14),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        college.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              college.description ?? 'No description available',
              style: const TextStyle(color: AppColors.gray, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Courses Offered',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: college.courses.map((course) => Chip(
                label: Text(course, style: const TextStyle(fontSize: 12)),
                backgroundColor: AppColors.lightBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Facilities',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: college.tags.map((tag) => Chip(
                label: Text(tag, style: const TextStyle(fontSize: 12)),
                backgroundColor: AppColors.lightBlue,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle apply now
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // College Card
  Widget _buildCollegeCard(College college) {
    return GestureDetector(
      onTap: () => _showCollegeDetails(college),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // College Image Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: AppColors.primaryBlue,
                  size: 32,
                ),
              ),
              
              const SizedBox(width: 12),
              
              // College Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // College Name and Distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            college.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkBlue,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            college.distance,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.secondaryBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 6),
                    
                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.gray),
                        const SizedBox(width: 4),
                        Text(
                          college.location,
                          style: const TextStyle(fontSize: 12, color: AppColors.gray),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Courses
                    Text(
                      college.courses.join(', '),
                      style: const TextStyle(fontSize: 14, color: AppColors.darkBlue, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Tags and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 6,
                            children: college.tags.take(2).map((tag) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: tag == 'Government' 
                                    ? AppColors.success.withOpacity(0.1)
                                    : AppColors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: tag == 'Government' 
                                      ? AppColors.success
                                      : AppColors.orange,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            )).toList(),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: AppColors.yellow),
                            const SizedBox(width: 2),
                            Text(
                              college.rating.toString(),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.darkBlue),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Separate Map Marker Widget
class _MapMarker extends StatelessWidget {
  final String label;

  const _MapMarker({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.orange,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}