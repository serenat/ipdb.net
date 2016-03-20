var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var ReviewList = React.createClass({
  getInitialState: function () {
    return {reviews: [], showReviewForm: false, filter: 'all'};
  },
  loadReviewPermissions: function () {
    var url = this.props.url + "/new"
    $.ajax({
      url: url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({showReviewForm: true});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(url, status, err.toString());
      }.bind(this)
    });
  },
  loadReviewsFromServer: function(options) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      data: options,
      cache: false,
      success: function(data) {
        this.setState({reviews: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  componentDidMount: function () {
    this.loadReviewsFromServer();
    this.loadReviewPermissions();
  },
  loadMore: function () {
    var quantity = this.state.reviews.length + 10;
    this.loadReviewsFromServer({quantity: quantity, filter: this.state.filter});
  },
  handleReviewSubmit: function (review) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: review,
      success: function(review) {
        var reviews = this.state.reviews;
        review.id = Date.now();
        reviews.unshift(review);
        this.setState({reviews: reviews, showReviewForm: false});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  handleFilterChange: function (filterValue) {
    this.setState({filter: filterValue});
    var quantity = this.state.reviews.length;
    if (quantity == 0) { quantity = 10 };
    this.loadReviewsFromServer({quantity: quantity, filter: filterValue});
  },
  render: function () {
    var reviewNodes = this.state.reviews.map(function(review) {
      return (
        <ReviewContainer
          review={review}
          user={this.props.user}
          key={review.id}/>
      )
    }.bind(this));

    return (
      <div className="itunes-review-list">
        <Marketing user={this.props.user}/>
        <ReactCSSTransitionGroup
          transitionName="review-transition"
          transitionEnter={false}
          transitionLeaveTimeout={200}>

          {this.state.showReviewForm &&
            <ReviewFormContainer handleReviewSubmit={this.handleReviewSubmit} key={Date.now}/>
          }

        </ReactCSSTransitionGroup>

        <ReviewListFilters handleFilterChange={this.handleFilterChange} currentFilter={this.state.filter}/>
        {reviewNodes.length > 0 ?
          [
            <ReactCSSTransitionGroup
              transitionName="review-transition"
              transitionEnterTimeout={700}
              transitionLeaveTimeout={200}>

              {reviewNodes}

            </ReactCSSTransitionGroup>
          ]
        : <div className="no-reviews"><span>No reviews published yet</span></div>
        }

        {reviewNodes.length >= 10 &&
          <button
            className="btn btn-lg btn-default center-block load-more"
            onClick={this.loadMore}>
            Load more
          </button>
        }
      </div>
    )
  }
});

var ReviewListFilters = React.createClass({
  handleChange: function (e) {
    this.props.handleFilterChange(e.target.value);
  },
  render: function () {
    var filters = ['All', 'IPDb', 'Itunes'].map(function (filterName) {
      var filterValue = filterName.toLowerCase();
      return (
        <label className="radio-inline" key={filterValue}>
          <input
            type="radio"
            value={filterValue}
            name="filter"
            checked={this.props.currentFilter == filterValue}
            onChange={this.handleChange}/>
          {filterName}
        </label>
      );
    }.bind(this));
    return (
      <div className="review-filters">
        {filters}
      </div>
    );
  }
});
