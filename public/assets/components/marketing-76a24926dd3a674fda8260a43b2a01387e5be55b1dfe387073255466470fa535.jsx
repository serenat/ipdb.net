var Marketing = React.createClass({
  isBasicHost: function () {
    var user = this.props.user;
    return(user && user.host && user.membership == 'basic');
  },
  isGuest: function () {
    return(!this.props.user);
  },
  render: function () {
    return (
      <div className="itunes-review-list__ad">
        {this.isBasicHost() &&
          <a className="btn btn-block btn-default" href="/profile/subscription">
            Become a silver member to reply to a review
          </a>
        }
        {this.isGuest() &&
          <a href="/pricing" className="btn btn-block btn-default">
            Sign up to write a review
          </a>
        }
      </div>
    );
  }
});
