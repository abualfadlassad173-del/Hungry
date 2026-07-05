import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:hungry/core/theme/app_text_style.dart';
import 'package:hungry/core/theme/custom_text.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.subtitle,
    this.selectedImage,
    this.imageUrl,
    this.onEditImage,
    this.onRemoveImage,
  });

  final String name;
  final String subtitle;
  final String? selectedImage;
  final String? imageUrl;
  final VoidCallback? onEditImage;
  final VoidCallback? onRemoveImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Appcolors.white.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 118,
                width: 118,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Appcolors.white.withValues(alpha: 0.75),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.black.withValues(alpha: 0.18),
                      blurRadius: 22,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: selectedImage != null
                      ? Image.file(
                          File(selectedImage!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 56,
                              color: Appcolors.grey,
                            );
                          },
                        )
                      : (imageUrl != null && imageUrl!.isNotEmpty)
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 56,
                              color: Appcolors.grey,
                            );
                          },
                        )
                      : const Icon(
                          Icons.person,
                          size: 56,
                          color: Appcolors.grey,
                        ),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: InkWell(
                  onTap: onEditImage,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Appcolors.background,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Welcome back',
                  style: TextStyle(
                    color: Appcolors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CustomText(
                  name,
                  style: Textstyle.text20bold.copyWith(color: Appcolors.white),
                ),
                const SizedBox(height: 6),
                CustomText(
                  subtitle,
                  style: TextStyle(
                    color: Appcolors.white.withValues(alpha: 0.78),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
