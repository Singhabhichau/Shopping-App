import 'package:flutter/material.dart';
import '../services/category_service.dart';
import '../models/category_model.dart';

class CategoryList extends StatelessWidget {
  final void Function(String categoryId)? onTap;

  const CategoryList({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: CategoryService.getCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text("Error loading categories");
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final categories = snapshot.data!;

        return SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return GestureDetector(
                onTap: () => onTap?.call(cat.id),
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          cat.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cat.name,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
