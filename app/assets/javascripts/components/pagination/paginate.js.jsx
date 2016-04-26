var Pagination = React.createClass({
  propTypes: {
    totalItemsCount: PropTypes.number.isRequired,
    onChange: PropTypes.func.isRequired,
    activePage: PropTypes.number,
    pageRangeDisplayed: PropTypes.number,
    itemsCountPerPage: PropTypes.number,
    prevPageText: PropTypes.oneOfType([
      PropTypes.string,
      PropTypes.element
    ]),
    nextPageText: PropTypes.oneOfType([
      PropTypes.string,
      PropTypes.element
    ]),
    lastPageText: PropTypes.oneOfType([
      PropTypes.string,
      PropTypes.element
    ]),
    firstPageText: PropTypes.oneOfType([
      PropTypes.string,
      PropTypes.element
    ])
  },

  getDefaultProps: function () {
    return {
      itemsCountPerPage: 10,
      pageRangeDisplayed: 5,
      activePage: 1,
      prevPageText: "⟨",
      firstPageText: "«",
      nextPageText: "⟩",
      lastPageText: "»",
    }
  },

  onClick: function (page) {
    this.props.onChange(page);
  },

  buildPages: function () {
    var pages = [];

    const {
        itemsCountPerPage,
        pageRangeDisplayed,
        activePage,
        prevPageText,
        nextPageText,
        firstPageText,
        lastPageText,
        totalItemsCount
    } = this.props;

    var paginationInfo = new Paginator(itemsCountPerPage, pageRangeDisplayed)
      .build(totalItemsCount, activePage);

    if (paginationInfo.first_page !== paginationInfo.last_page) {
      for(i = paginationInfo.first_page; i <= paginationInfo.last_page; i++) {
        pages.push(
          <Page
            isActive={i === activePage}
            key={i}
            pageNumber={i}
            onClick={this.onClick}
          />
        );
      }
    }

    paginationInfo.has_previous_page && pages.unshift(
      <Page
        isActive={false}
        key={"prev" + paginationInfo.previous_page}
        pageNumber={paginationInfo.previous_page}
        onClick={this.onClick}
        pageText={prevPageText}
      />
    );

    paginationInfo.first_page > 1 && pages.unshift(
      <Page
        isActive={false}
        key={1}
        pageNumber={1}
        onClick={this.onClick}
        pageText={firstPageText}
      />
    );

    paginationInfo.has_next_page && pages.push(
      <Page
        isActive={false}
        key={"next" + paginationInfo.next_page}
        pageNumber={paginationInfo.next_page}
        onClick={this.onClick}
        pageText={nextPageText}
      />
    );

    paginationInfo.last_page !== paginationInfo.total_pages && pages.push(
      <Page
        isActive={false}
        key={paginationInfo.total_pages}
        pageNumber={paginationInfo.total_pages}
        onClick={this.onClick}
        pageText={lastPageText}
      />
    );

    return pages;
  },

  render: function () {
    var pages = this.buildPages();
    return (
      <ul className="pagination">{pages}</ul>
    );
  }
});
