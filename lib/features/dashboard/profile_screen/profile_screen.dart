import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/features/dashboard/profile_screen/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profileData.value;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (profile.samajName!.isNotEmpty) {
            controller.fetchAssociatedTemples(profile.samajName!);
          }
        });

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: profile.avatarPath != null &&
                              profile.avatarPath!.isNotEmpty
                              ? NetworkImage(profile.avatarPath!)
                              : const AssetImage("assets/images/avatar_default.webp")
                          as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: GestureDetector(
                            onTap: controller.pickAndUploadProfileImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(Icons.edit, size: 16, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(profile.name ?? '',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.9),
                        )),
                    Text(profile.contactPhone ?? '',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.7),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.logout, color: colorScheme.onPrimary),
                        onPressed: () => controller.logout(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main profile data tiles
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTile("Phone Number", profile.contactPhone ?? '', textTheme, colorScheme),
                  _buildTile("Email", profile.contactEmail ?? '', textTheme, colorScheme),
                  _buildTile("Birth Date", profile.birthDate ?? '', textTheme, colorScheme),
                  _buildTile("Blood Group", profile.bloodGroup ?? '', textTheme, colorScheme),
                  _buildTile("Nature of Duties", profile.natureOfDuties ?? '', textTheme, colorScheme),
                  _buildTile("Samaj Name", profile.samajName!, textTheme, colorScheme),

                  if (controller.associatedTemples.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text("Associated Temples", style: textTheme.titleMedium),
                    ...controller.associatedTemples.map((temple) {
                      return _buildTile(
                        temple['name'] ?? 'Unnamed',
                        temple['location'] ?? 'Unknown',
                        textTheme,
                        colorScheme,
                      );
                    }),
                  ],
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTile(
      String title,
      String value,
      TextTheme textTheme,
      ColorScheme colorScheme,
      ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        title: Text(
          title,
          style: textTheme.labelLarge?.copyWith(color: colorScheme.primary),
        ),
        subtitle: Text(
          value.isNotEmpty ? value : "—",
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
