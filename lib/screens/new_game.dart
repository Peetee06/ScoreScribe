import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scorescribe/models/game.dart';
import 'package:scorescribe/providers/games_provider.dart';
import 'package:scorescribe/screens/game.dart';
import 'package:scorescribe/widgets/alerts/leave_new_game_screen.dart';
import 'package:scorescribe/widgets/alerts/new_game_missing_input_alert.dart';

class NewGameScreen extends ConsumerStatefulWidget {
  const NewGameScreen({super.key});

  @override
  ConsumerState<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends ConsumerState<NewGameScreen> {
  final _scrollController = ScrollController();
  final TextEditingController _gameNameController = TextEditingController();
  final _playerControllers = [];
  final _focusNodes = [];
  bool _isAddingNewField = false;
  bool _isSaving = false;

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

  bool _hasInputs() {
    final gameName = _gameNameController.text.trim();
    final playerNames = _playerControllers
        .map((controller) => controller.text.trim().toString())
        .where((playerName) => playerName.isNotEmpty)
        .toList();

    return !(gameName.isEmpty && playerNames.isEmpty);
  }

  Future<bool> _onWillPop() async {
    if (_hasInputs() && !_isSaving) {
      // Show an alert dialog and wait for the user's decision.
      for (final focusNode in _focusNodes) {
        focusNode.unfocus();
      }
      final confirm = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const LeaveNewGameScreenAlertDialog();
        },
      );

      return confirm ?? false;
    }

    // No changes, allow navigation without showing the alert.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          title: Text(
            'New Game',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceTint,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          elevation: 2,
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _gameNameController,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                decoration: InputDecoration(
                  labelText: 'Game Name',
                  labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.5),
                      ),
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  filled: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        width: 2.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0,
                    MediaQuery.of(context).padding.bottom + 40.0),
                itemCount: _playerControllers.length,
                itemBuilder: (context, index) {
                  final controller = _playerControllers[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    padding: const EdgeInsets.only(left: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              controller: controller,
                              focusNode: _focusNodes[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                              decoration: InputDecoration(
                                labelText: 'Player ${index + 1}',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer
                                          .withOpacity(0.5),
                                    ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer,
                                      width: 2.0),
                                ),
                              ),
                              enabled: index != _playerControllers.length - 1 ||
                                  index == 0 ||
                                  (index == _playerControllers.length - 1 &&
                                      _playerControllers[index - 1]
                                          .text
                                          .isNotEmpty),
                            ),
                          ),
                        ),
                        (_playerControllers.length > 1 &&
                                index != _playerControllers.length - 1)
                            ? IconButton(
                                onPressed: () {
                                  for (final focusNode in _focusNodes) {
                                    focusNode.unfocus();
                                  }
                                  setState(() {
                                    _playerControllers.removeAt(index);
                                    _focusNodes.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.clear),
                              )
                            : const SizedBox(width: 48.0),
                      ],
                    ),
                  );
                },
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
      ),
    );
  }

  void _saveGame() {
    // Implement your game saving logic here.
    final gameName = _gameNameController.text.trim();
    final playerNames = _playerControllers
        .map((controller) => controller.text.trim().toString())
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
      final newGame = Game(gameName, playerNames: playerNames);
      ref.read(gamesProvider.notifier).addGame(newGame);
      _isSaving = true;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GameScreen(game: newGame),
        ),
      );
    }
  }
}
