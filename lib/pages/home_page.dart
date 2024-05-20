import 'package:flutter/material.dart';
import 'package:library_app/language_provider.dart';
import 'package:library_app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  String _searchQuery = '';
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadBooks();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _loadBooks() async {
    // Created books
    setState(() {
      _books = [
        Book(title: 'Hamlet', author: 'William Shakespeare', isAvailable: true),
        Book(
            title: 'One Hundred Years of Solitude',
            author: 'Gabriel García Márquez',
            isAvailable: false),
        Book(
            title: 'The Brothers Karamazov',
            author: 'Fyodor Dostoevsky',
            isAvailable: true),
        Book(title: 'Idiot', author: 'Fyodor Dostoevsky', isAvailable: true),
        Book(title: 'Anna Karerina', author: 'Leo Tolstoy', isAvailable: true),
        Book(
            title: 'Notes From the Underground',
            author: 'Fyodor Dostoevsky',
            isAvailable: true),
        Book(title: 'Animal Farm', author: 'George Orwell', isAvailable: false),
        Book(
            title: 'Pride and Prejudice',
            author: 'Jane Austen',
            isAvailable: false),
        Book(
            title: 'Arguably: Selected Essays',
            author: 'Christopher Hitchens',
            isAvailable: true),
        Book(
            title: 'India after Gandhi',
            author: 'Ramachandra Guha',
            isAvailable: false),
        Book(
            title: 'A Tale for the Time Being',
            author: 'Ruth Ozeki',
            isAvailable: true),
      ];
    });
  }

  //search method
  List<Book> _searchBooks(String query) {
    if (query.isEmpty) {
      return _books;
    }
    return _books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // function to mark whether the book is available or not
  void _toggleAvailability(Book book, bool? value) {
    setState(() {
      book.isAvailable = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          languageProvider.getText('home_title'),
          style: TextStyle(fontSize: 36),
        ),
        actions: [
          // toggle button for switching between dark and light mode
          Switch(
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          // icon to route to profile page
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 8, right: 14),
            child: IconButton(
              icon: Icon(Icons.person, size: 38),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            // search bar
            TextField(
              decoration: InputDecoration(
                labelText: languageProvider.getText('search_books'),
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2.0,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: 30),
            // list of books
            Expanded(
              child: ListView.builder(
                itemCount: _searchBooks(_searchQuery).length,
                itemBuilder: (context, index) {
                  Book book = _searchBooks(_searchQuery)[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        book.title,
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(book.author,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'CedarvilleCursive',
                              )),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                book.isAvailable
                                    ? languageProvider.getText('available')
                                    : languageProvider.getText('not_available'),
                                style: TextStyle(
                                  color: book.isAvailable
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Checkbox(
                                value: book.isAvailable,
                                onChanged: (value) =>
                                    _toggleAvailability(book, value),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  bool isAvailable;

  Book({
    required this.title,
    required this.author,
    required this.isAvailable,
  });
}
