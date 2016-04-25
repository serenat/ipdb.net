var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var EpisodeList = React.createClass({
  getInitialState: function () {
    return { activePage: 1 };
  },
  handlePageChange: function (pageNumber) {
    this.setState({activePage: pageNumber});
    $("body").animate({scrollTop:0});
  },
  render: function () {
    var cursor = (this.state.activePage - 1) * 10;
    var episodeNodes = this.props.episodes.slice(cursor, cursor + 10).map(function(episode) {
      return (<Episode episode={episode} key={episode.entry_id}/>)
    });
    return (
      <div className="episode-list">
        <ReactCSSTransitionGroup
          transitionName="episode-transition"
          transitionEnterTimeout={700}
          transitionLeaveTimeout={200}>
          {episodeNodes}
        </ReactCSSTransitionGroup>
        <Pagination
          className="episode-list__pagination"
          activePage={this.state.activePage}
          totalItemsCount={this.props.episodes.length}
          onChange={this.handlePageChange}
        />
      </div>
    )
  }
});
