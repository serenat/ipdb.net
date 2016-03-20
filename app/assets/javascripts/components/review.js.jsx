var PropTypes = React.PropTypes;

var ReviewContainer = React.createClass({
  getInitialState: function () {
    var comment = this.props.review.comment;
    var commentMode = comment ? 'show' : null;

    return {comment: this.props.review.comment, mode: 'show', commentMode: commentMode};
  },
  setShowCommentMode: function (e) {
    e.preventDefault();
    var mode = this.state.comment ? 'show' : 'null'
    this.setState({commentMode: mode});
  },
  setWriteCommentMode: function (e) {
    e.preventDefault();
    this.setState({commentMode: 'write'});
  },
  setEditCommentMode: function (e) {
    e.preventDefault();
    this.setState({commentMode: 'edit'});
  },
  setDeleteCommentMode: function (e) {
    e.preventDefault();
    this.setState({commentMode: 'delete'});
  },
  handleCommentSubmit: function (comment, verb) {
    var url = this.props.review.url + '/comment';
    $.ajax({
      url: url,
      dataType: 'json',
      type: verb,
      data: comment,
      success: function(data) {
        this.setState({comment: data, commentMode: 'show'});
      }.bind(this),
      error: function(xhr, status, err) {
        var mode = this.state.comment ? 'show' : null
        this.setState({commentMode: mode});
        console.error(url, status, err.toString());
      }.bind(this)
    });
  },
  handleCommentDelete: function () {
    var url = this.props.review.url + '/comment';
    $.ajax({
      url: url,
      dataType: 'json',
      type: 'DELETE',
      success: function(data) {
        this.setState({comment: null, commentMode: null});
      }.bind(this),
      error: function(xhr, status, err) {
        this.setState({commentMode: 'show'});
        console.error(url, status, err.toString());
      }.bind(this)
    });
  },
  render: function () {
    var host = (this.props.user && this.props.user.host) ? this.props.user : null;
    return (
      <div className="itunes-review-box">
        <Review review={this.props.review}/>

        <ReviewFooter
          host={host}
          comment={this.state.comment}
          setWriteCommentMode={this.setWriteCommentMode}/>

        <CommentBox
          comment={this.state.comment}
          host={host}
          mode={this.state.commentMode}
          handleCommentSubmit={this.handleCommentSubmit}
          handleCommentDelete={this.handleCommentDelete}
          setEditCommentMode={this.setEditCommentMode}
          setDeleteCommentMode={this.setDeleteCommentMode}
          setShowCommentMode={this.setShowCommentMode}/>
      </div>
    )
  }
});

function Review(props) {
  var commentedAtFormated = function () {
    return(moment(props.review.commented_at).format("MMMM D [at] h:mma"));
  }
  return (
    <div className="itunes-review">
      <header className="itunes-review__header">
        <h4 className="itunes-review__header__title">
          {props.review.title}
        </h4>
        <div className="right-side">
          <span className="date">{commentedAtFormated()}</span><br/>
          {props.review.itunes ?
            <span className="label label-default">itunes</span>
          : <span className="label label-ipdb">IPDb</span>
          }
        </div>
        <RatingBox rating={props.review.rating} />
      </header>
      <div className="itunes-review__author">
        by:{" "}
        {props.review.user ?
          <a href={props.review.user.profile_url}>{props.review.user.name}</a>
        : props.review.author
        }
      </div>
      <p className="itunes-review__content">
        {props.review.content}
      </p>
    </div>
  )
};

Review.propTypes = {
  review: PropTypes.object.isRequired
}

function RatingBox (props) {
  var ratingStars = Array(props.rating).fill(
    <i className="fa fa-star fa-15x"></i>
  );
  return (
    <div className="itunes-review__header__rating">
      {ratingStars}
    </div>
  )
};

RatingBox.propTypes = {
  rating: PropTypes.number.isRequired
}

function ReviewFooter (props) {
  var showCommentFormLink;
  if (props.host && props.host.membership == 'silver' && !props.comment) {
    showCommentFormLink = (
      <a title="Leave a comment" onClick={props.setWriteCommentMode}>
        <i className="fa fa-comment"></i> Comment
      </a>
    );
  };
  return (
    <div className="itunes-review-box__footer">
      {showCommentFormLink}
    </div>
  )
};

ReviewFooter.propTypes = {
  host: PropTypes.object,
  comment: PropTypes.object,
  setWriteCommentMode: PropTypes.func.isRequired
}
