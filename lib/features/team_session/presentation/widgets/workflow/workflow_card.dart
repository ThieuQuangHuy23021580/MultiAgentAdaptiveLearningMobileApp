// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:multi_agent_adaptive_learning_app/features/team_session/data/models/agent_task.dart';

// import '../../../../../../cores/theme/app_colors.dart';

// class WorkflowCard extends StatelessWidget {
//   final AgentTask task;

//   const WorkflowCard({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     final running = task.status == AgentTaskStatus.running;

//     final completed = task.status == AgentTaskStatus.completed;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 18),

//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,

//         children: [
//           Column(
//             children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 400),

//                 width: 46,
//                 height: 46,

//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,

//                   color: completed
//                       ? Colors.green.shade100
//                       : running
//                       ? AppColors.primary.withOpacity(.18)
//                       : Colors.grey.shade100,
//                 ),

//                 child: Icon(
//                   completed ? Icons.check : task.icon,
//                   color: completed ? Colors.green : AppColors.primary,
//                 ),
//               ),

//               Container(width: 2, height: 74, color: Colors.grey.shade300),
//             ],
//           ),

//           const SizedBox(width: 16),

//           Expanded(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(22),

//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),

//                 child: Container(
//                   padding: const EdgeInsets.all(18),

//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.white.withOpacity(.70),

//                         Colors.white.withOpacity(.35),
//                       ],
//                     ),

//                     borderRadius: BorderRadius.circular(22),

//                     border: Border.all(
//                       color: running
//                           ? AppColors.primary.withOpacity(.45)
//                           : Colors.white,
//                     ),
//                   ),

//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [
//                       Text(
//                         task.name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17,
//                         ),
//                       ),

//                       const SizedBox(height: 6),

//                       Text(
//                         task.description,
//                         style: const TextStyle(color: Color(0xff667085)),
//                       ),

//                       const SizedBox(height: 16),

//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(50),

//                         child: LinearProgressIndicator(
//                           value: task.progress,

//                           minHeight: 8,
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       Text(
//                         completed
//                             ? "Completed"
//                             : running
//                             ? "Running..."
//                             : "Waiting",

//                         style: TextStyle(
//                           color: completed
//                               ? Colors.green
//                               : running
//                               ? AppColors.primary
//                               : Colors.grey,

//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
