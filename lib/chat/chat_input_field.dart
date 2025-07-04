import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:smallities/src/bindings/signals/signals.dart";

class ChatUITextField extends StatefulWidget {
  const ChatUITextField({super.key});

  @override
  State<ChatUITextField> createState() => _ChatUITextFieldState();
}

class _ChatUITextFieldState extends State<ChatUITextField> {
  final ImagePicker _imagePicker = ImagePicker();
  final focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.textEditingController.addListener(() {
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: this.focusNode,
              controller: this.textEditingController,
              onSubmitted: (_) {
                this.onSubmit();
              },
              style: const TextStyle(color: Colors.black),
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "Send a message...",
                fillColor: Colors.grey[200],
                filled: true,
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.25,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                border: outlineBorder,
                focusedBorder: outlineBorder,
                enabledBorder: outlineBorder,
                disabledBorder: outlineBorder,
              ),
            ),
          ),
          this.textEditingController.text.isNotEmpty
              ? IconButton(
                  color: Colors.green,
                  onPressed: this.onSubmit,
                  icon: const Icon(Icons.send),
                )
              : Row(
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: () => this.onIconPressed(ImageSource.camera),
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: () => this.onIconPressed(ImageSource.gallery),
                      icon: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  void onSubmit() {
    MessageSent(content: this.textEditingController.text).sendSignalToRust();
    this.textEditingController.text = "";
    this.focusNode.requestFocus();
  }

  void onIconPressed(ImageSource imageSource) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: imageSource);
      if (image != null) {
        print("# image picked: ${image.path}");
      }
    } catch (e) {
      print("## failed to pick image: $e");
    }
  }
}
