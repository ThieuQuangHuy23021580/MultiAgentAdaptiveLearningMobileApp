// import 'package:flutter/material.dart';
// import 'package:multi_agent_adaptive_learning_app/features/ai/data/agent_model.dart';

// import 'agent_card.dart';

// class AgentCarousel extends StatefulWidget {
//   const AgentCarousel({super.key});

//   @override
//   State<AgentCarousel> createState() => _AgentCarouselState();
// }

// class _AgentCarouselState extends State<AgentCarousel>
//     with SingleTickerProviderStateMixin {
//   late final PageController controller;

//   late final AnimationController floatController;
//   late final Animation<double> floatAnimation;

//   int currentPage = 1;

//   final List<AgentModel> agents = const [
//     AgentModel(
//       name: "Mentor",
//       role: "Guidance & Strategy",
//       description:
//           "Provides strategic direction and helps solve complex problems.",
//       image:
//           "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=900",
//       icon: Icons.school,
//     ),
//     AgentModel(
//       name: "Researcher",
//       role: "Data Extraction",
//       description: "Scours documents and extracts valuable information.",
//       image:
//           "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=900",
//       icon: Icons.manage_search,
//     ),
//     AgentModel(
//       name: "Planner",
//       role: "Plan & Roadmap",
//       description:
//           "Breaks down goals into clear, actionable steps and organizes tasks for efficient execution.",
//       image:
//           "https://images.unsplash.com/photo-1455390582262-044cdead277a?w=900",
//       icon: Icons.summarize,
//     ),
//     AgentModel(
//       name: "Quiz Master",
//       role: "Assessment & Practice",
//       description: "Creates adaptive quizzes from your documents.",
//       image:
//           "https://images.unsplash.com/photo-1513258496099-48168024aec0?w=900",
//       icon: Icons.quiz,
//     ),

//     AgentModel(
//       name: "Flashcard Creator",
//       role: "Memory Reinforcement",
//       description: "Automatically generates intelligent flashcards.",
//       image:
//           "https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=900",
//       icon: Icons.style,
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();

//     controller = PageController(initialPage: 1, viewportFraction: .76);

//     floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..repeat(reverse: true);

//     floatAnimation = Tween<double>(begin: 0, end: -16).animate(
//       CurvedAnimation(parent: floatController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     floatController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 400,
//       child: AnimatedBuilder(
//         animation: Listenable.merge([controller, floatController]),
//         builder: (_, __) {
//           final page = controller.hasClients
//               ? (controller.page ?? controller.initialPage.toDouble())
//               : controller.initialPage.toDouble();

//           currentPage = page.round();

//           return PageView.builder(
//             clipBehavior: Clip.none,
//             controller: controller,
//             physics: const BouncingScrollPhysics(),
//             itemCount: agents.length,
//             itemBuilder: (_, index) {
//               final distance = page - index;
//               final absDistance = distance.abs();

//               final scale = (1 - absDistance * 0.22).clamp(.78, 1.0);

//               final opacity = (1 - absDistance * .55).clamp(.40, 1.0);

//               final translateY = absDistance * 38;

//               final rotateY = distance * .22;

//               final rotateZ = distance * .025;

//               final floating = index == currentPage
//                   ? floatAnimation.value
//                   : 0.0;

//               return Center(
//                 child: Opacity(
//                   opacity: opacity,
//                   child: Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.identity()
//                       // Perspective
//                       ..setEntry(3, 2, 0.0015)
//                       // Floating
//                       ..translate(0.0, translateY + floating)
//                       // CoverFlow
//                       ..rotateY(rotateY)
//                       // Rotate nhẹ
//                       ..rotateZ(rotateZ)
//                       // Scale
//                       ..scale(scale),

//                     child: AgentCard(
//                       agent: agents[index],
//                       selected: index == currentPage,
//                       onTap: () {
//                         controller.animateToPage(
//                           index,
//                           duration: const Duration(milliseconds: 500),
//                           curve: Curves.easeOutBack,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/data/agent_model.dart';

import 'agent_card.dart';

class AgentCarousel extends StatefulWidget {
  const AgentCarousel({super.key, required this.onAgentChanged});

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

  final List<AgentModel> agents = const [
    AgentModel(
      name: "Mentor",
      role: "Guidance & Strategy",
      description:
          "Provides strategic direction and helps solve complex problems.",
      image:
          "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=900",
      icon: Icons.school,
    ),
    AgentModel(
      name: "Research",
      role: "Data Extraction",
      description: "Scours documents and extracts valuable information.",
      image:
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=900",
      icon: Icons.manage_search,
    ),
    AgentModel(
      name: "Planner",
      role: "Plan & Roadmap",
      description: "Breaks down goals into clear and organizes tasks.",
      image:
          "https://images.unsplash.com/photo-1455390582262-044cdead277a?w=900",
      icon: Icons.summarize,
    ),
  ];

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
      widget.onAgentChanged(agents[currentPage]);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: agents.length,

            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });

              widget.onAgentChanged(agents[index]);
            },

            itemBuilder: (_, index) {
              final distance = page - index;
              final absDistance = distance.abs();

              final scale = (1 - absDistance * .22).clamp(.78, 1.0);

              final opacity = (1 - absDistance * .55).clamp(.40, 1.0);

              final translateY = absDistance * 38;

              final rotateY = distance * .22;

              final rotateZ = distance * .025;

              final floating = index == currentPage
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
                      agent: agents[index],
                      selected: index == currentPage,
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
