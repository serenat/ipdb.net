var ReviewFormContainer = React.createClass({
  getInitialState: function () {
    return {showForm: false};
  },
  handleShowForm: function () {
    this.setState({showForm: true});
  },
  handleCloseForm: function () {
    this.setState({showForm: false});
  },
  render: function () {
    return (
      <div>
        {this.state.showForm ?
          <ReviewForm
            handleReviewSubmit={this.props.handleReviewSubmit}
            handleCloseForm={this.handleCloseForm}/>
        : <button
            className="btn btn-primary review-form-show-btn"
            onClick={this.handleShowForm}>
            Write a review
          </button>
        }
      </div>
    );
  }
});

var ReviewForm = React.createClass({
  getInitialState: function () {
    return {rating: 0, hovered: 0, title: '', content: ''};
  },
  handleContentChange: function (e) {
    this.setState({content: e.target.value});
  },
  handleTitleChange: function (e) {
    this.setState({title: e.target.value});
  },
  handleRatingChange: function (e) {
    this.setState({rating: e.target.value});
  },
  handleSubmit: function(e) {
    e.preventDefault();
    var content = this.state.content.trim();
    var title = this.state.title.trim();
    var rating = this.state.rating;
    if (!content || !title || (rating == 0)) {
      return;
    }
    this.setState({rating: 0, hovered: 0, title: '', content: ''});
    this.props.handleReviewSubmit({review: {rating: rating, title: title, content: content}});
  },
  handleHover: function (e) {
    var input = e.target.parentNode.parentNode.querySelector('input');
    this.setState({hovered: input.value});
  },
  handleUnHover: function (e) {
    this.setState({hovered: this.state.rating});
  },
  render: function () {
    return (
      <div className="review-form">
        <form className="" onSubmit={this.handleSubmit}>
          <div className="review-form__header">
            <h3>Write a review</h3>
          </div>
          <div className="review-form__body">
            <div className="form-group">
              <label>Rating:</label>
              <span className="required-asterisk">*</span>
              <RatingInputBox
                hovered={this.state.hovered}
                handleRatingChange={this.handleRatingChange}
                handleHover={this.handleHover}
                handleUnHover={this.handleUnHover}
              />
            </div>
            <div className="form-group title">
              <label>Title:</label>
              <span className="required-asterisk">*</span><br/>
              <input
                type="text"
                maxLength="35"
                required={true}
                value={this.state.title}
                onChange={this.handleTitleChange}/>
            </div>
            <ContentInput content={this.state.content} handleChange={this.handleContentChange}/>
          </div>
          <ReviewFormFooter
            content={this.state.content}
            title={this.state.title}
            rating={this.state.rating}
            handleCloseForm={this.props.handleCloseForm}/>
        </form>
      </div>
    )
  }
});

function RatingInputBox (props) {
  var inputStars = [1,2,3,4,5].map (function (value) {
    var id = "rating_" + value;
    var starStyle = (value <= props.hovered) ? {color: 'goldenrod'} : null;
    return (
      <span className="intput-rating-star" key={id}>
        <input type="radio" value={value} id={id} name="rating" onChange={props.handleRatingChange}/>
        <label htmlFor={id}>
          <i
            className="fa fa-star"
            style={starStyle}
            onMouseEnter={props.handleHover}
            onMouseLeave={props.handleUnHover}>
          </i>
        </label>
      </span>
    );
  });
  return (
    <div className="input-rating-box">
      {inputStars}
    </div>
  );
};

var ContentInput = React.createClass({
  componentDidMount: function () {
    $(this.refs.textarea).expanding();
  },
  overflowAlert: function () {
    if (this.props.content.length > 300) {
      var beforeOverflowText = this.props.content.substring(300 - 10, 300);
      var overflowText = this.props.content.substring(300);

      return (
        <div className="alert alert-warning">
          <strong>Oops! Too Long:</strong>
          &nbsp;...{beforeOverflowText}
          <strong className="bg-danger">{overflowText}</strong>
        </div>
      );
    } else {
      return "";
    }
  },
  render: function () {
    return (
      <div className="form-group">
        <label>Review:</label>
        <span className="required-asterisk">*</span>
        <span>(Maximum 300 characters)</span>
        { this.overflowAlert() }
        <textarea
          ref="textarea"
          required={true}
          value={this.props.content}
          onChange={this.props.handleChange}
          rows="5">
        </textarea>
      </div>
    );
  }
});

function ReviewFormFooter (props) {
  var charsLeftStyle = (props.content.length > 290) ? {color: 'red'} : null;
  var handleClickCLose = function (e) {
    e.preventDefault();
    props.handleCloseForm();
  };
  var isSubmitBtnDisabled = function () {
    return(!(props.rating && props.title && props.content && props.content.length <= 300));
  };
  return (
    <div className="review-form__footer">
      <span style={charsLeftStyle}>
        {300 - props.content.length}
      </span>
      <button
        type="submit"
        className="btn btn-xs btn-primary"
        disabled={isSubmitBtnDisabled()}>
        Submit
      </button>
      <button
        className="btn btn-xs btn-default"
        onClick={handleClickCLose}>
        Cancel
      </button>
    </div>
  )
};
