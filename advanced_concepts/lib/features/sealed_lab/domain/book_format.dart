/// Lab-only formats. Not the API book entity or BookModel.
sealed class BookFormat {
  const BookFormat({required this.title, required this.author});

  final String title;
  final String author;
}

class Hardcover extends BookFormat {
  const Hardcover({
    required super.title,
    required super.author,
    required this.pages,
  });

  final int pages;
}

class Paperback extends BookFormat {
  const Paperback({
    required super.title,
    required super.author,
    required this.massMarket,
  });

  final bool massMarket;
}

class Ebook extends BookFormat {
  const Ebook({
    required super.title,
    required super.author,
    required this.megabytes,
  });

  final int megabytes;
}

const fourthWingHardcover = Hardcover(
  title: 'Fourth Wing',
  author: 'Rebecca Yarros',
  pages: 512,
);

const fourthWingPaperback = Paperback(
  title: 'Fourth Wing',
  author: 'Rebecca Yarros',
  massMarket: false,
);

const fourthWingEbook = Ebook(
  title: 'Fourth Wing',
  author: 'Rebecca Yarros',
  megabytes: 3,
);
