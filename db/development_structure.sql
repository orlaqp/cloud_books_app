CREATE TABLE "address_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "addresses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "address_type_id" integer, "street" varchar(250), "city" varchar(100), "state" varchar(100), "zip_code" varchar(15), "country_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "addresses_contacts" ("address_id" integer, "contact_id" integer);
CREATE TABLE "contacts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(5), "first_name" varchar(50), "middle" varchar(50), "last_name" varchar(50), "suffix" varchar(15), "job_title" varchar(100), "company" varchar(100), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "contacts_internet_infos" ("contact_id" integer, "internet_info_id" integer);
CREATE TABLE "contacts_phone_numbers" ("contact_id" integer, "phone_number_id" integer);
CREATE TABLE "internet_info_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(100), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "internet_infos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "internet_info_type_id" integer, "description" varchar(150), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "phone_number_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "phone_numbers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "phone_number_type_id" integer, "phone_number" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "firstname" varchar(50), "lastname" varchar(50), "username" varchar(25), "password" varchar(50), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100903194531');

INSERT INTO schema_migrations (version) VALUES ('20100906113339');

INSERT INTO schema_migrations (version) VALUES ('20100920175543');

INSERT INTO schema_migrations (version) VALUES ('20100920175928');

INSERT INTO schema_migrations (version) VALUES ('20100920204315');

INSERT INTO schema_migrations (version) VALUES ('20100921130024');

INSERT INTO schema_migrations (version) VALUES ('20100921131505');

INSERT INTO schema_migrations (version) VALUES ('20100921131723');

INSERT INTO schema_migrations (version) VALUES ('20100921132023');

INSERT INTO schema_migrations (version) VALUES ('20100921132109');

INSERT INTO schema_migrations (version) VALUES ('20100921132328');

INSERT INTO schema_migrations (version) VALUES ('20100921151703');

INSERT INTO schema_migrations (version) VALUES ('20100921152935');

INSERT INTO schema_migrations (version) VALUES ('20100921153319');

INSERT INTO schema_migrations (version) VALUES ('20100921153623');