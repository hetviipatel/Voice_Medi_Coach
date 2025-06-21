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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // FlutterTts flutterTts = FlutterTts(); // Uncomment for actual TTS

  @override
  void initState() {
    super.initState();
    // _initTts(); // Uncomment for actual TTS
     _addAssistantMessage('Hello! How can I help you today?'); // Remove initial chat bubble
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
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Assistant Chat',
          style: textTheme.headlineSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: colorScheme.primary),
            tooltip: 'Chat History',
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      drawer: Drawer(
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
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          color: isDark ? colorScheme.surface : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['sender'] == 'user';
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: isUser
                                ? (isDark ? colorScheme.primary.withOpacity(0.22) : colorScheme.primary.withOpacity(0.15))
                                : (isDark ? colorScheme.surfaceVariant : Colors.grey[100]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(isUser ? 20 : 4),
                              bottomRight: Radius.circular(isUser ? 4 : 20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            message['text']!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: isUser
                                  ? colorScheme.primary
                                  : (isDark ? Colors.white : colorScheme.onSurface),
                              fontWeight: isUser ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    // Mic, file, and image buttons
                    Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(_isRecording ? Icons.mic : Icons.mic_none, color: colorScheme.primary),
                            tooltip: 'Voice Input',
                            onPressed: _handleVoiceInput,
                          ),
                          IconButton(
                            icon: Icon(Icons.attach_file, color: colorScheme.primary),
                            tooltip: 'Attach File',
                            onPressed: () {
                              // TODO: Implement file picker
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.image, color: colorScheme.primary),
                            tooltip: 'Attach Image',
                            onPressed: () {
                              // TODO: Implement image picker
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textInputController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          filled: true,
                          fillColor: isDark ? colorScheme.surfaceVariant : Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: colorScheme.primary, width: 2),
                          ),
                        ),
                        style: textTheme.bodyLarge?.copyWith(color: isDark ? Colors.white : null),
                        onSubmitted: (_) => _handleSendOrVoiceInput(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colorScheme.primary,
                      child: IconButton(
                        icon: Icon(
                          _textInputController.text.isNotEmpty ? Icons.send : Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: _handleSendOrVoiceInput,
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