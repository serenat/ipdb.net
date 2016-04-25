function Episode (props){
  var media;
  if (/^video/.test(props.episode.source_type)) {
    media = (
      <video width="100%"
        controls
        preload="none"
        type={props.episode.source_type}
        poster="/assets/video-poster-dc4fb01474aafa06155b02ce9f529f4d3bbb6724b684e93a00b7c4ba70f93a48.png">
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
