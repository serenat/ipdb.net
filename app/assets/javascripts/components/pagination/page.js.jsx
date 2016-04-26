var Page = React.createClass({
  propTypes: {
    pageText: PropTypes.oneOfType([
        PropTypes.string,
        PropTypes.element
    ]),
    pageNumber: PropTypes.number.isRequired,
    onClick: PropTypes.func.isRequired,
    isActive: PropTypes.bool.isRequired
  },
  onClick: function (e) {
    e.preventDefault();
    this.props.onClick(this.props.pageNumber);
  },
  render: function () {
    var className;
    if (this.props.isActive) {
      className = "active";
    }

    var text = this.props.pageText || this.props.pageNumber;
    if (React.isValidElement(text)) {
      return text;
    }

    return (
      <li className={className}>
        <a onClick={this.onClick} href="#">
          { text }
        </a>
      </li>
    );
  }
});
