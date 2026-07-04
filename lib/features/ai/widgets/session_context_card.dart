import 'package:flutter/material.dart';
import '../../../../cores/theme/app_colors.dart';

class SessionContextCard extends StatelessWidget {
  const SessionContextCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.75),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(.7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Session Context",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "Active",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _objective()),

              const SizedBox(width: 28),

              Expanded(child: _progress()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _objective() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "CURRENT OBJECTIVE",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 10),

        Text(
          "Synthesize Q3 financial reports and draft an executive summary highlighting key growth metrics.",
          style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xff4B5563)),
        ),
      ],
    );
  }

  Widget _progress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "PROGRESS",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: .45,
            minHeight: 10,
            backgroundColor: Colors.grey.shade200,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Data Extraction", style: TextStyle(color: Colors.grey)),

            Text("45%", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
