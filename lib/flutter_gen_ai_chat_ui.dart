/// A Flutter package that provides a customizable chat UI for AI applications,
/// featuring streaming responses, code highlighting, and markdown support.
library;

// Controllers
export 'src/controllers/chat_messages_controller.dart';
export 'src/controllers/action_controller.dart';
export 'src/controllers/ai_context_controller.dart';
// Essential CopilotKit-inspired controllers (prioritized)
export 'src/controllers/readable_context_controller.dart';
export 'src/controllers/context_aware_chat_controller.dart';
// Advanced CopilotKit-inspired controllers  
export 'src/controllers/headless_chat_controller.dart';
export 'src/controllers/ai_text_input_controller.dart';
export 'src/controllers/agent_orchestrator.dart';

// Services
export 'src/services/ai_service.dart';

// Configuration
export 'src/models/ai_chat_config.dart';

// Core models
export 'src/models/chat/models.dart';
export 'src/models/ai_action.dart';
export 'src/models/ai_context.dart';
export 'src/models/example_question.dart';
export 'src/models/example_question_config.dart' hide ExampleQuestion;
export 'src/models/file_upload_options.dart';
export 'src/models/input_options.dart';
export 'src/models/models.dart';
export 'src/models/welcome_message_config.dart';
// Advanced CopilotKit-inspired models
export 'src/models/chat_thread.dart';
export 'src/models/ai_suggestion.dart';
export 'src/models/ai_agent.dart';

// Theme
export 'src/theme/custom_theme_extension.dart';

// Utils
export 'src/utils/color_extensions.dart';
export 'src/utils/glassmorphic_container.dart';
export 'src/utils/action_error_handler.dart';

// Widgets
export 'src/widgets/action_result_widget.dart';
export 'src/widgets/ai_chat_widget.dart';
export 'src/widgets/chat_input.dart';
export 'src/widgets/ai_action_provider.dart';
export 'src/widgets/ai_context_provider.dart';
export 'src/widgets/copilot_textarea.dart';  // Essential CopilotKit component
export 'src/widgets/custom_chat_widget.dart';
export 'src/widgets/glassmorphic_container.dart';
export 'src/widgets/loading_widget.dart';
export 'src/widgets/message_attachment.dart';
export 'src/widgets/ai_suggestions_bar.dart';
export 'src/widgets/inline_autocomplete_text_field.dart';
export 'src/widgets/result/result_renderer_registry.dart';
export 'src/widgets/result/result_card.dart';
export 'src/widgets/result/key_value_list.dart';
export 'src/widgets/result/callout.dart';
export 'src/widgets/result/data_table_lite.dart';
// Voice UI wrappers (UI-only)
export 'src/widgets/voice/voice_send_button.dart';
export 'src/widgets/voice/voice_status_bar.dart';
export 'src/widgets/voice/transcript_chip.dart';

// Advanced CopilotKit-inspired agent implementations
export 'src/agents/example_agents.dart';
