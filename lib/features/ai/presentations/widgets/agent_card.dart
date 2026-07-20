import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/data/models/agent_model.dart';

import '../../../../../cores/theme/app_colors.dart';

class AgentCard extends StatelessWidget {
  final AgentModel agent;
  final bool selected;
  final VoidCallback onTap;

  const AgentCard({
    super.key,
    required this.agent,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(.60),
                  Colors.white.withOpacity(.35),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selected
                    ? Colors.white.withOpacity(.95)
                    : Colors.white.withOpacity(.55),
                width: selected ? 2 : 1,
              ),
              boxShadow: [
                if (selected)
                  BoxShadow(
                    color: AppColors.primary.withOpacity(.18),
                    blurRadius: 45,
                    spreadRadius: -6,
                    offset: const Offset(0, 24),
                  ),

                BoxShadow(
                  color: Colors.black.withOpacity(selected ? .14 : .06),
                  blurRadius: selected ? 55 : 28,
                  spreadRadius: -6,
                  offset: Offset(0, selected ? 26 : 16),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(.25),
                            Colors.transparent,
                            Colors.white.withOpacity(.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 450),
                        scale: selected ? 1.05 : 1.0,
                        curve: Curves.easeOut,
                        child: Image.network(
                          agent.image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -32),
                      child: Center(
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.primary.withOpacity(.12),
                            child: Icon(
                              agent.icon,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            agent.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            agent.role,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            agent.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xff667085),
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
