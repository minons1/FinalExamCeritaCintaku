START
TRANSACTION;

CREATE TABLE `users`
(
  `id` bigint
(20) UNSIGNED NOT NULL,
  `name` varchar
(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar
(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar
(191) COLLATE utf8mb4_unicode_ci NOT NULL  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `users`
ADD PRIMARY KEY
(`id`),
ADD UNIQUE KEY `users_email_unique`
(`email`);

ALTER TABLE `users` MODIFY `id` bigint
(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;


START
TRANSACTION;

CREATE TABLE `posts`
(
  `id` bigint
(20) UNSIGNED NOT NULL,
  `title` varchar
(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar
(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint
(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `posts`
ADD PRIMARY KEY
(`id`),
ADD KEY `posts_user_id_foreign`
(`user_id`);

ALTER TABLE `posts`
  MODIFY `id` bigint
(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `posts`
ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY
(`user_id`) REFERENCES `users`
(`id`) ON
DELETE CASCADE ON
UPDATE CASCADE;

COMMIT;


START
TRANSACTION;

CREATE TABLE `comments`
(
  `id` bigint
(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar
(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint
(20) UNSIGNED NOT NULL,
  `post_id` bigint
(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `comments`
ADD PRIMARY KEY
(`id`),
ADD KEY `comments_post_id_foreign`
(`post_id`),
ADD KEY `comments_user_id_foreign`
(`user_id`);

ALTER TABLE `comments`
  MODIFY `id` bigint
(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

ALTER TABLE `comments`
ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY
(`user_id`) REFERENCES `users`
(`id`) ON
DELETE CASCADE ON
UPDATE CASCADE,
ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY
(`post_id`) REFERENCES `posts`
(`id`) ON
DELETE CASCADE ON
UPDATE CASCADE;

COMMIT;