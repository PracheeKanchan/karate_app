import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  List<dynamic> articles=[];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://mocki.io/v1/791123ea-dbeb-4e9f-b7c0-ac2503845103'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          articles = data['articles'] as List;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load articles';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error!),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    error = null;
                  });
                  fetchArticles();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return NewsListScreen(articles: articles);
  }
}

class NewsListScreen extends StatelessWidget {
  final List<dynamic> articles;

  const NewsListScreen({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return NewsCard(article: article);
          },
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailScreen(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Circular Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: article['urlToImage'] != null
                        ? NetworkImage(article['urlToImage'])
                        : const AssetImage('assets/placeholder.png')
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Title and Author
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article['author'] ?? 'Unknown Author',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
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

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail News'),
        elevation: 0,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.network(article['urlToImage'],fit: BoxFit.cover,),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        article['author'] ?? 'Unknown Author',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article['description'] ?? '',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Text(
                      article['content'],
                      style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  
                  const SizedBox(height: 16),
                  Text(
                    'Source: ${article['source']['name'] ?? "Unknown Source"}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
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