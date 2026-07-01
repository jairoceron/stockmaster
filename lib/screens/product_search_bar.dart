import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSearchBar extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const ProductSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // 🔹 altura reducida del campo de texto
      child: TextField(
        style: GoogleFonts.poppins(
          fontSize: 13, // 🔹 tipografía más pequeña y moderna
          fontWeight: FontWeight.w400, // 🔹 sin negrilla
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          prefixIcon: const Icon(Icons.search, size: 18, color: Colors.grey),
          hintText: 'Buscar producto...',
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade600,
          ),
          filled: true,
          fillColor: Colors.grey.shade100, // 🔹 fondo suave y moderno
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 1.2),
          ),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
