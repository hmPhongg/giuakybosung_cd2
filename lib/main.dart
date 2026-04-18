import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Online',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6FDC),
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 6,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -0.5),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
      home: const LessonListScreen(),
    );
  }
}

// 📚 Data Model
class Lesson {
  final String id;
  final String title;
  final String level;
  final String duration;
  final String description;
  final String imageUrl;
  final double rating;
  final int enrolled;

  const Lesson({
    required this.id,
    required this.title,
    required this.level,
    required this.duration,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.enrolled,
  });
}

// 🗂️ Mock Data
final List<Lesson> sampleLessons = [
  Lesson(
    id: '1', title: 'Daily Conversations', level: 'Beginner', duration: '45 mins',
    description: 'Learn essential phrases for everyday situations. Practice greetings, ordering food, and asking for directions with native speakers.',
    imageUrl: 'https://images.unsplash.com/photo-1543269865-cbf427effbad?w=400', rating: 4.8, enrolled: 1240,
  ),
  Lesson(
    id: '2', title: 'Business English Mastery', level: 'Intermediate', duration: '60 mins',
    description: 'Professional vocabulary, email writing, meeting phrases, and presentation skills for the modern workplace.',
    imageUrl: 'https://images.unsplash.com/photo-1553484771-371a605b060b?w=400', rating: 4.9, enrolled: 890,
  ),
  Lesson(
    id: '3', title: 'IELTS Writing Task 2', level: 'Advanced', duration: '50 mins',
    description: 'Master essay structure, argument development, and time management for a high IELTS writing score.',
    imageUrl: 'https://images.unsplash.com/photo-1456513080510-7bf7e9e78c59?w=400', rating: 4.7, enrolled: 2100,
  ),
  Lesson(
    id: '4', title: 'Pronunciation & Intonation', level: 'All Levels', duration: '35 mins',
    description: 'Improve your accent with targeted exercises, mouth positioning guides, and real-time audio comparison.',
    imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400', rating: 4.9, enrolled: 1560,
  ),
];

// 📱 Trang Danh Sách Bài Học
class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('English Lessons', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.black54), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/100')),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Continue Learning', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: sampleLessons.length,
              itemBuilder: (context, index) => _LessonCard(lesson: sampleLessons[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// 🃏 Card Hiển Thị Từng Bài Học - ✅ ĐÃ FIX LỖI ẢNH
class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  const _LessonCard({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Card(
          child: Row(
            children: [
              Hero(
                tag: lesson.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                  child: Image.network(
                    lesson.imageUrl,
                    width: 130,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        width: 130,
                        height: 100,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 130,
                        height: 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 40),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFFE8EEFF), borderRadius: BorderRadius.circular(8)),
                            child: Text(lesson.level, style: const TextStyle(fontSize: 11, color: Color(0xFF4A6FDC), fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.schedule, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(lesson.duration, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(lesson.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' ${lesson.rating}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 12),
                          const Icon(Icons.people, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${lesson.enrolled} students', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📖 Trang Chi Tiết Bài Học - ✅ ĐÃ FIX SLIVERAPPBAR
class LessonDetailScreen extends StatelessWidget {
  final Lesson lesson;
  const LessonDetailScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // ✅ Image.network với error handling
                  Image.network(
                    lesson.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (ctx, child, progress) {
                      if (progress == null) return child;
                      return Container(color: Colors.grey[300]);
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[400],
                        child: const Icon(Icons.broken_image, color: Colors.white70, size: 80),
                      );
                    },
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(lesson.title, style: Theme.of(context).textTheme.headlineLarge),
                    const SizedBox(height: 12),
                    Wrap(spacing: 10, runSpacing: 10, children: [
                      _buildChip(lesson.level, Colors.blue[100]!, Colors.blue[800]!),
                      _buildChip('⭐ ${lesson.rating}', Colors.amber[100]!, Colors.amber[800]!),
                      _buildChip('⏱ ${lesson.duration}', Colors.green[100]!, Colors.green[800]!),
                      _buildChip('👥 ${lesson.enrolled}', Colors.purple[100]!, Colors.purple[800]!),
                    ]),
                    const SizedBox(height: 20),
                    Text('Description', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87)),
                    const SizedBox(height: 10),
                    Text(
                      lesson.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A6FDC),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                        ),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('🎬 Đang mở video bài học...'), duration: Duration(seconds: 2)),
                        ),
                        child: const Text(
                          'Start Learning',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: textColor)),
    );
  }
}