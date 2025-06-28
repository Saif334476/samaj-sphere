import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/features/family_head_form/head_form_controller.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import 'package:samaj_sphere/widgets/place_picker_text_field.dart';

class AddressInfoScreen extends StatelessWidget {
  AddressInfoScreen({super.key});

  final HeadFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flat
            Obx(() => CustomTextField(
                  label: "Flat Number",
                  initialValue: controller.addressFlat.value,
                  onChanged: (v) =>
                      controller.updateFieldAndClearError('addressFlat', v),
                  errorText: controller.addressFlatError.value,
                )),
            // Building
            Obx(() => CustomTextField(
                  label: "Building Name",
                  initialValue: controller.addressBuilding.value,
                  onChanged: (v) =>
                      controller.updateFieldAndClearError('addressBuilding', v),
                  errorText: controller.addressBuildingError.value,
                )),
            // Street
            Obx(() => CustomTextField(
                  label: "Street Name",
                  initialValue: controller.addressStreet.value,
                  onChanged: (v) =>
                      controller.updateFieldAndClearError('addressStreet', v),
                  errorText: controller.addressStreetError.value,
                )),
            // Landmark (optional, so no error)
            CustomTextField(
              label: "Landmark",
              initialValue: controller.addressLandmark.value,
              onChanged: (v) => controller.updateField('addressLandmark', v),
            ),

            const SizedBox(height: 24),

            // Country
            PlacePickerTextField(
              label: "Country",
              onSelected: (desc) {
                controller.updateFieldAndClearError('addressCountry', desc);
                controller.updateField('addressState', '');
                controller.updateField('addressCity', '');
                controller.updateField('addressDistrict', '');
              },
              errorText: controller.addressCountryError.value,
            ),

            const SizedBox(height: 16),

            // State
            Obx(() {
              final country = controller.addressCountry.value;
              return PlacePickerTextField(
                label: "State",
                componentFilter: country.isNotEmpty ? 'country:$country' : null,
                initialValue:
                    controller.addressState.value, // ✅ now it stays in sync
                onSelected: (desc) {
                  controller.updateFieldAndClearError('addressState', desc);

                },
                errorText: controller.addressStateError.value,
              );
            }),

            const SizedBox(height: 16),

            // City
            Obx(() {
              final state = controller.addressState.value;
              return PlacePickerTextField(
                label: "City",
                componentFilter: state.isNotEmpty
                    ? 'administrative_area_level_1:$state'
                    : null,
                onSelected: (desc) {
                  controller.updateFieldAndClearError('addressCity', desc);
                  controller.updateField('addressDistrict', '');
                },
                errorText: controller.addressCityError.value,
              );
            }),

            const SizedBox(height: 16),

            // District
            Obx(() {
              final state = controller.addressState.value;
              return PlacePickerTextField(
                label: "District",
                componentFilter: state.isNotEmpty
                    ? 'administrative_area_level_2:$state'
                    : null,
                onSelected: (desc) {
                  controller.updateField('addressDistrict', desc);
                },
              );
            }),

            const SizedBox(height: 16),

            // Native State
            Obx(() {
              final country = controller.addressCountry.value;
              return PlacePickerTextField(
                label: "Native State",
                componentFilter: country.isNotEmpty ? 'country:$country' : null,
                onSelected: (desc) {
                  controller.updateField('addressNativeState', desc);
                  controller.updateField('addressNativeCity', '');
                },
              );
            }),

            const SizedBox(height: 16),

            // Native City
            Obx(() {
              final nativeState = controller.addressNativeState.value;
              return PlacePickerTextField(
                label: "Native City",
                componentFilter: nativeState.isNotEmpty
                    ? 'administrative_area_level_1:$nativeState'
                    : null,
                onSelected: (desc) {
                  controller.updateField('addressNativeCity', desc);
                },
              );
            }),

            const SizedBox(height: 16),

            // Pincode
            Obx(() => CustomTextField(
                  label: "Pincode",
                  initialValue: controller.addressPincode.value,
                  onChanged: (v) =>
                      controller.updateFieldAndClearError('addressPincode', v),
                  keyboardType: TextInputType.number,
                  errorText: controller.addressPincodeError.value,
                )),
          ],
        ),
      ),
    );
  }
}
