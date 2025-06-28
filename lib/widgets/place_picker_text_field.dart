import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'custom_text_field.dart';

class PlacePickerTextField extends StatefulWidget {
  final String label;
  final String? componentFilter;
  final void Function(String description) onSelected;
  final String? errorText;
  final String? initialValue; // ✅ Step 1

  const PlacePickerTextField({
    super.key,
    required this.label,
    this.componentFilter,
    required this.onSelected,
    this.errorText,
    this.initialValue, // ✅ Step 1
  });

  @override
  State<PlacePickerTextField> createState() => _PlacePickerTextFieldState();
}

class _PlacePickerTextFieldState extends State<PlacePickerTextField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  List<Prediction> _predictions = [];
  bool _isLoading = false;

  String get _apiKey => 'AIzaSyDGDin8KgtPcY9lZEJQ1W4vtqhPvO-oVyg';

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? ''; // ✅ Step 2
  }

  @override
  void didUpdateWidget(covariant PlacePickerTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  void _onChanged(String input) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (input.isNotEmpty) {
        _fetchAutocomplete(input);
      } else {
        setState(() => _predictions = []);
      }
    });
  }

  Future<void> _fetchAutocomplete(String input) async {
    setState(() => _isLoading = true);
    final params = {'input': input, 'key': _apiKey};
    if (widget.componentFilter != null) {
      params['components'] = widget.componentFilter!;
    }
    final uri = Uri.https('maps.googleapis.com', '/maps/api/place/autocomplete/json', params);
    try {
      final res = await http.get(uri);
      if (!mounted) return;
      final jsonBody = jsonDecode(res.body);
      if (jsonBody['status'] == 'OK') {
        final list = (jsonBody['predictions'] as List);
        setState(() => _predictions = list.map((e) => Prediction.fromJson(e)).toList());
      } else {
        setState(() => _predictions = []);
      }
    } catch (_) {
      if (mounted) setState(() => _predictions = []);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _onPredictionTap(Prediction p) {
    _controller.text = p.description;
    setState(() => _predictions = []);
    widget.onSelected(p.description);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: widget.label,
          controller: _controller,
          onChanged: (val) {
            _onChanged(val);
            widget.onSelected(val);
          },
          errorText: widget.errorText,
        ),
        if (_isLoading) const LinearProgressIndicator(),
        if (_predictions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _predictions.length,
            itemBuilder: (context, index) {
              final p = _predictions[index];
              return ListTile(
                title: Text(p.mainText),
                subtitle: Text(p.secondaryText),
                onTap: () => _onPredictionTap(p),
              );
            },
          ),
      ],
    );
  }
}

class Prediction {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;

  Prediction({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    placeId: json['place_id'],
    description: json['description'],
    mainText: json['structured_formatting']['main_text'],
    secondaryText: json['structured_formatting']['secondary_text'] ?? '',
  );
}
