class PagedQuery {
  final int pageSize;
  final int page;
  final String searchTerm;
  final int order;
  final String sort;

  PagedQuery({
    this.pageSize,
    this.page,
    this.searchTerm,
    this.order = -1,
    this.sort = 'UpdatedAt',
  });

  Map<String, dynamic> toJson() {
    return {
      'pageSize': pageSize,
      'page': page,
      'searchTerm': searchTerm,
      'order': order,
      'sort': sort,
    };
  }
}
