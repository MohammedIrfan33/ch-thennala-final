import 'package:flutter/material.dart';



class MyAppnew extends StatelessWidget {
  const MyAppnew({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchDropdownScreen(),
    );
  }
}

class SearchDropdownScreen extends StatefulWidget {
  const SearchDropdownScreen({super.key});

  @override
  _SearchDropdownScreenState createState() => _SearchDropdownScreenState();
}

class _SearchDropdownScreenState extends State<SearchDropdownScreen> {
  List<String> allItems = [
    "Apple", "Banana", "Cherry", "Date", "Elderberry",
    "Fig", "Grapes", "Honeydew", "Kiwi", "Lemon"
  ];
  List<String> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  OverlayEntry? overlayEntry;
  final LayerLink layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems);

    // Show dropdown when the TextField gets focus
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        showDropdown();
      } else {
        hideDropdown();
      }
    });
  }

  void filterSearch(String query) {
    setState(() {
      filteredItems = query.isEmpty
          ? List.from(allItems)
          : allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });

    // Update dropdown when filtering
    if (searchFocusNode.hasFocus) {
      showDropdown();
    }
  }

  void showDropdown() {
    hideDropdown(); // Remove existing overlay before creating a new one
    final overlay = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width
        child: CompositedTransformFollower(
          link: layerLink,
          offset: Offset(0, 55), // Position below TextField
          child: Material(
            elevation: 1.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              // Limit dropdown height
              child: Wrap(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index],style: TextStyle(fontSize: 14),),
                        onTap: () => selectItem(filteredItems[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  void hideDropdown() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void selectItem(String selectedItem) {
    setState(() {
      searchController.text = selectedItem;
      hideDropdown();
    });
    FocusScope.of(context).unfocus(); // Close keyboard
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    hideDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Dropdown Search")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CompositedTransformTarget(
              link: layerLink,
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(

                  hintText: "Type to search...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                        filterSearch(""); // Show all items again
                      });
                    },
                  )
                      : null,
                ),
                onChanged: filterSearch,
              ),
            ),
          ],
        ),
      ),
    );
  }







}









