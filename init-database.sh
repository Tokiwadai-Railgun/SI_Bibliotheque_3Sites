mysql -u ladspa-api -p
HtCgdCnvVJN!ik3yQ!U6
CREATE TABLE `Authentication`(
    `person_id` BIGINT NOT NULL,
    `user_name` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`person_id`)
);
CREATE TABLE `Site`(
    `ID` BIGINT NOT NULL,
    `location` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`ID`)
);
CREATE TABLE `Book`(
    `ISBN` BIGINT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `author` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `cover` VARCHAR(255) NOT NULL,
    `site` BIGINT NOT NULL,
    `borrower` BIGINT NOT NULL,
    `reserved` BIGINT NOT NULL,
    PRIMARY KEY(`ISBN`)
);
ALTER TABLE
    `Book` ADD INDEX `book_borrower_index`(`borrower`);
CREATE TABLE `Customer`(
    `ID` BIGINT NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NOT NULL,
    `person_id` BIGINT NOT NULL,
    PRIMARY KEY(`ID`)
);
CREATE TABLE `Employee`(
    `ID` VARCHAR(255) NOT NULL,
    `job` BIGINT NOT NULL,
    `site_id` BIGINT NOT NULL,
    `person_id` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`ID`)
);
ALTER TABLE
    `Employee` ADD INDEX `employee_job_index`(`job`);
CREATE TABLE `tags`(
    `id` BIGINT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);
CREATE TABLE `Address`(
    `ID` BIGINT NOT NULL,
    `street` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `department` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`ID`)
);
CREATE TABLE `Person`(
    `id` BIGINT NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `address_id` BIGINT NOT NULL,
    `role` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);
CREATE TABLE `Permission`(
    `code` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`code`)
);
CREATE TABLE `Book_Tags`(
    `book_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `tag_id` BIGINT NOT NULL
);
CREATE TABLE `Job`(
    `ID` BIGINT NOT NULL,
    `Title` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`ID`)
);
CREATE TABLE `Job_Permission`(
    `job_id` BIGINT NOT NULL,
    `permission_code` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `Job_Permission` ADD INDEX `job_permission_job_id_index`(`job_id`);
ALTER TABLE
    `Job_Permission` ADD INDEX `job_permission_permission_code_index`(`permission_code`);
ALTER TABLE
    `Job_Permission` ADD CONSTRAINT `job_permission_permission_code_foreign` FOREIGN KEY(`permission_code`) REFERENCES `Permission`(`code`);
ALTER TABLE
    `Book` ADD CONSTRAINT `book_reserved_foreign` FOREIGN KEY(`reserved`) REFERENCES `Customer`(`ID`);
ALTER TABLE
    `Book` ADD CONSTRAINT `book_borrower_foreign` FOREIGN KEY(`borrower`) REFERENCES `Customer`(`ID`);
ALTER TABLE
    `Employee` ADD CONSTRAINT `employee_job_foreign` FOREIGN KEY(`job`) REFERENCES `Job`(`ID`);
ALTER TABLE
    `Person` ADD CONSTRAINT `person_address_id_foreign` FOREIGN KEY(`address_id`) REFERENCES `Address`(`ID`);
ALTER TABLE
    `Book` ADD CONSTRAINT `book_isbn_foreign` FOREIGN KEY(`ISBN`) REFERENCES `Book_Tags`(`book_id`);
ALTER TABLE
    `Employee` ADD CONSTRAINT `employee_site_id_foreign` FOREIGN KEY(`site_id`) REFERENCES `Site`(`ID`);
ALTER TABLE
    `Book` ADD CONSTRAINT `book_site_foreign` FOREIGN KEY(`site`) REFERENCES `Site`(`ID`);
ALTER TABLE
    `Employee` ADD CONSTRAINT `employee_person_id_foreign` FOREIGN KEY(`person_id`) REFERENCES `Person`(`id`);
ALTER TABLE
    `Job_Permission` ADD CONSTRAINT `job_permission_job_id_foreign` FOREIGN KEY(`job_id`) REFERENCES `Job`(`ID`);
ALTER TABLE
    `Customer` ADD CONSTRAINT `customer_person_id_foreign` FOREIGN KEY(`person_id`) REFERENCES `Person`(`id`);
ALTER TABLE
    `Person` ADD CONSTRAINT `person_id_foreign` FOREIGN KEY(`id`) REFERENCES `Authentication`(`person_id`);
ALTER TABLE
    `Book_Tags` ADD CONSTRAINT `book_tags_tag_id_foreign` FOREIGN KEY(`tag_id`) REFERENCES `tags`(`id`);
