import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_sphere/features/family_member_form/family_member_form_controller.dart';
import 'package:samaj_sphere/widgets/custom_text_field.dart';
import 'package:samaj_sphere/widgets/place_picker_text_field.dart';

class FamilyAddressInfoStep extends StatelessWidget {
  FamilyAddressInfoStep({super.key});

  final FamilyMemberFormController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => CustomTextField(
            label: "Flat Number",
            initialValue: controller.addressFlat.value,
            onChanged: (v) => controller.updateFieldAndClearError('addressFlat', v),
            errorText: controller.addressFlatError.value,
          )),
          Obx(() => CustomTextField(
            label: "Building Name",
            initialValue: controller.addressBuilding.value,
            onChanged: (v) => controller.updateFieldAndClearError('addressBuilding', v),
            errorText: controller.addressBuildingError.value,
          )),
          Obx(() => CustomTextField(
            label: "Street",
            initialValue: controller.addressStreet.value,
            onChanged: (v) => controller.updateFieldAndClearError('addressStreet', v),
            errorText: controller.addressStreetError.value,
          )),
          Obx(() => CustomTextField(
            label: "Landmark",
            initialValue: controller.addressLandmark.value,
            onChanged: (v) => controller.updateFieldAndClearError('addressLandmark', v),
            errorText: controller.addressLandmarkError.value,
          )),

          const SizedBox(height: 16),

          Obx(() => PlacePickerTextField(
            label: "Country",
            onSelected: (desc) {
              controller.updateFieldAndClearError('addressCountry', desc);
            },
            errorText: controller.addressCountryError.value,
          )),

          const SizedBox(height: 16),

          Obx(() {
            final country = controller.addressCountry.value;
            return PlacePickerTextField(
              label: "State",
              componentFilter: country.isNotEmpty ? 'addressState:$country' : null,
              onSelected: (desc) {
                controller.updateFieldAndClearError('addressState', desc);
              },
              errorText: controller.addressStateError.value,
            );
          }),
          const SizedBox(height: 16),


          Obx(() {
            final district = controller.addressDistrict.value;
            return PlacePickerTextField(
              label: "District",
              componentFilter: district.isNotEmpty ? 'administrative_area_level_2:$district' : null,
              onSelected: (desc) {
                controller.updateFieldAndClearError('addressDistrict', desc);
              },
            );
          }),
          const SizedBox(height: 16),
          Obx(() {
            final city = controller.addressCity.value;
            return PlacePickerTextField(
              label: "City",
              componentFilter: city.isNotEmpty ? 'administrative_area_level_1:$city' : null,
              onSelected: (desc) {
                controller.updateFieldAndClearError('addressCity', desc);
              },
              errorText: controller.cityError.value,
            );
          }),
          const SizedBox(height: 16),
          Obx(() {
            final state = controller.nativeState.value;
            return PlacePickerTextField(
              label: "Native State",
              componentFilter: state.isNotEmpty ? 'administrative_area_level_1:$state' : null,
              onSelected: (desc) {
                controller.updateFieldAndClearError('nativeState', desc);
              },
               errorText: controller.nativeStateError.value,
            );
          }),

          const SizedBox(height: 16),

          Obx(() {
            final state = controller.nativeCity.value;
            return PlacePickerTextField(
              label: "Native City",
              componentFilter: state.isNotEmpty ? 'administrative_area_level_1:$state' : null,
              onSelected: (desc) {
                controller.updateFieldAndClearError('nativeCity', desc);

              },
               errorText: controller.nativeCityError.value,
            );
          }),
          const SizedBox(height: 16),
          Obx(() => CustomTextField(
            label: "Pincode",
            keyboardType: TextInputType.number,
            initialValue: controller.addressPincode.value,
            onChanged: (v) => controller.updateFieldAndClearError('addressPincode', v),
            errorText: controller.addressPincodeError.value,
          )),
        ],
      ),
    );
  }
}
