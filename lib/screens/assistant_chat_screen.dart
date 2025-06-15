import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart'; // Uncomment for actual TTS

class AssistantChatScreen extends StatefulWidget {
  const AssistantChatScreen({super.key});

  @override
  State<AssistantChatScreen> createState() => _AssistantChatScreenState();
}

class _AssistantChatScreenState extends State<AssistantChatScreen> {
  final TextEditingController _textInputController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isRecording = false; // For voice input
  // FlutterTts flutterTts = FlutterTts(); // Uncomment for actual TTS

  @override
  void initState() {
    super.initState();
    // _initTts(); // Uncomment for actual TTS
    _addAssistantMessage('Hello! How can I help you today?');
    _textInputController.addListener(_onTextInputChanged);
  }

  // Future _initTts() async { // Uncomment for actual TTS
  //   flutterTts.setLanguage("en-US");
  //   flutterTts.setSpeechRate(0.5);
  //   flutterTts.setVolume(1.0);
  //   flutterTts.setPitch(1.0);
  // }

  @override
  void dispose() {
    _textInputController.removeListener(_onTextInputChanged);
    _textInputController.dispose();
    // flutterTts.stop(); // Uncomment for actual TTS
    super.dispose();
  }

  void _onTextInputChanged() {
    setState(() {
      // Rebuild to update the icon in the text field's suffix
    });
  }

  void _addAssistantMessage(String message) {
    setState(() {
      _messages.add({'sender': 'assistant', 'text': message});
    });
    // _speak(message); // Uncomment for actual TTS
  }

  void _addUserMessage(String message) {
    setState(() {
      _messages.add({'sender': 'user', 'text': message});
    });
    _processUserMessage(message);
  }

  // Future _speak(String text) async { // Uncomment for actual TTS
  //   await flutterTts.speak(text);
  // }

  void _processUserMessage(String message) {
    // Simulate assistant response
    String response = 'I received your message: "$message". How else can I assist you?';
    if (message.toLowerCase().contains('medication')) {
      response = 'You can manage your medications on the My Medications page.';
    } else if (message.toLowerCase().contains('reminders')) {
      response = 'Check your reminders on the Reminders page.';
    }
    _addAssistantMessage(response);
  }

  void _handleSendOrVoiceInput() {
    if (_textInputController.text.isNotEmpty) {
      _handleTextInput();
    } else {
      _handleVoiceInput();
    }
  }

  void _handleTextInput() {
    if (_textInputController.text.isNotEmpty) {
      _addUserMessage(_textInputController.text);
      _textInputController.clear();
    }
  }

  void _handleVoiceInput() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      // Simulate voice recording and transcription
      Future.delayed(const Duration(seconds: 3), () {
        _simulateVoiceToText('What is my next appointment?');
      });
    } else {
      // Stop recording (logic would be here)
    }
  }

  void _simulateVoiceToText(String text) {
    setState(() {
      _textInputController.text = text; // Populate text field with voice input
      _isRecording = false;
      _addUserMessage(text); // Send the transcribed text as a user message
      _textInputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assistant Chat',
          style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: colorScheme.onSurface),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Chat History',
                  style: textTheme.headlineSmall?.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['sender'] == 'user';
                  return ListTile(
                    title: Text(
                      message['text']!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: isUser ? colorScheme.primary : colorScheme.onSurface,
                        fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    leading: Icon(
                      isUser ? Icons.person : Icons.assistant,
                      color: isUser ? colorScheme.primary : colorScheme.onSurface,
                    ),
                    onTap: () {
                      // Optionally, tapping a history item could load it into the main chat
                      // For now, we just close the drawer.
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: isUser ? colorScheme.primaryContainer : colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text']!,
                          style: textTheme.bodyLarge?.copyWith(
                            color: isUser ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textInputController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: colorScheme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.attach_file, color: colorScheme.primary),
                        onPressed: () {
                          // TODO: Implement image file selection logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Image selection not yet implemented.')),
                          );
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _textInputController.text.isNotEmpty ? Icons.send : Icons.mic,
                          color: colorScheme.primary,
                        ),
                        onPressed: _handleSendOrVoiceInput,
                      ),
                    ),
                    style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
                    onSubmitted: (_) => _handleSendOrVoiceInput(), // Send on enter
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 