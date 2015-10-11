class CalculateScoresJob < ActiveJob::Base
  queue_as :default

  class PodcastWithRating < Podcast
    has_one :rating_cache, as: :cacheable
  end

  def perform()
    # h   - hits
    # uh  - unique hits
    # d   - downloads
    # ud  - unique downloads
    # sh  - shares
    # ush - unique shares

    # s   - stars
    # ir  - itunes rating
    # irn - itunes rating normolized
    # irc - itunes review count

    h_min,  h_range  = get_min_and_range(:hits)
    uh_min, uh_range = get_min_and_range(:unique_hits)

    d_min,  d_range  = get_min_and_range(:downloads)
    ud_min, ud_range = get_min_and_range(:unique_downloads)

    sh_min,  sh_range  = get_min_and_range(:shares)
    ush_min, ush_range = get_min_and_range(:unique_shares)

    irc_min, irc_range = get_min_and_range(:itunes_review_count)

    time_from = Time.zone.now.beginning_of_day

    podcasts_with_rating =
      PodcastWithRating
        .joins("LEFT JOIN podcast_stats as s ON podcasts.id = s.podcast_id")
        .joins("LEFT JOIN rating_caches as r ON podcasts.id = r.cacheable_id")
        .where("s.updated_at >= ? OR r.updated_at >= ?", time_from, time_from)
        .includes(:rating_cache, :podcast_stat)

    podcasts_with_rating.find_each do |p|
      h, uh, d, ud, sh, ush, s, ir, irc = 0, 0, 0, 0, 0, 0, 0, 0, 0

      if ps = p.podcast_stat
        h  = scale(ps.hits, h_min, h_range)
        uh = scale(ps.unique_hits, uh_min, uh_range)

        d  = scale(ps.downloads, d_min, d_range)
        ud = scale(ps.unique_downloads, ud_min, ud_range)

        sh  = scale(ps.shares, sh_min, sh_range)
        ush = scale(ps.unique_shares, ush_min, ush_range)

        ir = ps.itunes_rating
        irc = scale(ps.itunes_review_count, irc_min, irc_range)
      end

      if p.rating_cache
        s = p.rating_cache.avg
      end

      # fh  - final hits
      # fd  - final downloads
      # fsh - final shares
      # fir - final itunes rating

      fh  = 5.0 * (h  * uh  + uh)  / 2.0
      fd  = 5.0 * (d  * ud  + ud)  / 2.0
      fsh = 5.0 * (sh * ush + ush) / 2.0

      fir = (ir * irc + ir) / 2.0

      p.score = (((fh + fd + fsh + s) / 4.0) + fir ) / 2.0
      p.save!
    end
  end

  private
  #Feature scaling
  def scale(val, min, range)
    if (val > 0) && (range > 0)
      (val - min).to_f / range
    else
      0
    end
  end

  def get_min_and_range(key)
    min = PodcastStat.order("#{key} ASC").first.public_send(key)
    max = PodcastStat.order("#{key} DESC").first.public_send(key)
    [min, max - min]
  end
end
