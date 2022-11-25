import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_formatters.dart';

class RowDetail extends StatelessWidget {
  final TypeSection type;
  final String label;
  final String value;
  final IconData icon;

  const RowDetail(
      {Key? key,
      required this.type,
      required this.label,
      required this.value,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black45)),
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(icon, size: 19.0, color: Colors.black54),
            const SizedBox(width: 6),
            if (type == TypeSection.number)
              Tooltip(
                message: 'Clique para realizar uma chamada',
                child: InkWell(
                  onTap: () => _makePhoneCall(value),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(AppMaskFormatters.phone.maskText(value),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400)),
                  ),
                ),
              )
            else
              Text(value,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400)),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<void> _makePhoneCall(final String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}

enum TypeSection { text, number }
