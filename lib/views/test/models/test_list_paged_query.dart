import 'package:vecandx/core/models/paged_query.dart';

class TestListPagedQuery extends PagedQuery {
  final DateTime collectionDateFrom;
  final DateTime collectionDateTo;
  final DateTime testDateFrom;
  final DateTime testDateTo;

  TestListPagedQuery({
    pageSize,
    page,
    searchTerm,
    this.collectionDateFrom,
    this.collectionDateTo,
    this.testDateFrom,
    this.testDateTo,
  }) : super(page: page, pageSize: pageSize, searchTerm: searchTerm);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'collectionDateFrom': collectionDateFrom,
      'collectionDateTo': collectionDateTo,
      'testDateFrom': testDateFrom,
      'testDateTo': testDateTo,
    });
    return json;
  }
}
