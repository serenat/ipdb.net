-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ipdb_net_development
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_admin_comments`
--

DROP TABLE IF EXISTS `active_admin_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_admin_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) DEFAULT NULL,
  `body` text,
  `resource_id` varchar(255) NOT NULL,
  `resource_type` varchar(255) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`),
  KEY `index_active_admin_comments_on_resource_type_and_resource_id` (`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `commentable_id` int(11) DEFAULT NULL,
  `commentable_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commontator_comments`
--

DROP TABLE IF EXISTS `commontator_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commontator_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` int(11) DEFAULT NULL,
  `thread_id` int(11) NOT NULL,
  `body` text NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `cached_votes_total` int(11) DEFAULT '0',
  `cached_votes_up` int(11) DEFAULT '0',
  `cached_votes_down` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_c_c_on_c_id_and_c_type_and_t_id` (`creator_id`,`creator_type`,`thread_id`),
  KEY `index_commontator_comments_on_thread_id` (`thread_id`),
  KEY `index_commontator_comments_on_cached_votes_total` (`cached_votes_total`),
  KEY `index_commontator_comments_on_cached_votes_up` (`cached_votes_up`),
  KEY `index_commontator_comments_on_cached_votes_down` (`cached_votes_down`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commontator_subscriptions`
--

DROP TABLE IF EXISTS `commontator_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commontator_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscriber_type` varchar(255) NOT NULL,
  `subscriber_id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `unread` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_c_s_on_s_id_and_s_type_and_t_id` (`subscriber_id`,`subscriber_type`,`thread_id`),
  KEY `index_commontator_subscriptions_on_thread_id` (`thread_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commontator_threads`
--

DROP TABLE IF EXISTS `commontator_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commontator_threads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commontable_type` varchar(255) DEFAULT NULL,
  `commontable_id` int(11) DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `closer_type` varchar(255) DEFAULT NULL,
  `closer_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_c_t_on_c_id_and_c_type` (`commontable_id`,`commontable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=100313 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `follows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `followable_id` int(11) NOT NULL,
  `followable_type` varchar(255) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `follower_type` varchar(255) NOT NULL,
  `blocked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_follows` (`follower_id`,`follower_type`),
  KEY `fk_followables` (`followable_id`,`followable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pg_search_documents`
--

DROP TABLE IF EXISTS `pg_search_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pg_search_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `searchable_id` int(11) DEFAULT NULL,
  `searchable_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `podcast_searches`
--

DROP TABLE IF EXISTS `podcast_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `podcast_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `podcasts`
--

DROP TABLE IF EXISTS `podcasts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `podcasts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` text,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `episodes` varchar(255) DEFAULT NULL,
  `pcaward` tinyint(1) DEFAULT '0',
  `pcaward2` tinyint(1) DEFAULT '0',
  `pcaward3` tinyint(1) DEFAULT '0',
  `explicit` tinyint(1) DEFAULT '0',
  `category` varchar(255) DEFAULT NULL,
  `guest_id` int(11) DEFAULT NULL,
  `cohost_id` int(11) DEFAULT NULL,
  `ppff` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_podcasts_on_user_id` (`user_id`),
  KEY `index_podcasts_on_guest_id` (`guest_id`),
  KEY `index_podcasts_on_cohost_id` (`cohost_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100313 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) DEFAULT NULL,
  `rateable_id` int(11) DEFAULT NULL,
  `rateable_type` varchar(255) DEFAULT NULL,
  `stars` float NOT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rates_on_rater_id` (`rater_id`),
  KEY `index_rates_on_rateable_id_and_rateable_type` (`rateable_id`,`rateable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_caches`
--

DROP TABLE IF EXISTS `rating_caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_caches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheable_id` int(11) DEFAULT NULL,
  `cacheable_type` varchar(255) DEFAULT NULL,
  `avg` float NOT NULL,
  `qty` int(11) NOT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rating_caches_on_cacheable_id_and_cacheable_type` (`cacheable_id`,`cacheable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `description` text,
  `profile_image_file_name` varchar(255) DEFAULT NULL,
  `profile_image_content_type` varchar(255) DEFAULT NULL,
  `profile_image_file_size` int(11) DEFAULT NULL,
  `profile_image_updated_at` datetime DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `pinterest` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `about` text,
  `work` text,
  `education` text,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `votable_id` int(11) DEFAULT NULL,
  `votable_type` varchar(255) DEFAULT NULL,
  `voter_id` int(11) DEFAULT NULL,
  `voter_type` varchar(255) DEFAULT NULL,
  `vote_flag` tinyint(1) DEFAULT NULL,
  `vote_scope` varchar(255) DEFAULT NULL,
  `vote_weight` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_votes_on_voter_id_and_voter_type_and_vote_scope` (`voter_id`,`voter_type`,`vote_scope`),
  KEY `index_votes_on_votable_id_and_votable_type_and_vote_scope` (`votable_id`,`votable_type`,`vote_scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-06-10 20:19:20
INSERT INTO schema_migrations (version) VALUES ('20140214034338');

INSERT INTO schema_migrations (version) VALUES ('20140214035456');

INSERT INTO schema_migrations (version) VALUES ('20140214040826');

INSERT INTO schema_migrations (version) VALUES ('20140217003704');

INSERT INTO schema_migrations (version) VALUES ('20140217004012');

INSERT INTO schema_migrations (version) VALUES ('20140217084049');

INSERT INTO schema_migrations (version) VALUES ('20140220194813');

INSERT INTO schema_migrations (version) VALUES ('20140220195524');

INSERT INTO schema_migrations (version) VALUES ('20140220195915');

INSERT INTO schema_migrations (version) VALUES ('20140224183114');

INSERT INTO schema_migrations (version) VALUES ('20140224212131');

INSERT INTO schema_migrations (version) VALUES ('20140225001531');

INSERT INTO schema_migrations (version) VALUES ('20140225003903');

INSERT INTO schema_migrations (version) VALUES ('20140225185300');

INSERT INTO schema_migrations (version) VALUES ('20140225185301');

INSERT INTO schema_migrations (version) VALUES ('20140226184621');

INSERT INTO schema_migrations (version) VALUES ('20140226184627');

INSERT INTO schema_migrations (version) VALUES ('20140227185004');

INSERT INTO schema_migrations (version) VALUES ('20140307004831');

INSERT INTO schema_migrations (version) VALUES ('20140310203735');

INSERT INTO schema_migrations (version) VALUES ('20140311164851');

INSERT INTO schema_migrations (version) VALUES ('20140311204530');

INSERT INTO schema_migrations (version) VALUES ('20140319205136');

INSERT INTO schema_migrations (version) VALUES ('20140331164407');

INSERT INTO schema_migrations (version) VALUES ('20140331164852');

INSERT INTO schema_migrations (version) VALUES ('20140415191632');

INSERT INTO schema_migrations (version) VALUES ('20140415193627');

INSERT INTO schema_migrations (version) VALUES ('20140417211537');

INSERT INTO schema_migrations (version) VALUES ('20140417213010');

INSERT INTO schema_migrations (version) VALUES ('20140423214856');

INSERT INTO schema_migrations (version) VALUES ('20140423215259');

INSERT INTO schema_migrations (version) VALUES ('20140522211655');

INSERT INTO schema_migrations (version) VALUES ('20140529174643');

INSERT INTO schema_migrations (version) VALUES ('20140610201618');
