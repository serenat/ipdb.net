var PropTypes = React.PropTypes;

var CommentBox = React.createClass({
  render: function () {
    var comment;
    switch(this.props.mode) {
      case 'show':
        comment =
          <CommentContainer
            comment={this.props.comment}
            host={this.props.host}
            setEditCommentMode={this.props.setEditCommentMode}
            setDeleteCommentMode={this.props.setDeleteCommentMode}/>;
        break;
      case 'write':
        comment =
          <CommentFormContainer
            host={this.props.host}
            handleCommentSubmit={this.props.handleCommentSubmit}
            setShowCommentMode={this.props.setShowCommentMode}
            httpVerb={'POST'}/>;
        break;
      case 'edit':
        comment =
          <CommentFormContainer
            host={this.props.host}
            comment={this.props.comment}
            handleCommentSubmit={this.props.handleCommentSubmit}
            setShowCommentMode={this.props.setShowCommentMode}
            httpVerb={'PUT'}/>;
        break;
      case 'delete':
        comment =
          <CommentDeleteForm
            handleCommentDelete={this.props.handleCommentDelete}
            setShowCommentMode={this.props.setShowCommentMode}/>;
    }
    return (
      <div className="ir-comment-box">
        {comment}
      </div>
    )
  }
});

var CommentContainer = React.createClass({
  render: function () {
    return (
      <div className="ir-comment">
        <div className="ir-comment__avatar">
          <UserProfileLink comment={this.props.comment}>
            <img src={this.props.comment.user_profile_image}/>
          </UserProfileLink>
        </div>
        <div className="ir-comment__name">
          <UserProfileLink comment={this.props.comment}>
            {this.props.comment.user_name}
          </UserProfileLink>
        </div>
        <div className="ir-comment__content">
          {this.props.comment.content}
        </div>
        <CommentFooter
          comment={this.props.comment}
          host={this.props.host}
          handleEdit={this.props.setEditCommentMode}
          handleDelete={this.props.setDeleteCommentMode}/>
      </div>
    )
  }
});

var CommentFooter = React.createClass({
  getInitialState: function () {
    return {availableTimeLeft: null};
  },
  getTimeLeft: function () {
    var delta = 900000;
    var createdAt = Date.parse(this.props.comment.created_at);
    var timeNow = Date.now();
    return(delta + createdAt - timeNow);
  },
  updateAvailableTimeLeft: function () {
    var timeLeft = this.getTimeLeft();
    if (timeLeft > 0) {
      this.setState({availableTimeLeft: moment.duration(timeLeft).humanize()});
      return true;
    } else {
      this.setState({availableTimeLeft: null});
      return false;
    }
  },
  componentDidMount: function () {
    if (this.updateAvailableTimeLeft()) {
      this._availableTimeInterval = setInterval(function() {
        if (!this.updateAvailableTimeLeft()) {
          clearInterval(this._availableTimeInterval);
        }
      }.bind(this), 10000);
    }
  },
  componentWillUnmount: function () {
    clearInterval(this._availableTimeInterval);
  },
  commentedAtFormated: function () {
    return(moment(this.props.comment.created_at).format("MMMM D [at] h:mma"));
  },
  render: function () {

    var comment = this.props.comment;
    var host = this.props.host;
    var links;

    if (comment && host && (host.membership == 'silver') && (comment.user_id == host.id)) {
      links = (
        <span>
          <a title="Edit comment" onClick={this.props.handleEdit}>Edit</a>
          <span> or </span>
          <a title="Delete comment" onClick={this.props.handleDelete}>Delete</a>
          {' '}
          <span className="time-left">for {this.state.availableTimeLeft}</span>
        </span>
      );
    }

    return (
      <div className="ir-comment__footer">
        {this.state.availableTimeLeft ?
          links
        : this.commentedAtFormated()
        }
      </div>
    )
  }
});

function UserProfileLink (props) {
  return (
    <a href={props.comment.user_profile_url} title={props.comment.user_name}>
      {props.children}
    </a>
  )
};

var CommentFormContainer = React.createClass({
  getInitialState: function () {
    var content = this.props.comment
      ? this.props.comment.content
      : ""
    return {content: content};
  },
  componentDidMount: function () {
    $(this.refs.textarea).expanding().focus();
  },
  handleContentChange: function (e) {
    this.setState({content: e.target.value});
  },
  handleSubmit: function (e) {
    e.preventDefault();
    var content = this.state.content.trim();
    if (!content) {
      return;
    }
    this.props.handleCommentSubmit({comment: {content: content}}, this.props.httpVerb);
    this.setState({content: ''});
  },
  handleFocus: function (e) {
    var caret = e.target.value.length;
    this.refs.textarea.setSelectionRange(caret,caret);
  },
  render: function () {
    return (
      <div className="ir-comment-form">
        <form onSubmit={this.handleSubmit}>
          <div className="ir-comment-form__avatar">
            <img src={this.props.host.profile_image}/>
          </div>
          <div className="ir-comment-form__input">
            <textarea
              ref= "textarea"
              value={this.state.content}
              onChange={this.handleContentChange}
              rows="1"
              placeholder="Write a comment..."
              onFocus={this.handleFocus}>
            </textarea>
          </div>
          <div className="ir-comment-form__buttons">
            <button
              className="btn btn-xs btn-default"
              onClick={this.props.setShowCommentMode}>
              Cancel
            </button>
            <button
              type="submit"
              className="btn btn-xs btn-primary"
              disabled={!this.state.content}>
              Submit
            </button>
          </div>
        </form>
      </div>
    )
  }
});

var CommentDeleteForm = React.createClass({
  handleSubmit: function (e) {
    e.preventDefault();
    this.props.handleCommentDelete();
  },
  render: function () {
    return (
      <div className="ir-comment-delete text-center">
        <form onSubmit={this.handleSubmit}>
          <h3>Delete comment?</h3>
          <div className="ir-comment-delete__buttons">
            <button
              className="btn btn-xs btn-default"
              onClick={this.props.setShowCommentMode}>
              Cancel
            </button>
            <button
              type="submit"
              className="btn btn-xs btn-primary">
              Delete
            </button>
          </div>
        </form>
      </div>
    )
  }
});