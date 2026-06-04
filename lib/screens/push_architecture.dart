// File: ws_test_client.dart
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WsTestClient extends StatefulWidget {
  // Replace with your actual API Gateway WebSocket endpoint
  final String apiGatewayUrl;

  const WsTestClient({Key? key, required this.apiGatewayUrl}) : super(key: key);

  @override
  State<WsTestClient> createState() => _WsTestClientState();
}

class _WsTestClientState extends State<WsTestClient> {
  late WebSocketChannel _channel;
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse(widget.apiGatewayUrl));

    // Listen for incoming messages
    _channel.stream.listen((message) {
      setState(() {
        _messages.add("Received: $message");
      });
    }, onError: (error) {
      setState(() {
        _messages.add("Error: $error");
      });
    }, onDone: () {
      setState(() {
        _messages.add("Connection closed.");
      });
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
      setState(() {
        _messages.add("Sent: ${_controller.text}");
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebSocket Test Client")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Send a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}