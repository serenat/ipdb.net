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

function Episode (props){
  var media;
  if (/^video/.test(props.episode.source_type)) {
    media = (
      <video width="100%" controls preload="none" type={props.episode.source_type}>
        <source src={props.episode.source}/>
          Your browser does not support the video element.
      </video>
    )
  } else {
    media = (
      <audio controls preload="none">
        <source src={props.episode.source} type={props.episode.source_type}/>
          Your browser does not support the audio element.
      </audio>
    )
  }

  var publishedFormated = function () {
    return(moment(props.episode.published).format("MMMM D, YYYY"));
  }

  return (
    <div className="episode">
      <div className="episode__header">
        <span className="episode__title">{props.episode.title}</span>
        <span className="episode__date">{publishedFormated()}</span>
      </div>
      <div className="episode__description">
        <p>{props.episode.description}</p>
      </div>

      {media}

      <div className="episode__download">
        <a href={props.episode.source} className="pull-right" target="_blank" download>
          <i className="fa fa-download"></i> Download
        </a>
      </div>
    </div>
  )
};
