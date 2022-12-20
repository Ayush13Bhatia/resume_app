class Query {
  static const int dbVersion = 1;

  static const String resumeTable = 'person';

  static const String createResumeTable = '''CREATE TABLE `$resumeTable`(
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT,
  `gender` TEXT,
  `age` INTEGER,
  `currentCTC` TEXT,
  `expectedCTC` TEXT, 
  `image` TEXT,
  `resumePdf` TEXT,
  `createTime` TEXT,
  `skills` TEXT
  )''';
}
