import 'package:flutter/material.dart';
import 'package:kitanda_app/app/src/auth/config/custom_color.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryTile({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('selecionado: $isSelected');
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            color:
                isSelected ? CustomColor.customSwatchColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:
                  isSelected ? Colors.white : CustomColor.customContrasctColor,
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
