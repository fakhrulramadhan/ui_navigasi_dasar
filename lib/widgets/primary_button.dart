import 'package:flutter/material.dart';

/// Tombol aksi utama dengan dukungan state loading.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.enabled,
  });

  final String label;
  final Future<void> Function()? onPressed;
  final bool loading;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    final effectiveEnabled = enabled ?? !loading;
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: effectiveEnabled
            ? () async {
                final navigator = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);
                try {
                  await onPressed?.call();
                } catch (e) {
                  if (navigator.mounted) {
                    messenger.showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                }
              }
            : null,
        child: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(label),
      ),
    );
  }
}
