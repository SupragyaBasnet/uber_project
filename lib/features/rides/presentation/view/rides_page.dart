import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/services/place_service.dart';
import '../../domain/models/place_suggestion.dart';
import 'ride_selection_page.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({Key? key}) : super(key: key);

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final String _currentLocation = "Kathmandu, Nepal";
  final PlaceService _placeService = PlaceService();

  List<PlaceSuggestion> _originSuggestions = [];
  List<PlaceSuggestion> _destinationSuggestions = [];
  bool _isOriginLoading = false;
  bool _isDestinationLoading = false;
  Timer? _originDebounce;
  Timer? _destinationDebounce;
  bool _isOriginFocused = false;
  bool _isDestinationFocused = false;

  @override
  void initState() {
    super.initState();
    _setupListeners();
  }

  void _setupListeners() {
    _originController.addListener(() {
      if (_originDebounce?.isActive ?? false) _originDebounce!.cancel();
      _originDebounce = Timer(const Duration(milliseconds: 500), () {
        if (_isOriginFocused) {
          _getOriginSuggestions(_originController.text);
        }
      });
    });

    _destinationController.addListener(() {
      if (_destinationDebounce?.isActive ?? false)
        _destinationDebounce!.cancel();
      _destinationDebounce = Timer(const Duration(milliseconds: 500), () {
        if (_isDestinationFocused) {
          _getDestinationSuggestions(_destinationController.text);
        }
      });
    });
  }

  Future<void> _getOriginSuggestions(String input) async {
    if (input.length < 2) {
      setState(() {
        _originSuggestions = [];
      });
      return;
    }

    setState(() {
      _isOriginLoading = true;
    });

    try {
      final suggestions = await _placeService.getPlaceSuggestions(input);
      if (mounted) {
        setState(() {
          _originSuggestions = suggestions;
          _isOriginLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isOriginLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching suggestions: $e')),
        );
      }
    }
  }

  Future<void> _getDestinationSuggestions(String input) async {
    if (input.length < 2) {
      setState(() {
        _destinationSuggestions = [];
      });
      return;
    }

    setState(() {
      _isDestinationLoading = true;
    });

    try {
      final suggestions = await _placeService.getPlaceSuggestions(input);
      if (mounted) {
        setState(() {
          _destinationSuggestions = suggestions;
          _isDestinationLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDestinationLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching suggestions: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _originDebounce?.cancel();
    _destinationDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome to EasyGo
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade600, Colors.red.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Welcome to EasyGo!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 3.0,
                          color: Colors.black26,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Hello Supragya,',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Where would you like to go today?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 15),

              // Current Location Display
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Location',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _currentLocation,
                            style: TextStyle(color: Colors.red.shade800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Origin Search Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isOriginFocused = hasFocus;
                        if (!hasFocus) {
                          _originSuggestions = [];
                        } else if (_originController.text.length >= 2) {
                          _getOriginSuggestions(_originController.text);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _originController,
                        decoration: InputDecoration(
                          hintText: 'Search for origin',
                          prefixIcon: Icon(Icons.trip_origin,
                              color: Colors.red.shade700),
                          suffixIcon: _isOriginLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.red.shade700,
                                  ),
                                )
                              : _originController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _originController.clear();
                                        setState(() {
                                          _originSuggestions = [];
                                        });
                                      },
                                    )
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),

                  // Origin Suggestions
                  if (_originSuggestions.isNotEmpty && _isOriginFocused)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 5),
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _originSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = _originSuggestions[index];
                          return ListTile(
                            leading: Icon(Icons.location_on,
                                color: Colors.red.shade700),
                            title: Text(
                              suggestion.structuredFormatting.mainText,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              suggestion.structuredFormatting.secondaryText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              setState(() {
                                _originController.text = suggestion.description;
                                _originSuggestions = [];
                              });
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 15),

              // Destination Search Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {
                        _isDestinationFocused = hasFocus;
                        if (!hasFocus) {
                          _destinationSuggestions = [];
                        } else if (_destinationController.text.length >= 2) {
                          _getDestinationSuggestions(
                              _destinationController.text);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _destinationController,
                        decoration: InputDecoration(
                          hintText: 'Search for destination',
                          prefixIcon: Icon(Icons.location_on,
                              color: Colors.red.shade700),
                          suffixIcon: _isDestinationLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.red.shade700,
                                  ),
                                )
                              : _destinationController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _destinationController.clear();
                                        setState(() {
                                          _destinationSuggestions = [];
                                        });
                                      },
                                    )
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),

                  // Destination Suggestions
                  if (_destinationSuggestions.isNotEmpty &&
                      _isDestinationFocused)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(top: 5),
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _destinationSuggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = _destinationSuggestions[index];
                          return ListTile(
                            leading: Icon(Icons.location_on,
                                color: Colors.red.shade700),
                            title: Text(
                              suggestion.structuredFormatting.mainText,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              suggestion.structuredFormatting.secondaryText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              setState(() {
                                _destinationController.text =
                                    suggestion.description;
                                _destinationSuggestions = [];
                              });
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to RideSelection page when both fields are filled
                  if (_originController.text.isNotEmpty &&
                      _destinationController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RideSelectionPage(
                          origin: _originController.text,
                          destination: _destinationController.text,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please enter both origin and destination'),
                      ),
                    );
                  }
                  FocusScope.of(context).unfocus();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Find Rides'),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
