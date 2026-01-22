import 'package:flutter/material.dart';
import 'package:store_project/features/products/widgets/custom_snackbar_alert.dart';

class MainViewPaginator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const MainViewPaginator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton.icon(
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 40.0,
              color: Colors.teal,
            ),
            onPressed: () {
              if (currentPage == 1) {
                showCustomSnackBar(
                  context,
                  message: "No hay mas datos para cargar!",
                );
              } else {
                onPageChanged(currentPage - 1);
              }
            },
            label: const Text(
              "Anterior",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton.icon(
            iconAlignment: IconAlignment.end,
            icon: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 40.0,
              color: Colors.teal,
            ),
            onPressed: () {
              if (currentPage == totalPages) {
                showCustomSnackBar(
                  context,
                  message: "No hay mas datos para cargar!",
                );
              } else {
                onPageChanged(currentPage + 1);
              }
            },
            label: const Text(
              "Siguiente",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
