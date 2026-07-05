import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileBottomActions extends StatelessWidget {
  const ProfileBottomActions({
    super.key,
    required this.onEditTap,
    required this.Logout,
    required this.isLoadingUpdate,
    required this.isLoadingSkeleton,
    required this.isLoadingLogout,
  });

  final VoidCallback onEditTap;
  final VoidCallback Logout;
  final bool isLoadingUpdate;
  final bool isLoadingLogout;
  final bool isLoadingSkeleton;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoadingSkeleton,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 58,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Appcolors.background, Color(0xff0B5D33)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.background.withValues(alpha: .35),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: isLoadingUpdate ? null : onEditTap,
                    child: Center(
                      child: isLoadingUpdate
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Appcolors.background,
                              size: 24,
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit_rounded, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  "Save Changes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 58,
              child: isLoadingLogout
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Appcolors.background,
                        size: 24,
                      ),
                    )
                  : OutlinedButton.icon(
                      onPressed: isLoadingLogout ? null : Logout,
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.redAccent,
                      ),
                      label: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.redAccent.withValues(alpha: .5),
                        ),
                        backgroundColor: Colors.redAccent.withValues(
                          alpha: .08,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
