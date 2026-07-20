import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/data/models/agent_model.dart';

import 'agent_card.dart';

class AgentCarousel extends StatefulWidget {
  const AgentCarousel({
    super.key,
    required this.agents,
    required this.selectedAgent,
    required this.onAgentChanged,
  });

  final List<AgentModel> agents;
  final AgentModel? selectedAgent;
  final ValueChanged<AgentModel> onAgentChanged;

  @override
  State<AgentCarousel> createState() => _AgentCarouselState();
}

class _AgentCarouselState extends State<AgentCarousel>
    with SingleTickerProviderStateMixin {
  late final PageController controller;

  late final AnimationController floatController;
  late final Animation<double> floatAnimation;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    controller = PageController(
      initialPage: currentPage,
      viewportFraction: .76,
    );

    floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    floatAnimation = Tween<double>(begin: 0, end: -16).animate(
      CurvedAnimation(parent: floatController, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.agents.isNotEmpty) {
        widget.onAgentChanged(widget.agents.first);
      }
    });
  }

  @override
  void didUpdateWidget(covariant AgentCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedAgent == null) return;

    final index = widget.agents.indexWhere(
      (agent) => agent.id == widget.selectedAgent!.id,
    );

    if (index != -1 && index != currentPage) {
      currentPage = index;

      if (controller.hasClients) {
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.agents.isEmpty) {
      return const SizedBox(
        height: 400,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 400,
      child: AnimatedBuilder(
        animation: Listenable.merge([controller, floatController]),
        builder: (_, __) {
          final page = controller.hasClients
              ? controller.page ?? currentPage.toDouble()
              : currentPage.toDouble();

          return PageView.builder(
            controller: controller,
            itemCount: widget.agents.length,

            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });

              widget.onAgentChanged(widget.agents[index]);
            },

            itemBuilder: (_, index) {
              final agent = widget.agents[index];

              final distance = page - index;
              final absDistance = distance.abs();

              final scale = (1 - absDistance * .22).clamp(.78, 1.0);

              final opacity = (1 - absDistance * .55).clamp(.40, 1.0);

              final translateY = absDistance * 38;

              final rotateY = distance * .22;

              final rotateZ = distance * .025;

              final floating = widget.selectedAgent?.id == agent.id
                  ? floatAnimation.value
                  : 0.0;

              return Center(
                child: Opacity(
                  opacity: opacity,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0015)
                      ..translate(0.0, translateY + floating)
                      ..rotateY(rotateY)
                      ..rotateZ(rotateZ)
                      ..scale(scale),
                    child: AgentCard(
                      agent: agent,
                      selected: widget.selectedAgent?.id == agent.id,
                      onTap: () {
                        controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
