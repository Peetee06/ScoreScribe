import 'package:flutter/material.dart';
import 'package:spielblock/widgets/new_game_missing_input_alert.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  ScrollController _scrollController = ScrollController();
  final TextEditingController _gameNameController = TextEditingController();
  final _playerControllers = [];
  final _focusNodes = [];
  bool _isAddingNewField = false;

  @override
  void initState() {
    super.initState();
    _addPlayerField();
  }

  void _addPlayerFieldEventListener() {
    if (_focusNodes.last.hasFocus && !_isAddingNewField) {
      if (_playerControllers.length == 1 ||
          _playerControllers[_playerControllers.length - 2].text.isNotEmpty) {
        _isAddingNewField = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _addPlayerField();
          _isAddingNewField = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _gameNameController.dispose();
    for (final controller in _playerControllers) {
      controller.dispose();
      controller.removeListener(() {});
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
      focusNode.removeListener(() {});
    }
    super.dispose();
  }

  void _addPlayerField() {
    setState(() {
      var newController = TextEditingController();
      var newFocusNode = FocusNode();
      _playerControllers.add(newController);
      _focusNodes.add(newFocusNode);

      // After adding the new field, scroll to the bottom.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });

      // Remove listener from the last focus node.
      if (_focusNodes.length > 1) {
        _focusNodes[_focusNodes.length - 2]
            .removeListener(_addPlayerFieldEventListener);
      }

      // Add listener to the new last focus node.
      newFocusNode.addListener(_addPlayerFieldEventListener);

      // Add listener for empty field removal
      newFocusNode.addListener(() {
        if (!newFocusNode.hasFocus && newController.text.isEmpty) {
          var index = _playerControllers.indexOf(newController);
          if (index != _playerControllers.length - 1 &&
              _playerControllers.length > 1) {
            setState(() {
              _playerControllers.removeAt(index);
              _focusNodes.removeAt(index);
            });
          }
        }
      });

      // If the last playerController isn't the first and it's empty, make it disabled.
      if (_playerControllers.length > 1) {
        _playerControllers[_playerControllers.length - 2].addListener(() {
          // Whenever the penultimate textfield's content changes, refresh UI.
          if (!newFocusNode.hasFocus) {
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Game',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0,
                  MediaQuery.of(context).padding.bottom + 40.0),
              children: <Widget>[
                TextField(
                  controller: _gameNameController,
                  decoration: const InputDecoration(
                    labelText: 'Game name',
                  ),
                ),
                ..._playerControllers.asMap().entries.map((entry) {
                  int idx = entry.key;
                  TextEditingController controller = entry.value;
                  return TextField(
                    controller: controller,
                    focusNode: _focusNodes[idx],
                    decoration: InputDecoration(
                      labelText: 'Player ${idx + 1}',
                    ),
                    enabled: idx != _playerControllers.length - 1 ||
                        idx == 0 ||
                        (idx == _playerControllers.length - 1 &&
                            _playerControllers[idx - 1].text.isNotEmpty),
                  );
                }).toList(),
              ],
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _saveGame,
                child: Text('Play!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveGame() {
    // Implement your game saving logic here.
    final gameName = _gameNameController.text.trim();
    final playerNames = _playerControllers
        .map((controller) => controller.text.trim())
        .where((playerName) => playerName.isNotEmpty)
        .toList();

    if (gameName.isEmpty || playerNames.isEmpty) {
      String message;
      if (gameName.isEmpty && playerNames.isEmpty) {
        message = "Please enter a game name and add at least one player";
      } else if (gameName.isEmpty) {
        message = "Please enter a game name";
      } else {
        message = "Please add at least one player";
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MissingInputsAlert(message: message);
          });
    } else {
      print('Saving');
    }
  }
}
