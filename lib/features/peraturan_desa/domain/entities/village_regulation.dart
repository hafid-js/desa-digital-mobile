class VillageRegulation {
  const VillageRegulation({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.author,
    required this.category,
    required this.thumbnailAsset,
    required this.pdfAsset,
  });

  final String id;
  final String title;
  final String description;

  final String date;
  final String author;
  final String category;

  final String thumbnailAsset;
  final String pdfAsset;
}
